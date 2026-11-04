"use server";

import { revalidatePath } from "next/cache";
import { getLocale } from "next-intl/server";
import { z } from "zod";
import { redirect } from "@/i18n/navigation";
import { getSession, isAdminRole } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";
import { contentHash } from "./hash";
import { parseImport } from "./import";
import { CONTENT_STATUSES, questionSchema } from "./schema";

export type FormState = {
  status: "idle" | "error" | "success";
  message?: string;
  fields?: Record<string, string>;
  detail?: string;
};

async function requireAdminAction() {
  const { user, profile } = await getSession();
  if (!user || !profile || profile.status !== "active" || !isAdminRole(profile.role)) return null;
  return { user, profile };
}

function fieldErrors(issues: z.core.$ZodIssue[]) {
  const out: Record<string, string> = {};
  for (const i of issues) {
    const k = String(i.path[0] ?? "form");
    if (!out[k]) out[k] = i.message;
  }
  return out;
}

/** Crear o editar una pregunta (siempre como borrador o en revisión). */
export async function saveQuestionAction(_: FormState, formData: FormData): Promise<FormState> {
  if (!(await requireAdminAction())) return { status: "error", message: "forbidden" };
  const id = formData.get("id")?.toString() || null;
  if (id && !z.uuid().safeParse(id).success) return { status: "error", message: "invalid" };
  const parsed = questionSchema.safeParse({
    stem: formData.get("stem"),
    explanation: formData.get("explanation") ?? "",
    category: formData.get("category"),
    difficulty: formData.get("difficulty"),
    locale: formData.get("locale"),
    is_free: formData.get("is_free"),
    ai_generated: formData.get("ai_generated"),
    options: formData
      .getAll("option")
      .map(String)
      .filter((o) => o.trim() !== ""),
    correct: formData.get("correct"),
    exam_body_ids: formData.getAll("exam").map(String),
  });
  if (!parsed.success)
    return { status: "error", message: "invalid", fields: fieldErrors(parsed.error.issues) };

  const supabase = await createClient();
  const { data, error } = await supabase.rpc("upsert_question", {
    p_id: id,
    p: { ...parsed.data, content_hash: contentHash(parsed.data) },
  });
  if (error) {
    if (error.code === "23505") return { status: "error", message: "duplicate" };
    return { status: "error", message: "db", detail: error.message };
  }
  const locale = await getLocale();
  revalidatePath("/[locale]/admin/preguntas", "layout");
  redirect({ href: `/admin/preguntas/${data}?saved=1`, locale });
  return { status: "success" };
}

const transitionSchema = z.object({
  id: z.uuid(),
  to: z.enum(CONTENT_STATUSES),
  comment: z.string().trim().max(2000).optional(),
  back: z.enum(["detail", "queue"]).default("detail"),
});

/** Cambio de estado del flujo de revisión (la BD exige rol owner donde toca). */
export async function transitionAction(_: FormState, formData: FormData): Promise<FormState> {
  if (!(await requireAdminAction())) return { status: "error", message: "forbidden" };
  const parsed = transitionSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "invalid" };
  const { id, to, comment } = parsed.data;
  if (to === "draft" && !comment) return { status: "error", message: "commentRequired" };
  const supabase = await createClient();
  const { error } = await supabase.rpc("review_question", {
    p_id: id,
    p_to: to,
    p_comment: comment ?? null,
  });
  if (error) {
    if (error.code === "42501") return { status: "error", message: "notOwner" };
    return { status: "error", message: "db", detail: error.message };
  }
  revalidatePath("/[locale]/admin", "layout");
  return { status: "success", message: `moved_${to}` };
}

export async function deleteDraftAction(formData: FormData) {
  const locale = await getLocale();
  if (!(await requireAdminAction())) return;
  const id = z.uuid().safeParse(formData.get("id"));
  if (!id.success) return;
  const supabase = await createClient();
  await supabase.from("questions").delete().eq("id", id.data).eq("status", "draft");
  revalidatePath("/[locale]/admin/preguntas", "layout");
  redirect({ href: "/admin/preguntas?deleted=1", locale });
}

export type ImportState = FormState & {
  report?: {
    total: number;
    valid: number;
    imported: number;
    duplicates: number[];
    invalid: { line: number; errors: string[] }[];
  };
};

/** Importación CSV/JSON. Todo entra como borrador y queda auditado. */
export async function importQuestionsAction(
  _: ImportState,
  formData: FormData,
): Promise<ImportState> {
  if (!(await requireAdminAction())) return { status: "error", message: "forbidden" };
  const file = formData.get("file");
  if (!(file instanceof File) || file.size === 0) return { status: "error", message: "noFile" };
  if (file.size > 1_000_000) return { status: "error", message: "too_big" };
  const name = file.name.toLowerCase();
  const format = name.endsWith(".json") ? "json" : name.endsWith(".csv") ? "csv" : null;
  if (!format) return { status: "error", message: "badFormat" };
  const dryRun = formData.get("dry_run") === "on";

  const supabase = await createClient();
  const { data: exams } = await supabase.from("exam_bodies").select("id, slug");
  const examIds = new Map((exams ?? []).map((e) => [e.slug as string, e.id as string]));
  const { rows, fatal } = parseImport(await file.text(), format, examIds);
  if (fatal) return { status: "error", message: fatal };

  const invalid = rows.filter((r) => !r.data).map((r) => ({ line: r.line, errors: r.errors }));
  const valid = rows.filter((r) => r.data);
  const duplicates: number[] = [];
  let imported = 0;
  if (!dryRun) {
    for (const r of valid) {
      const { error } = await supabase.rpc("upsert_question", {
        p_id: null,
        p: { ...r.data!, content_hash: contentHash(r.data!) },
      });
      if (!error) imported++;
      else if (error.code === "23505") duplicates.push(r.line);
      else invalid.push({ line: r.line, errors: ["db"] });
    }
    if (imported > 0) {
      await supabase.rpc("log_admin_action", {
        p_action: "questions.imported",
        p_target_type: "questions",
        p_target_id: null,
        p_metadata: { imported, format, file: file.name.slice(0, 120) },
      });
      revalidatePath("/[locale]/admin/preguntas", "layout");
    }
  }
  return {
    status: "success",
    message: dryRun ? "dryRunDone" : "importDone",
    report: { total: rows.length, valid: valid.length, imported, duplicates, invalid },
  };
}

const batchSchema = z.object({
  topic: z.string().trim().min(1).max(120),
  to: z.enum(["approved", "published"]),
  include_flagged: z.literal("on").optional(),
  confirm: z.literal("on", { message: "confirmRequired" }),
});

/**
 * Aprobación o publicación por lotes de un tema (DEC-006). Solo la persona titular;
 * la BD lo vuelve a comprobar y valida cada pregunta. Las dudosas quedan fuera
 * salvo que se marquen expresamente.
 */
export async function batchReviewAction(_: FormState, formData: FormData): Promise<FormState> {
  const session = await requireAdminAction();
  if (!session) return { status: "error", message: "forbidden" };
  if (session.profile.role !== "owner") return { status: "error", message: "notOwner" };
  const parsed = batchSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    const confirmMissing = parsed.error.issues.some((i) => i.path[0] === "confirm");
    return { status: "error", message: confirmMissing ? "confirmRequired" : "invalid" };
  }
  const { topic, to, include_flagged } = parsed.data;
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("review_topic_batch", {
    p_topic_slug: topic,
    p_to: to,
    p_include_flagged: include_flagged === "on",
  });
  if (error) {
    if (error.code === "42501") return { status: "error", message: "notOwner" };
    return { status: "error", message: "db", detail: error.message };
  }
  revalidatePath("/[locale]/admin", "layout");
  return { status: "success", message: `batch_${to}`, detail: String(data ?? 0) };
}

const publishAllSchema = z.object({
  include_flagged: z.literal("on").optional(),
  confirm: z.literal("on", { message: "confirmRequired" }),
});

/**
 * Un solo clic de la titular: aprueba y publica todo lo pendiente y publica los
 * packs y simulacros que se alimentan de esos temas. La BD valida cada pregunta.
 */
export async function publishAllAction(_: FormState, formData: FormData): Promise<FormState> {
  const session = await requireAdminAction();
  if (!session) return { status: "error", message: "forbidden" };
  if (session.profile.role !== "owner") return { status: "error", message: "notOwner" };
  const parsed = publishAllSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "confirmRequired" };
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("review_all_batch", {
    p_include_flagged: parsed.data.include_flagged === "on",
  });
  if (error) {
    if (error.code === "42501") return { status: "error", message: "notOwner" };
    return { status: "error", message: "db", detail: error.message };
  }
  revalidatePath("/[locale]", "layout");
  const r = (data ?? {}) as { questions?: number; products?: number; notes?: number };
  return {
    status: "success",
    message: "published_all",
    detail: `${r.questions ?? 0}|${r.products ?? 0}|${r.notes ?? 0}`,
  };
}

const notesReviewSchema = z.object({
  topic: z
    .string()
    .trim()
    .regex(/^[a-z0-9-]{2,120}$/)
    .optional()
    .or(z.literal("").transform(() => undefined)),
  to: z.enum(["approved", "published", "both"]),
  confirm: z.literal("on", { message: "confirmRequired" }),
});

/**
 * Aprobar y/o publicar fichas de estudio (CNT-011): una o todas. Solo la titular;
 * la BD lo vuelve a comprobar y deja auditoría por ficha.
 */
export async function reviewNotesAction(_: FormState, formData: FormData): Promise<FormState> {
  const session = await requireAdminAction();
  if (!session) return { status: "error", message: "forbidden" };
  if (session.profile.role !== "owner") return { status: "error", message: "notOwner" };
  const parsed = notesReviewSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    const confirmMissing = parsed.error.issues.some((i) => i.path[0] === "confirm");
    return { status: "error", message: confirmMissing ? "confirmRequired" : "invalid" };
  }
  const { topic, to } = parsed.data;
  const supabase = await createClient();
  let done = 0;
  for (const step of to === "both" ? (["approved", "published"] as const) : [to]) {
    const { data, error } = await supabase.rpc("review_topic_notes", {
      p_topic_slug: topic ?? null,
      p_to: step,
    });
    if (error) {
      if (error.code === "42501") return { status: "error", message: "notOwner" };
      return { status: "error", message: "db", detail: error.message };
    }
    done = Number(data ?? 0);
  }
  revalidatePath("/[locale]", "layout");
  return { status: "success", message: `notes_${to}`, detail: String(done) };
}

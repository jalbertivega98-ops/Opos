"use server";

import { randomInt } from "node:crypto";
import { getLocale } from "next-intl/server";
import { redirect } from "@/i18n/navigation";
import { getSession } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";
import { createServiceClient } from "@/lib/supabase/service";
import {
  availableTypes,
  difficultyPlan,
  generateItem,
  getGenerator,
} from "@/lib/learning/psycho/registry";
import {
  samePresentation,
  toPublicItem,
  type Difficulty,
  type Explanation,
  type PsychoItem,
  type PsychoType,
} from "@/lib/learning/psycho/types";
import { answerSchema, demoAnswerSchema, startPracticeSchema } from "./schema";

const REVIEW_SIZE = 10;

function toRow(item: PsychoItem, extra: Record<string, unknown> = {}) {
  const pub = toPublicItem(item);
  return {
    source: "generator",
    item_type: item.type,
    category: `psycho_${item.type}`,
    difficulty: item.difficulty,
    seed: item.seed,
    generator_version: item.version,
    presented: { presentation: pub.presentation, options: pub.options },
    ...extra,
  };
}

async function activeUserOrRedirect(next: string) {
  const locale = await getLocale();
  const { user, profile } = await getSession();
  if (!user || !profile) redirect({ href: `/entrar?next=${encodeURIComponent(next)}`, locale });
  if (profile!.status !== "active") redirect({ href: "/cuenta-suspendida", locale });
  return { user: user!, locale };
}

/** Inicia una sesión de psicotécnicos y redirige al ejercicio. */
export async function startPracticeAction(formData: FormData) {
  const { user, locale } = await activeUserOrRedirect("/app/practica");
  const parsed = startPracticeSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success || !availableTypes().includes(parsed.data.type)) {
    redirect({ href: "/app/practica?error=invalid", locale });
    return;
  }
  const { type, count, difficulty } = parsed.data;
  const plan = difficultyPlan(
    count,
    difficulty === "auto" ? undefined : (difficulty as Difficulty),
  );
  const items = plan.map((d) => toRow(generateItem(type, randomInt(0, 2 ** 32), d)));

  const { data, error } = await createServiceClient().rpc("practice_start", {
    p_user: user.id,
    p_mode: "psycho",
    p_item_type: type,
    p_items: items,
  });
  if (error || !data) {
    console.error("practice_start", error?.message);
    redirect({ href: "/app/practica?error=start", locale });
    return;
  }
  redirect({ href: `/app/practica/${data}`, locale });
}

/** Sesión de repaso con los últimos fallos sin resolver (mismo ítem, misma semilla). */
export async function startReviewAction() {
  const { user, locale } = await activeUserOrRedirect("/app/practica");
  const supabase = await createClient();
  const { data: failed } = await supabase
    .from("practice_items")
    .select("session_id, position, item_type, seed, difficulty")
    .eq("user_id", user.id)
    .eq("source", "generator")
    .eq("is_correct", false)
    .is("reviewed_at", null)
    .order("answered_at", { ascending: false })
    .limit(50);

  // un mismo ítem fallado varias veces se repasa una sola vez
  const seen = new Set<string>();
  const items = [];
  for (const f of failed ?? []) {
    const key = `${f.item_type}:${f.seed}:${f.difficulty}`;
    if (seen.has(key) || !getGenerator(f.item_type as PsychoType)) continue;
    seen.add(key);
    const item = generateItem(
      f.item_type as PsychoType,
      Number(f.seed),
      f.difficulty as Difficulty,
    );
    items.push(toRow(item, { review_of_session: f.session_id, review_of_position: f.position }));
    if (items.length >= REVIEW_SIZE) break;
  }
  if (items.length === 0) {
    redirect({ href: "/app/practica?review=empty", locale });
    return;
  }
  const { data, error } = await createServiceClient().rpc("practice_start", {
    p_user: user.id,
    p_mode: "review",
    p_item_type: "mixed",
    p_items: items,
  });
  if (error || !data) {
    console.error("practice_start(review)", error?.message);
    redirect({ href: "/app/practica?error=start", locale });
    return;
  }
  redirect({ href: `/app/practica/${data}`, locale });
}

export type AnswerResult =
  | {
      ok: true;
      correct: boolean;
      answerIndex: number;
      explanation: Explanation;
      finished: boolean;
    }
  | { ok: false; error: "invalid" | "auth" | "not_found" | "changed" | "state" };

/**
 * Corrige en servidor (regenerando desde la semilla) y registra la respuesta.
 * La propiedad del ítem se comprueba leyendo con la sesión del alumno (RLS) y
 * otra vez en la función SQL, que además mide el tiempo.
 */
export async function answerPracticeAction(input: unknown): Promise<AnswerResult> {
  const parsed = answerSchema.safeParse(input);
  if (!parsed.success) return { ok: false, error: "invalid" };
  const { sessionId, position, choice } = parsed.data;
  const { user, profile } = await getSession();
  if (!user || profile?.status !== "active") return { ok: false, error: "auth" };

  const supabase = await createClient();
  const { data: row } = await supabase
    .from("practice_items")
    .select("source, item_type, seed, difficulty, generator_version, presented, answered_at")
    .eq("session_id", sessionId)
    .eq("position", position)
    .maybeSingle();
  if (!row || row.source !== "generator") return { ok: false, error: "not_found" };
  if (row.answered_at) return { ok: false, error: "state" };

  const gen = getGenerator(row.item_type as PsychoType);
  if (!gen) return { ok: false, error: "changed" };
  const item = gen.generate(Number(row.seed), row.difficulty as Difficulty);
  const shown = row.presented as Pick<PsychoItem, "presentation" | "options">;
  if (
    item.version !== row.generator_version ||
    !samePresentation(item, shown) ||
    choice >= item.options.length
  ) {
    return { ok: false, error: "changed" };
  }
  const correct = choice === item.answerIndex;

  const { data, error } = await createServiceClient()
    .rpc("practice_record_answer", {
      p_user: user.id,
      p_session: sessionId,
      p_position: position,
      p_chosen: choice,
      p_correct: correct,
      p_answer_index: item.answerIndex,
      p_explanation: item.explanation,
    })
    .single<{ finished: boolean }>();
  if (error || !data) return { ok: false, error: "state" };
  return {
    ok: true,
    correct,
    answerIndex: item.answerIndex,
    explanation: item.explanation,
    finished: data.finished,
  };
}

export type DemoResult =
  { ok: true; correct: boolean; answerIndex: number; explanation: Explanation } | { ok: false };

/**
 * Demo pública y anónima: corrige sin guardar nada. Los resultados anónimos
 * nunca se asocian a una cuenta (decisión de producto, sesión 2).
 */
export async function checkDemoAnswer(input: unknown): Promise<DemoResult> {
  const parsed = demoAnswerSchema.safeParse(input);
  if (!parsed.success || !getGenerator(parsed.data.type)) return { ok: false };
  const { type, seed, difficulty, choice } = parsed.data;
  const item = generateItem(type, seed, difficulty);
  return {
    ok: true,
    correct: choice === item.answerIndex,
    answerIndex: item.answerIndex,
    explanation: item.explanation,
  };
}

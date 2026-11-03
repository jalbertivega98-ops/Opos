"use server";

import { getLocale } from "next-intl/server";
import { redirect } from "@/i18n/navigation";
import { getSession } from "@/lib/auth/session";
import { createServiceClient } from "@/lib/supabase/service";
import { randomInt } from "node:crypto";
import { buildPsychoMock } from "./psycho";
import { saveMockAnswerSchema, startMockSchema, submitMockSchema } from "./schema";

/**
 * Empieza (o reanuda) un simulacro. Acceso, selección por temas y plazo se
 * resuelven en SQL; la solución no llega al navegador hasta entregar.
 */
export async function startMockAction(formData: FormData) {
  const locale = await getLocale();
  const { user, profile } = await getSession();
  if (!user || !profile) {
    redirect({ href: `/entrar?next=${encodeURIComponent("/app/productos")}`, locale });
    return;
  }
  if (profile.status !== "active") {
    redirect({ href: "/cuenta-suspendida", locale });
    return;
  }
  const parsed = startMockSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    redirect({ href: "/app/productos?error=invalid", locale });
    return;
  }
  const service = createServiceClient();
  const { data: product } = await service
    .from("products")
    .select("config")
    .eq("id", parsed.data.productId)
    .maybeSingle<{ config: { kind?: string; questions?: number } }>();
  const psycho = product?.config?.kind === "psycho";
  const { data, error } = psycho
    ? await service.rpc("mock_start_generated", {
        p_user: user.id,
        p_product: parsed.data.productId,
        p_items: buildPsychoMock(Math.min(Math.max(product?.config?.questions ?? 80, 1), 120), () =>
          randomInt(0, 2 ** 32),
        ),
      })
    : await service.rpc("mock_start", { p_user: user.id, p_product: parsed.data.productId });
  if (error || !data) {
    const key =
      error?.code === "42501"
        ? "access"
        : error?.message.includes("suficientes")
          ? "pool"
          : "start";
    redirect({ href: `/app/productos?error=${key}`, locale });
    return;
  }
  redirect({ href: `/app/simulacros/${data}`, locale });
}

export type SaveMockResult = { ok: true } | { ok: false; error: "invalid" | "auth" | "closed" };

/** Guarda una respuesta (o la deja en blanco con null) mientras dura el examen. */
export async function saveMockAnswerAction(input: unknown): Promise<SaveMockResult> {
  const parsed = saveMockAnswerSchema.safeParse(input);
  if (!parsed.success) return { ok: false, error: "invalid" };
  const { user, profile } = await getSession();
  if (!user || profile?.status !== "active") return { ok: false, error: "auth" };
  const { error } = await createServiceClient().rpc("mock_save_answer", {
    p_user: user.id,
    p_attempt: parsed.data.attemptId,
    p_position: parsed.data.position,
    p_chosen: parsed.data.choice,
  });
  if (error)
    return { ok: false, error: error.message.includes("terminado") ? "closed" : "invalid" };
  return { ok: true };
}

/** Entrega y corrige. También se usa cuando se agota el tiempo. */
export async function submitMockAction(input: unknown): Promise<{ ok: boolean }> {
  const parsed = submitMockSchema.safeParse(input);
  if (!parsed.success) return { ok: false };
  const { user, profile } = await getSession();
  if (!user || profile?.status !== "active") return { ok: false };
  const { error } = await createServiceClient().rpc("mock_submit", {
    p_user: user.id,
    p_attempt: parsed.data.attemptId,
  });
  return { ok: !error };
}

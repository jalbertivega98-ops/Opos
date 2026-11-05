"use server";

import { getLocale } from "next-intl/server";
import { redirect } from "@/i18n/navigation";
import { getSession } from "@/lib/auth/session";
import { createServiceClient } from "@/lib/supabase/service";
import { randomInt } from "node:crypto";
import { buildPsychoMock } from "./psycho";
import { saveMockAnswerSchema, startMockSchema, submitMockSchema } from "./schema";

/** Configuración del producto tal como se guarda (sin sanear: lo sanea la base de datos). */
type ProductMockConfig = {
  kind?: string;
  questions?: number;
  item_types?: unknown;
  parts?: { psycho?: boolean; questions?: number; item_types?: unknown }[];
};

/**
 * Empieza (o reanuda) un simulacro. Acceso, selección por temas y plazo se
 * resuelven en SQL; la solución no llega al navegador hasta entregar.
 */
export async function startMockAction(formData: FormData) {
  const locale = await getLocale();
  const { user, profile } = await getSession();
  if (!user || !profile) {
    redirect({ href: `/entrar?next=${encodeURIComponent("/app/simulacros")}`, locale });
    return;
  }
  if (profile.status !== "active") {
    redirect({ href: "/cuenta-suspendida", locale });
    return;
  }
  const parsed = startMockSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    redirect({ href: "/app/simulacros?error=invalid", locale });
    return;
  }
  const service = createServiceClient();
  const { data: product } = await service
    .from("products")
    .select("config")
    .eq("id", parsed.data.productId)
    .maybeSingle<{ config: ProductMockConfig }>();
  const cfg = product?.config;
  const seed = () => randomInt(0, 2 ** 32);
  const sections = cfg?.kind === "sections" && Array.isArray(cfg.parts);
  const { data, error } = sections
    ? await service.rpc("mock_start_sections", {
        p_user: user.id,
        p_product: parsed.data.productId,
        p_items: (cfg?.parts ?? []).flatMap((part) =>
          part?.psycho
            ? buildPsychoMock(
                Math.min(Math.max(Number(part.questions) || 1, 1), 120),
                seed,
                part.item_types,
              )
            : [],
        ),
      })
    : cfg?.kind === "psycho"
      ? await service.rpc("mock_start_generated", {
          p_user: user.id,
          p_product: parsed.data.productId,
          p_items: buildPsychoMock(
            Math.min(Math.max(cfg.questions ?? 80, 1), 120),
            seed,
            cfg.item_types,
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
    redirect({ href: `/app/simulacros?error=${key}`, locale });
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

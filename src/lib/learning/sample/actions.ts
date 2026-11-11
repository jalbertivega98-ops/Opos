"use server";

import { headers } from "next/headers";
import { recordFunnelStep } from "@/lib/analytics/track";
import { createRateLimiter } from "@/lib/rate-limit";
import { createPublicClient } from "@/lib/supabase/public";
import { sampleAnswerSchema, sampleStepSchema, type SampleExplanation } from "./schema";

// Un test tiene 10 preguntas: 40 pasos por IP cada 10 minutos sobra para uso real
// y evita inflar el embudo a base de peticiones.
const stepLimiter = createRateLimiter({ limit: 40, windowMs: 10 * 60 * 1000 });

export type SampleAnswerResult =
  | { ok: true; correct: boolean; answerIndex: number; explanation: SampleExplanation }
  | { ok: false };

/**
 * Corrige una pregunta del test gratis sin registro. Es anónimo y no guarda nada:
 * los resultados anónimos nunca se asocian a una cuenta (ADR-041).
 */
export async function checkSampleAnswerAction(input: unknown): Promise<SampleAnswerResult> {
  const parsed = sampleAnswerSchema.safeParse(input);
  if (!parsed.success) return { ok: false };
  const { exam, questionId, choice } = parsed.data;
  const { data, error } = await createPublicClient()
    .rpc("check_exam_sample_answer", {
      p_exam_slug: exam,
      p_question: questionId,
      p_choice: choice,
    })
    .maybeSingle<{ is_correct: boolean; answer_index: number; explanation: SampleExplanation }>();
  if (error || !data) return { ok: false };
  return {
    ok: true,
    correct: data.is_correct,
    answerIndex: data.answer_index,
    explanation: data.explanation,
  };
}

/**
 * Cuenta que alguien empieza o termina el test gratis (embudo del panel, ADR-047).
 * Solo suma un contador diario por oposición: no guarda IP ni identifica a nadie.
 */
export async function trackSampleStepAction(input: unknown): Promise<void> {
  const parsed = sampleStepSchema.safeParse(input);
  if (!parsed.success) return;
  const h = await headers();
  const ip = h.get("x-forwarded-for")?.split(",")[0]?.trim() || h.get("x-real-ip") || "local";
  if (!stepLimiter(`sample-step:${ip}`).ok) return;
  const { exam, step } = parsed.data;
  await recordFunnelStep(step === "start" ? "sample_start" : "sample_finish", exam);
}

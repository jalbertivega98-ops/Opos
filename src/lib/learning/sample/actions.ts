"use server";

import { createPublicClient } from "@/lib/supabase/public";
import { sampleAnswerSchema, type SampleExplanation } from "./schema";

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

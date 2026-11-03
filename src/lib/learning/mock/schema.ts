import { z } from "zod";
import type { PresentedQuestion, QuestionExplanation } from "@/lib/learning/questions/schema";

export const startMockSchema = z.object({ productId: z.uuid() });

export const saveMockAnswerSchema = z.object({
  attemptId: z.uuid(),
  position: z.number().int().min(0).max(119),
  choice: z.number().int().min(0).max(5).nullable(),
});

export const submitMockSchema = z.object({ attemptId: z.uuid() });

/** Formato efectivo guardado en el intento (mock_config). */
export type MockConfig = {
  questions: number;
  minutes: number;
  penalty: number;
  pass_mark: number;
  max_mark: number;
};

export type MockAttempt = {
  id: string;
  product_id: string | null;
  title: string;
  title_ca: string | null;
  config: MockConfig;
  item_count: number;
  status: "active" | "submitted" | "expired";
  started_at: string;
  deadline: string;
  submitted_at: string | null;
  correct_count: number | null;
  wrong_count: number | null;
  blank_count: number | null;
  void_count: number | null;
  score: number | null;
  mark: number | null;
  passed: boolean | null;
};

export type MockItem = {
  position: number;
  presented: PresentedQuestion;
  chosen_index: number | null;
  is_correct: boolean | null;
  answer_index: number | null;
  explanation: QuestionExplanation | null;
};

/** Nota oficial: max(0, aciertos − fallos·penalización) · nota máxima / preguntas válidas. */
export function mockMark(
  correct: number,
  wrong: number,
  valid: number,
  cfg: Pick<MockConfig, "penalty" | "max_mark">,
) {
  if (valid <= 0) return 0;
  const score = Math.max(0, correct - wrong * cfg.penalty);
  return Math.round(((score * cfg.max_mark) / valid) * 100) / 100;
}

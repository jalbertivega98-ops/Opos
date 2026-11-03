import { z } from "zod";

export const PACK_SIZES = [5, 10, 20, 30] as const;

export const startProductSchema = z.object({
  productId: z.uuid(),
  count: z.coerce
    .number()
    .int()
    .refine((n) => (PACK_SIZES as readonly number[]).includes(n))
    .default(10),
});

export const answerQuestionSchema = z.object({
  sessionId: z.uuid(),
  position: z.number().int().min(0).max(99),
  choice: z.number().int().min(0).max(5),
});

/** Ítem de pregunta tal como se muestra (sin solución). */
export type PresentedQuestion = { stem: string; options: string[]; ref: string | null };
/** Explicación guardada al responder. */
export type QuestionExplanation = { text: string | null; ref: string | null };

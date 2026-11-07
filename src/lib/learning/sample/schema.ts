import { z } from "zod";

/** Respuesta a una pregunta del test gratis sin registro (ADR-041). */
export const sampleAnswerSchema = z.object({
  exam: z.string().regex(/^[a-z0-9-]{2,80}$/),
  questionId: z.uuid(),
  choice: z.number().int().min(0).max(5),
});

/** Pregunta del test gratis tal como se muestra (sin solución). */
export type SampleQuestion = {
  id: string;
  stem: string;
  options: string[];
  ref: string | null;
  locale: string;
  topic: string | null;
};

export type SampleExplanation = { text: string | null; ref: string | null };

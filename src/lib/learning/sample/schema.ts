import { z } from "zod";

/** Respuesta a una pregunta del test gratis sin registro (ADR-041). */
export const sampleAnswerSchema = z.object({
  exam: z.string().regex(/^[a-z0-9-]{2,80}$/),
  questionId: z.uuid(),
  /** null = dejar la pregunta en blanco. */
  choice: z.number().int().min(0).max(5).nullable(),
});

/** Paso del test gratis que cuenta el embudo del panel (ADR-047). */
export const sampleStepSchema = z.object({
  exam: z.string().regex(/^[a-z0-9-]{2,80}$/),
  step: z.enum(["start", "finish", "signup"]),
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

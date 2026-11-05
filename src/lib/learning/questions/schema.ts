import { z } from "zod";

/** Test de un tema (desde el plan o el temario): slug del tema y número de preguntas. */
export const startTopicSchema = z.object({
  topic: z.string().regex(/^[a-z0-9][a-z0-9-]{1,119}$/),
  count: z.coerce.number().int().min(5).max(40).default(10),
  /** Ruta interna a la que volver si hay error. */
  back: z.enum(["/app", "/app/plan", "/app/temario"]).default("/app/temario"),
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

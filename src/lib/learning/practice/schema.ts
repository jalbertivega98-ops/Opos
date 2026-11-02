import { z } from "zod";
import { PSYCHO_TYPES } from "@/lib/learning/psycho/types";

export const SESSION_SIZES = [5, 10, 20] as const;

export const startPracticeSchema = z.object({
  type: z.enum(PSYCHO_TYPES),
  count: z.coerce
    .number()
    .int()
    .refine((n) => (SESSION_SIZES as readonly number[]).includes(n)),
  difficulty: z.union([z.literal("auto"), z.coerce.number().int().min(1).max(5)]).default("auto"),
});

export const answerSchema = z.object({
  sessionId: z.uuid(),
  position: z.number().int().min(0).max(99),
  choice: z.number().int().min(0).max(5),
});

export const demoAnswerSchema = z.object({
  type: z.enum(PSYCHO_TYPES),
  seed: z.number().int().min(0).max(0xffffffff),
  difficulty: z.union([z.literal(1), z.literal(2), z.literal(3), z.literal(4), z.literal(5)]),
  choice: z.number().int().min(0).max(5),
});

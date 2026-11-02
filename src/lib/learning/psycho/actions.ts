"use server";

import { z } from "zod";
import { generateSeries, type SeriesRule } from "./series";

const schema = z.object({
  seed: z.number().int().min(0).max(0xffffffff),
  difficulty: z.union([z.literal(1), z.literal(2), z.literal(3), z.literal(4), z.literal(5)]),
  choice: z.number().int().min(0).max(3),
});

export type SeriesCheck =
  { ok: true; correct: boolean; answerIndex: number; rule: SeriesRule } | { ok: false };

/**
 * Corrige una respuesta regenerando el ítem desde la semilla (determinista):
 * la solución nunca viaja al cliente antes de responder.
 */
export async function checkSeriesAnswer(input: unknown): Promise<SeriesCheck> {
  const parsed = schema.safeParse(input);
  if (!parsed.success) return { ok: false };
  const { seed, difficulty, choice } = parsed.data;
  const item = generateSeries(seed, difficulty);
  return {
    ok: true,
    correct: choice === item.answerIndex,
    answerIndex: item.answerIndex,
    rule: item.rule,
  };
}

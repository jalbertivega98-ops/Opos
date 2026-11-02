import { z } from "zod";

export const CONTENT_STATUSES = [
  "draft",
  "needs_review",
  "approved",
  "published",
  "archived",
] as const;
export type ContentStatus = (typeof CONTENT_STATUSES)[number];

const bool = z.preprocess(
  (v) => v === true || v === "true" || v === "on" || v === "1",
  z.boolean(),
);

export const questionSchema = z
  .object({
    stem: z.string().trim().min(5, { error: "stem" }).max(4000, { error: "stem" }),
    explanation: z.string().trim().max(4000).optional().default(""),
    category: z
      .string()
      .trim()
      .toLowerCase()
      .regex(/^[a-z0-9_-]{2,60}$/, { error: "category" }),
    difficulty: z.coerce.number().int().min(1).max(5),
    locale: z.enum(["es", "ca"]).default("es"),
    is_free: bool.default(false),
    ai_generated: bool.default(false),
    options: z
      .array(z.string().trim().min(1, { error: "option" }).max(1000))
      .min(2, { error: "options" })
      .max(6, { error: "options" }),
    correct: z.coerce.number().int().min(0),
    exam_body_ids: z.array(z.uuid()).max(50).default([]),
  })
  .refine((q) => q.correct < q.options.length, { error: "correct", path: ["correct"] })
  .refine((q) => new Set(q.options.map(normalizeText)).size === q.options.length, {
    error: "duplicate_options",
    path: ["options"],
  });

export type QuestionInput = z.infer<typeof questionSchema>;

/** Normaliza para detectar duplicados: minúsculas, sin tildes ni espacios extra. */
export function normalizeText(s: string) {
  return s.normalize("NFKD").replace(/\p{M}/gu, "").toLowerCase().replace(/\s+/g, " ").trim();
}

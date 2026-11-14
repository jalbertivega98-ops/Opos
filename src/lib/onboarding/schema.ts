import { z } from "zod";
import { localeSchema } from "@/lib/auth/schemas";

export const GOALS = [
  "pass_next_call",
  "improve_psycho",
  "cover_syllabus",
  "practice_mocks",
  "build_habit",
] as const;

export const onboardingSchema = z.object({
  exam: z.string().regex(/^[a-z0-9-]{2,80}$/, "invalid_value"),
  level: z.enum(["beginner", "intermediate", "advanced"]),
  weeklyHours: z.coerce.number().int().min(1).max(80),
  goals: z.array(z.enum(GOALS)).min(1, "too_small").max(GOALS.length),
  notifyConsent: z.boolean(),
  displayName: z
    .string()
    .trim()
    .max(80)
    .optional()
    .transform((v) => (v ? v : undefined)),
  locale: localeSchema,
});

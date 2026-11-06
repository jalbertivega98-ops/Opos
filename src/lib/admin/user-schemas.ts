import { z } from "zod";

const optionalDays = z
  .union([z.literal(""), z.coerce.number().int().min(1).max(3650)])
  .optional()
  .transform((v) => (v === "" || v === undefined ? null : v));

/** Asignar a mano un pack o un Premium desde la ficha del alumno. */
export const userGrantSchema = z.object({
  user: z.uuid(),
  product: z.uuid(),
  days: optionalDays,
  note: z.string().trim().max(500).optional(),
});

/**
 * Código promocional de Stripe para un alumno. El código solo admite lo que
 * acepta Stripe (letras, cifras y guiones); se guarda en mayúsculas.
 */
export const promoCodeSchema = z
  .object({
    user: z.uuid(),
    code: z
      .string()
      .trim()
      .toUpperCase()
      .regex(/^[A-Z0-9-]{3,40}$/, { error: "code" }),
    kind: z.enum(["percent", "amount"]),
    value: z.coerce.number().positive({ error: "value" }),
    duration: z.enum(["once", "repeating", "forever"]),
    months: z
      .union([z.literal(""), z.coerce.number().int().min(1).max(36)])
      .optional()
      .transform((v) => (v === "" || v === undefined ? null : v)),
    expiresDays: z
      .union([z.literal(""), z.coerce.number().int().min(1).max(365)])
      .optional()
      .transform((v) => (v === "" || v === undefined ? null : v)),
    note: z.string().trim().max(500).optional(),
  })
  .refine((v) => v.kind !== "percent" || v.value <= 100, { error: "value", path: ["value"] })
  .refine((v) => v.kind !== "amount" || v.value <= 1000, { error: "value", path: ["value"] })
  .refine((v) => v.duration !== "repeating" || v.months !== null, {
    error: "months",
    path: ["months"],
  });
export type PromoCodeInput = z.infer<typeof promoCodeSchema>;

/** Parámetros del cupón de Stripe a partir del formulario (importes en céntimos). */
export function couponParams(input: PromoCodeInput) {
  return {
    ...(input.kind === "percent"
      ? { percent_off: Math.round(input.value * 100) / 100 }
      : { amount_off: Math.round(input.value * 100), currency: "eur" }),
    duration: input.duration,
    ...(input.duration === "repeating" ? { duration_in_months: input.months ?? 1 } : {}),
    name: input.code,
  };
}

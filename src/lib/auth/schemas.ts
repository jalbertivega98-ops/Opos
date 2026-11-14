import { z } from "zod";
import { optionalRefSchema } from "@/lib/ambassadors/schemas";

export const emailSchema = z.string().trim().toLowerCase().pipe(z.email().max(254));

/** Mínimo 8 caracteres con al menos una letra y un número. */
export const passwordSchema = z
  .string()
  .min(8, "password.min")
  .max(72, "password.max") // límite de bcrypt
  .regex(/[A-Za-zÀ-ÿ]/, "password.letter")
  .regex(/\d/, "password.number");

export const localeSchema = z.enum(["es", "ca"]).catch("es");

export const signUpSchema = z.object({
  email: emailSchema,
  password: passwordSchema,
  displayName: z
    .string()
    .trim()
    .max(80)
    .optional()
    .transform((v) => (v ? v : undefined)),
  next: z.string().max(512).optional(),
  ref: optionalRefSchema,
  locale: localeSchema,
});

export const signInSchema = z.object({
  email: emailSchema,
  password: z.string().min(1).max(72),
  next: z.string().optional(),
  locale: localeSchema,
});

export const oauthSchema = z.object({
  next: z.string().max(512).optional(),
  ref: optionalRefSchema,
  locale: localeSchema,
});

export const forgotSchema = z.object({ email: emailSchema, locale: localeSchema });

export const resetSchema = z
  .object({ password: passwordSchema, confirm: z.string(), locale: localeSchema })
  .refine((d) => d.password === d.confirm, { path: ["confirm"], message: "password.mismatch" });

export type FieldErrors = Partial<Record<string, string>>;

export function fieldErrors(error: z.ZodError): FieldErrors {
  const out: FieldErrors = {};
  for (const issue of error.issues) {
    const key = String(issue.path[0] ?? "form");
    // Mensajes propios son claves i18n ("password.min"); el resto usa el código de Zod.
    const isKey = /^[a-z]+\.[a-zA-Z]+$/.test(issue.message);
    out[key] ??= isKey ? issue.message : issue.code;
  }
  return out;
}

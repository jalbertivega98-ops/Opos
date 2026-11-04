import { z } from "zod";
import { emailSchema, localeSchema, passwordSchema } from "@/lib/auth/schemas";

export const profileSchema = z.object({
  displayName: z.string().trim().max(80, "too_big"),
  locale: z.enum(["es", "ca"]),
  marketingConsent: z.boolean(),
});

export const DELETE_CONFIRM_WORD = { es: "ELIMINAR", ca: "ELIMINAR" } as const;

export const deleteAccountSchema = z.object({
  password: z.string().min(1).max(72),
  confirm: z.literal("ELIMINAR", { error: "confirmWord" }),
  locale: localeSchema,
});

export const changePasswordSchema = z
  .object({
    currentPassword: z.string().min(1).max(72),
    password: passwordSchema,
    confirm: z.string(),
  })
  .refine((d) => d.password === d.confirm, { path: ["confirm"], message: "password.mismatch" });

export const changeEmailSchema = z.object({
  email: emailSchema,
  currentPassword: z.string().min(1).max(72),
  locale: localeSchema,
});

import { z } from "zod";
import { safeNextPath } from "@/lib/paths";

/** Compra: qué producto, a dónde volver si se cancela y el consentimiento legal. */
export const checkoutSchema = z.object({
  slug: z
    .string()
    .trim()
    .regex(/^[a-z0-9]+(-[a-z0-9]+)*$/)
    .max(80),
  back: z
    .string()
    .optional()
    .transform((v) => safeNextPath(v, "/app/productos")),
  // Contenido digital con acceso inmediato: se pide renunciar al desistimiento
  // de forma expresa (art. 103.m TRLGDCU).
  consent: z.literal("on", { error: "consent" }),
});
export type CheckoutInput = z.infer<typeof checkoutSchema>;

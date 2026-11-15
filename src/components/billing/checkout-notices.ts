/** Avisos de compra que llegan en `?compra=` (compartido por servidor y navegador). */
export const CHECKOUT_NOTICES = {
  ok: "success",
  pendiente: "info",
  cancelada: "info",
  consentimiento: "error",
  error: "error",
  desactivada: "info",
  "no-disponible": "error",
  "ya-lo-tienes": "info",
  "ya-premium": "info",
  "portal-error": "error",
} as const;
export type CheckoutNotice = keyof typeof CHECKOUT_NOTICES;

export function parseCheckoutNotice(v: unknown): CheckoutNotice | null {
  return typeof v === "string" && v in CHECKOUT_NOTICES ? (v as CheckoutNotice) : null;
}

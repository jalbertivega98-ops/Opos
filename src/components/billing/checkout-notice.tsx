import { getTranslations } from "next-intl/server";
import { Alert } from "@/components/ui/form";

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

/** Aviso tras volver de Stripe o tras un intento de compra fallido. */
export async function CheckoutNoticeAlert({ notice }: { notice: CheckoutNotice | null }) {
  if (!notice) return null;
  const t = await getTranslations("billing.notices");
  return (
    <Alert tone={CHECKOUT_NOTICES[notice]} className="mt-4">
      <span data-testid="checkout-notice" data-notice={notice}>
        {t(notice)}
      </span>
    </Alert>
  );
}

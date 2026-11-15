import { getTranslations } from "next-intl/server";
import { Alert } from "@/components/ui/form";

import { CHECKOUT_NOTICES, type CheckoutNotice } from "./checkout-notices";

export { CHECKOUT_NOTICES, parseCheckoutNotice, type CheckoutNotice } from "./checkout-notices";

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

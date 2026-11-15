"use client";

import { useSearchParams } from "next/navigation";
import { useTranslations } from "next-intl";
import { Alert } from "@/components/ui/form";
import { CHECKOUT_NOTICES, parseCheckoutNotice } from "./checkout-notices";

/**
 * Aviso de compra leído de `?compra=` en el navegador, para páginas estáticas
 * como la ficha de oposición (ADR-059). Debe ir dentro de `<Suspense>`.
 */
export function CheckoutNoticeFromUrl() {
  const t = useTranslations("billing.notices");
  const notice = parseCheckoutNotice(useSearchParams().get("compra"));
  if (!notice) return null;
  return (
    <Alert tone={CHECKOUT_NOTICES[notice]} className="mt-4">
      <span data-testid="checkout-notice" data-notice={notice}>
        {t(notice)}
      </span>
    </Alert>
  );
}

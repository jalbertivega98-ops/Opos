import "server-only";
import { confirmCheckout } from "@/lib/billing/queries";
import { parseCheckoutNotice } from "@/components/billing/checkout-notice";

/** Aviso de compra al volver de Stripe: confirma la compra aquí mismo (sin esperar al webhook). */
export async function checkoutReturnNotice(
  sp: Record<string, string | string[] | undefined>,
  userId: string,
) {
  const notice = parseCheckoutNotice(sp.compra);
  if (notice !== "ok") return notice;
  const sessionId = typeof sp.session_id === "string" ? sp.session_id : "";
  const confirmed = await confirmCheckout(sessionId, userId);
  return confirmed === "ok" ? "ok" : confirmed === "pending" ? "pendiente" : null;
}

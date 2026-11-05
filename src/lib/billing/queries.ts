import "server-only";
import { fulfillCheckoutSession } from "./core";
import { billingDeps, findCustomer, getStripe } from "./stripe";

/** ¿Hay pagos activos en este despliegue? (para mostrar o desactivar «Comprar») */
export function billingStatus() {
  const billing = getStripe();
  return { enabled: billing !== null, testMode: billing?.provider === "stripe_test" };
}

/** ¿Puede abrir el portal de Stripe? (ya es cliente) */
export async function hasBillingAccount(userId: string) {
  const billing = getStripe();
  return billing ? (await findCustomer(billing.provider, userId)) !== null : false;
}

/**
 * Al volver de Stripe: confirma la compra sin esperar al webhook.
 * Solo vale para una sesión del propio alumno; es idempotente.
 */
export async function confirmCheckout(sessionId: string, userId: string) {
  const billing = getStripe();
  if (!billing || !/^cs_(test|live)_[A-Za-z0-9]+$/.test(sessionId)) return "invalid" as const;
  try {
    const session = await billing.stripe.checkout.sessions.retrieve(sessionId);
    if (session.metadata?.user_id !== userId) return "invalid" as const;
    if (session.livemode !== (billing.provider === "stripe")) return "invalid" as const;
    const r = await fulfillCheckoutSession(session, billingDeps(billing.stripe));
    return r === "paid" || r === "synced" ? ("ok" as const) : ("pending" as const);
  } catch (e) {
    console.error("[checkout confirm]", e);
    return "pending" as const;
  }
}

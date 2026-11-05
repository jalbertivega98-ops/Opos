import type Stripe from "stripe";

/**
 * Lógica de cobros independiente del framework (se prueba sin red ni BD).
 * El pago ocurre en Stripe Checkout; aquí solo se decide qué pedir a Stripe
 * y cómo traducir sus avisos (webhooks) en pedidos, accesos y suscripciones.
 */

export type Provider = "stripe_test" | "stripe";

export type BillingConfig =
  | { enabled: true; provider: Provider; secretKey: string; webhookSecret: string | null }
  | { enabled: false; reason: "missing-key" | "live-blocked" | "invalid-key" };

/**
 * Solo hay cobros reales si joel lo autoriza expresamente: una clave real
 * (sk_live_/rk_live_) no se usa salvo con STRIPE_LIVE_ENABLED=true.
 */
export function billingConfig(env: Record<string, string | undefined>): BillingConfig {
  const key = env.STRIPE_SECRET_KEY?.trim();
  if (!key) return { enabled: false, reason: "missing-key" };
  const webhookSecret = env.STRIPE_WEBHOOK_SECRET?.trim() || null;
  if (/^(sk|rk)_test_/.test(key)) {
    return { enabled: true, provider: "stripe_test", secretKey: key, webhookSecret };
  }
  if (/^(sk|rk)_live_/.test(key)) {
    if (env.STRIPE_LIVE_ENABLED !== "true") return { enabled: false, reason: "live-blocked" };
    return { enabled: true, provider: "stripe", secretKey: key, webhookSecret };
  }
  return { enabled: false, reason: "invalid-key" };
}

export type SubscriptionStatus = "trialing" | "active" | "past_due" | "canceled" | "expired";

/** Estados de Stripe → los nuestros. Solo active/trialing dan acceso. */
export function mapSubscriptionStatus(s: Stripe.Subscription.Status): SubscriptionStatus {
  switch (s) {
    case "active":
      return "active";
    case "trialing":
      return "trialing";
    case "canceled":
      return "canceled";
    case "incomplete_expired":
      return "expired";
    default: // incomplete, past_due, unpaid, paused
      return "past_due";
  }
}

export type CheckoutProduct = {
  id: string;
  slug: string;
  type: string;
  title: string;
  price: { id: string; amount_cents: number; currency: string; interval: "month" | "year" | null };
};

/** Parámetros de la sesión de Checkout. El importe sale SIEMPRE de nuestra BD. */
export function buildCheckoutParams(input: {
  product: CheckoutProduct;
  userId: string;
  customerId: string;
  siteUrl: string;
  locale: "es" | "ca";
  cancelPath: string;
  /** Página de la zona del alumno a la que vuelve tras pagar (por defecto, el perfil). */
  successPath?: string;
}): Stripe.Checkout.SessionCreateParams {
  const { product, userId, customerId, siteUrl, locale, cancelPath } = input;
  const successPath = input.successPath?.startsWith("/app/") ? input.successPath : "/app/perfil";
  const subscription = product.type === "subscription";
  if (subscription !== !!product.price.interval) {
    throw new Error("Precio incompatible con el tipo de producto");
  }
  const base = siteUrl.replace(/\/$/, "") + (locale === "ca" ? "/ca" : "");
  const metadata = { user_id: userId, product_id: product.id, price_id: product.price.id };
  return {
    mode: subscription ? "subscription" : "payment",
    customer: customerId,
    client_reference_id: userId,
    locale: "es",
    // Stripe activa por defecto «Managed Payments» (Stripe como vendedor, exige
    // código fiscal por producto). Lo desactivamos: vendemos nosotros (ADR-027).
    managed_payments: { enabled: false },
    line_items: [
      {
        quantity: 1,
        price_data: {
          currency: product.price.currency.toLowerCase(),
          unit_amount: product.price.amount_cents,
          product_data: { name: product.title, metadata: { product_id: product.id } },
          ...(product.price.interval ? { recurring: { interval: product.price.interval } } : {}),
        },
      },
    ],
    metadata,
    ...(subscription ? { subscription_data: { metadata } } : { payment_intent_data: { metadata } }),
    success_url: `${base}${successPath.split("?")[0]}?compra=ok&session_id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${base}${cancelPath}${cancelPath.includes("?") ? "&" : "?"}compra=cancelada`,
  };
}

/** Lo que el manejador necesita de la base de datos (implementado con service_role). */
export type BillingStore = {
  eventSeen(id: string): Promise<boolean>;
  markEvent(e: { id: string; type: string; livemode: boolean }): Promise<void>;
  recordPayment(p: {
    userId: string;
    productId: string;
    priceId: string | null;
    ref: string;
    amount: number;
    currency: string;
    provider: Provider;
  }): Promise<void>;
  refundPayment(ref: string): Promise<void>;
  syncSubscription(s: {
    userId: string;
    productId: string;
    priceId: string | null;
    ref: string;
    status: SubscriptionStatus;
    periodEnd: string | null;
    cancelAtPeriodEnd: boolean;
    provider: Provider;
  }): Promise<void>;
};

export type BillingDeps = {
  store: BillingStore;
  /** Estado actual de la suscripción en Stripe (los avisos pueden llegar desordenados). */
  retrieveSubscription(id: string): Promise<Stripe.Subscription>;
};

const providerOf = (livemode: boolean): Provider => (livemode ? "stripe" : "stripe_test");
const idOf = (v: string | { id: string } | null | undefined) =>
  typeof v === "string" ? v : (v?.id ?? null);

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
function meta(m: Stripe.Metadata | null | undefined) {
  const userId = m?.user_id;
  const productId = m?.product_id;
  if (!userId || !productId || !UUID.test(userId) || !UUID.test(productId)) return null;
  const priceId = m?.price_id && UUID.test(m.price_id) ? m.price_id : null;
  return { userId, productId, priceId };
}

/** Sincroniza una suscripción leyendo su estado actual en Stripe. */
export async function syncSubscriptionById(id: string, deps: BillingDeps) {
  const sub = await deps.retrieveSubscription(id);
  const m = meta(sub.metadata);
  if (!m) return "ignored" as const;
  // Desde 2025 el fin de periodo vive en cada línea de la suscripción
  const ends = sub.items?.data?.map((i) => i.current_period_end).filter(Boolean) ?? [];
  const periodEnd = ends.length ? new Date(Math.min(...ends) * 1000).toISOString() : null;
  await deps.store.syncSubscription({
    ...m,
    ref: sub.id,
    status: mapSubscriptionStatus(sub.status),
    periodEnd,
    cancelAtPeriodEnd: sub.cancel_at_period_end,
    provider: providerOf(sub.livemode),
  });
  return "synced" as const;
}

/**
 * Da acceso a partir de una sesión de Checkout completada. Se usa desde el
 * webhook y al volver de Stripe (lo que llegue antes); es idempotente.
 */
export async function fulfillCheckoutSession(session: Stripe.Checkout.Session, deps: BillingDeps) {
  if (session.mode === "subscription") {
    const subId = idOf(session.subscription);
    return subId ? syncSubscriptionById(subId, deps) : ("ignored" as const);
  }
  if (session.mode !== "payment" || session.payment_status !== "paid") return "pending" as const;
  const m = meta(session.metadata);
  const ref = idOf(session.payment_intent) ?? session.id;
  if (!m) return "ignored" as const;
  await deps.store.recordPayment({
    ...m,
    ref,
    amount: session.amount_total ?? 0,
    currency: session.currency ?? "eur",
    provider: providerOf(session.livemode),
  });
  return "paid" as const;
}

export const HANDLED_EVENTS = [
  "checkout.session.completed",
  "checkout.session.async_payment_succeeded",
  "customer.subscription.created",
  "customer.subscription.updated",
  "customer.subscription.deleted",
  "charge.refunded",
] as const;

/** Procesa un aviso ya verificado. Repetir el mismo aviso no tiene efecto. */
export async function handleStripeEvent(event: Stripe.Event, deps: BillingDeps) {
  if (!(HANDLED_EVENTS as readonly string[]).includes(event.type)) return "ignored";
  if (await deps.store.eventSeen(event.id)) return "duplicate";
  let result: string;
  switch (event.type) {
    case "checkout.session.completed":
    case "checkout.session.async_payment_succeeded":
      result = await fulfillCheckoutSession(event.data.object, deps);
      break;
    case "customer.subscription.created":
    case "customer.subscription.updated":
    case "customer.subscription.deleted":
      result = await syncSubscriptionById(event.data.object.id, deps);
      break;
    case "charge.refunded": {
      const charge = event.data.object;
      // Solo el reembolso total retira el acceso
      const ref = idOf(charge.payment_intent);
      if (charge.refunded && ref) {
        await deps.store.refundPayment(ref);
        result = "refunded";
      } else result = "partial";
      break;
    }
    default:
      result = "ignored";
  }
  await deps.store.markEvent({ id: event.id, type: event.type, livemode: event.livemode });
  return result;
}

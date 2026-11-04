import { describe, expect, it, vi } from "vitest";
import Stripe from "stripe";
import {
  billingConfig,
  buildCheckoutParams,
  handleStripeEvent,
  mapSubscriptionStatus,
  type BillingDeps,
  type BillingStore,
} from "@/lib/billing/core";
import { checkoutSchema } from "@/lib/billing/schema";

const USER = "11111111-1111-4111-8111-111111111111";
const PRODUCT = "22222222-2222-4222-8222-222222222222";
const PRICE = "33333333-3333-4333-8333-333333333333";
const meta = { user_id: USER, product_id: PRODUCT, price_id: PRICE };

function memoryStore() {
  const seen = new Set<string>();
  const store = {
    eventSeen: vi.fn(async (id: string) => seen.has(id)),
    markEvent: vi.fn(async (e: { id: string }) => void seen.add(e.id)),
    recordPayment: vi.fn(async () => {}),
    refundPayment: vi.fn(async () => {}),
    syncSubscription: vi.fn(async () => {}),
  } satisfies BillingStore;
  return store;
}

function deps(store: BillingStore, sub?: Partial<Stripe.Subscription>): BillingDeps {
  return {
    store,
    retrieveSubscription: vi.fn(
      async (id: string) =>
        ({
          id,
          status: "active",
          livemode: false,
          cancel_at_period_end: false,
          metadata: meta,
          items: { data: [{ current_period_end: 1_900_000_000 }] },
          ...sub,
        }) as unknown as Stripe.Subscription,
    ),
  };
}

const event = (type: string, object: object, id = `evt_${Math.random()}`) =>
  ({ id, type, livemode: false, data: { object } }) as unknown as Stripe.Event;

describe("configuración de cobros", () => {
  it("sin clave, los pagos están desactivados", () => {
    expect(billingConfig({})).toEqual({ enabled: false, reason: "missing-key" });
  });
  it("una clave de pruebas activa el modo test", () => {
    const c = billingConfig({ STRIPE_SECRET_KEY: "sk_test_abc", STRIPE_WEBHOOK_SECRET: "whsec_x" });
    expect(c).toMatchObject({ enabled: true, provider: "stripe_test", webhookSecret: "whsec_x" });
  });
  it("una clave real NO cobra sin autorización expresa (STRIPE_LIVE_ENABLED)", () => {
    expect(billingConfig({ STRIPE_SECRET_KEY: "sk_live_abc" })).toEqual({
      enabled: false,
      reason: "live-blocked",
    });
    expect(
      billingConfig({ STRIPE_SECRET_KEY: "sk_live_abc", STRIPE_LIVE_ENABLED: "true" }),
    ).toMatchObject({ enabled: true, provider: "stripe" });
  });
  it("rechaza claves que no son secretas de Stripe", () => {
    expect(billingConfig({ STRIPE_SECRET_KEY: "pk_test_abc" })).toMatchObject({ enabled: false });
  });
});

describe("estados de suscripción", () => {
  it("solo active/trialing dan acceso", () => {
    expect(mapSubscriptionStatus("active")).toBe("active");
    expect(mapSubscriptionStatus("trialing")).toBe("trialing");
    expect(mapSubscriptionStatus("unpaid")).toBe("past_due");
    expect(mapSubscriptionStatus("incomplete")).toBe("past_due");
    expect(mapSubscriptionStatus("incomplete_expired")).toBe("expired");
    expect(mapSubscriptionStatus("canceled")).toBe("canceled");
  });
});

describe("sesión de Checkout", () => {
  const base = {
    userId: USER,
    customerId: "cus_1",
    siteUrl: "https://oposaprueba.test/",
    cancelPath: "/oposiciones/mossos",
  };
  it("pago único: importe de la BD, metadatos y URLs internas", () => {
    const p = buildCheckoutParams({
      ...base,
      locale: "ca",
      product: {
        id: PRODUCT,
        slug: "pack",
        type: "bundle",
        title: "Pack",
        price: { id: PRICE, amount_cents: 4900, currency: "EUR", interval: null },
      },
    });
    expect(p.mode).toBe("payment");
    expect(p.managed_payments).toEqual({ enabled: false });
    expect(p.line_items?.[0].price_data).toMatchObject({ currency: "eur", unit_amount: 4900 });
    expect(p.line_items?.[0].price_data?.recurring).toBeUndefined();
    expect(p.metadata).toEqual(meta);
    expect(p.payment_intent_data?.metadata).toEqual(meta);
    expect(p.success_url).toBe(
      "https://oposaprueba.test/ca/app/productos?compra=ok&session_id={CHECKOUT_SESSION_ID}",
    );
    expect(p.cancel_url).toBe("https://oposaprueba.test/ca/oposiciones/mossos?compra=cancelada");
  });
  it("Premium: suscripción mensual con metadatos en la suscripción", () => {
    const p = buildCheckoutParams({
      ...base,
      locale: "es",
      product: {
        id: PRODUCT,
        slug: "premium",
        type: "subscription",
        title: "Premium",
        price: { id: PRICE, amount_cents: 1499, currency: "EUR", interval: "month" },
      },
    });
    expect(p.mode).toBe("subscription");
    expect(p.line_items?.[0].price_data?.recurring).toEqual({ interval: "month" });
    expect(p.subscription_data?.metadata).toEqual(meta);
    expect(p.cancel_url).toBe("https://oposaprueba.test/oposiciones/mossos?compra=cancelada");
  });
  it("no mezcla pago único con precio recurrente", () => {
    expect(() =>
      buildCheckoutParams({
        ...base,
        locale: "es",
        product: {
          id: PRODUCT,
          slug: "pack",
          type: "bundle",
          title: "Pack",
          price: { id: PRICE, amount_cents: 100, currency: "EUR", interval: "month" },
        },
      }),
    ).toThrow();
  });
  it("valida el formulario: consentimiento obligatorio y vuelta solo interna", () => {
    expect(checkoutSchema.safeParse({ slug: "premium" }).success).toBe(false);
    const ok = checkoutSchema.parse({ slug: "premium", consent: "on", back: "//evil.com" });
    expect(ok.back).toBe("/app/productos");
  });
});

describe("avisos de Stripe (webhook)", () => {
  it("pago completado → pedido con su payment_intent; repetido no hace nada", async () => {
    const store = memoryStore();
    const e = event(
      "checkout.session.completed",
      {
        id: "cs_test_1",
        mode: "payment",
        payment_status: "paid",
        payment_intent: "pi_1",
        amount_total: 4900,
        currency: "eur",
        livemode: false,
        metadata: meta,
      },
      "evt_1",
    );
    expect(await handleStripeEvent(e, deps(store))).toBe("paid");
    expect(store.recordPayment).toHaveBeenCalledWith({
      userId: USER,
      productId: PRODUCT,
      priceId: PRICE,
      ref: "pi_1",
      amount: 4900,
      currency: "eur",
      provider: "stripe_test",
    });
    expect(await handleStripeEvent(e, deps(store))).toBe("duplicate");
    expect(store.recordPayment).toHaveBeenCalledTimes(1);
  });
  it("pago aún no confirmado (p. ej. transferencia) no da acceso", async () => {
    const store = memoryStore();
    const e = event("checkout.session.completed", {
      mode: "payment",
      payment_status: "unpaid",
      metadata: meta,
      livemode: false,
    });
    expect(await handleStripeEvent(e, deps(store))).toBe("pending");
    expect(store.recordPayment).not.toHaveBeenCalled();
  });
  it("metadatos manipulados o ausentes se ignoran", async () => {
    const store = memoryStore();
    const e = event("checkout.session.completed", {
      mode: "payment",
      payment_status: "paid",
      metadata: { user_id: "x' or 1=1", product_id: PRODUCT },
      livemode: false,
    });
    expect(await handleStripeEvent(e, deps(store))).toBe("ignored");
    expect(store.recordPayment).not.toHaveBeenCalled();
  });
  it("suscripción: se lee su estado actual en Stripe (los avisos llegan desordenados)", async () => {
    const store = memoryStore();
    const d = deps(store, { status: "canceled", cancel_at_period_end: true });
    // el aviso dice «active», pero Stripe ya la tiene cancelada
    const e = event("customer.subscription.updated", { id: "sub_1", status: "active" });
    expect(await handleStripeEvent(e, d)).toBe("synced");
    expect(d.retrieveSubscription).toHaveBeenCalledWith("sub_1");
    expect(store.syncSubscription).toHaveBeenCalledWith({
      userId: USER,
      productId: PRODUCT,
      priceId: PRICE,
      ref: "sub_1",
      status: "canceled",
      periodEnd: new Date(1_900_000_000 * 1000).toISOString(),
      cancelAtPeriodEnd: true,
      provider: "stripe_test",
    });
  });
  it("Checkout de suscripción sincroniza la suscripción creada", async () => {
    const store = memoryStore();
    const e = event("checkout.session.completed", { mode: "subscription", subscription: "sub_9" });
    expect(await handleStripeEvent(e, deps(store))).toBe("synced");
    expect(store.syncSubscription).toHaveBeenCalledWith(expect.objectContaining({ ref: "sub_9" }));
  });
  it("reembolso total retira el acceso; el parcial no", async () => {
    const store = memoryStore();
    await handleStripeEvent(
      event("charge.refunded", { refunded: false, payment_intent: "pi_1" }),
      deps(store),
    );
    expect(store.refundPayment).not.toHaveBeenCalled();
    await handleStripeEvent(
      event("charge.refunded", { refunded: true, payment_intent: "pi_1" }),
      deps(store),
    );
    expect(store.refundPayment).toHaveBeenCalledWith("pi_1");
  });
  it("tipos no gestionados no se registran", async () => {
    const store = memoryStore();
    expect(await handleStripeEvent(event("invoice.created", {}), deps(store))).toBe("ignored");
    expect(store.markEvent).not.toHaveBeenCalled();
  });
  it("la firma se verifica con el secreto del webhook", () => {
    const stripe = new Stripe("sk_test_dummy");
    const payload = JSON.stringify({ id: "evt_sig", object: "event" });
    const header = stripe.webhooks.generateTestHeaderString({ payload, secret: "whsec_a" });
    expect(stripe.webhooks.constructEvent(payload, header, "whsec_a").id).toBe("evt_sig");
    expect(() => stripe.webhooks.constructEvent(payload, header, "whsec_b")).toThrow();
  });
});

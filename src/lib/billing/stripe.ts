import "server-only";
import Stripe from "stripe";
import { createServiceClient } from "@/lib/supabase/service";
import { billingConfig, type BillingDeps, type BillingStore, type Provider } from "./core";

/** Configuración de cobros de este despliegue (sin clave → pagos desactivados). */
export const getBillingConfig = () => billingConfig(process.env);

let client: { key: string; stripe: Stripe } | null = null;

/** Cliente de Stripe o null si los pagos no están activos aquí. */
export function getStripe() {
  const config = getBillingConfig();
  if (!config.enabled) return null;
  if (client?.key !== config.secretKey) {
    client = {
      key: config.secretKey,
      stripe: new Stripe(config.secretKey, { appInfo: { name: "Aprobia" }, telemetry: false }),
    };
  }
  return { stripe: client.stripe, provider: config.provider, webhookSecret: config.webhookSecret };
}

function check(error: { message: string } | null, what: string) {
  if (error) throw new Error(`billing ${what}: ${error.message}`);
}

/** Escrituras de cobros con service_role (las funciones solo admiten ese rol). */
export function serviceBillingStore(): BillingStore {
  const db = createServiceClient();
  return {
    async eventSeen(id) {
      const { data, error } = await db
        .from("billing_events")
        .select("id")
        .eq("id", id)
        .maybeSingle();
      check(error, "eventSeen");
      return !!data;
    },
    async markEvent(e) {
      const { error } = await db
        .from("billing_events")
        .upsert({ id: e.id, type: e.type, livemode: e.livemode }, { ignoreDuplicates: true });
      check(error, "markEvent");
    },
    async recordPayment(p) {
      const { error } = await db.rpc("billing_record_payment", {
        p_user: p.userId,
        p_product: p.productId,
        p_price: p.priceId,
        p_ref: p.ref,
        p_amount: p.amount,
        p_currency: p.currency,
        p_provider: p.provider,
      });
      check(error, "recordPayment");
    },
    async refundPayment(ref) {
      const { error } = await db.rpc("billing_refund_payment", { p_ref: ref });
      check(error, "refundPayment");
    },
    async syncSubscription(s) {
      const { error } = await db.rpc("billing_sync_subscription", {
        p_user: s.userId,
        p_product: s.productId,
        p_price: s.priceId,
        p_ref: s.ref,
        p_status: s.status,
        p_period_end: s.periodEnd,
        p_cancel_at_period_end: s.cancelAtPeriodEnd,
        p_provider: s.provider,
      });
      check(error, "syncSubscription");
    },
  };
}

export function billingDeps(stripe: Stripe): BillingDeps {
  return {
    store: serviceBillingStore(),
    retrieveSubscription: (id) => stripe.subscriptions.retrieve(id),
  };
}

/** Cliente de Stripe del alumno (se crea la primera vez que compra). */
export async function ensureCustomer(
  stripe: Stripe,
  provider: Provider,
  user: { id: string; email?: string | null },
) {
  const db = createServiceClient();
  const { data, error } = await db
    .from("billing_customers")
    .select("customer_ref")
    .eq("user_id", user.id)
    .eq("provider", provider)
    .maybeSingle();
  check(error, "customer");
  if (data) return data.customer_ref as string;
  const customer = await stripe.customers.create(
    { email: user.email ?? undefined, metadata: { user_id: user.id } },
    { idempotencyKey: `customer-${provider}-${user.id}` },
  );
  const { error: ie } = await db
    .from("billing_customers")
    .upsert(
      { user_id: user.id, provider, customer_ref: customer.id },
      { onConflict: "user_id,provider", ignoreDuplicates: true },
    );
  check(ie, "customer insert");
  return customer.id;
}

export async function findCustomer(provider: Provider, userId: string) {
  const db = createServiceClient();
  const { data } = await db
    .from("billing_customers")
    .select("customer_ref")
    .eq("user_id", userId)
    .eq("provider", provider)
    .maybeSingle();
  return (data?.customer_ref as string | undefined) ?? null;
}

import { NextResponse, type NextRequest } from "next/server";
import { handleStripeEvent } from "@/lib/billing/core";
import { billingDeps, getStripe } from "@/lib/billing/stripe";

/**
 * Avisos de Stripe (webhook). Solo se aceptan avisos firmados con
 * STRIPE_WEBHOOK_SECRET; el cuerpo se verifica tal cual llega (sin parsear).
 * Un error devuelve 500 para que Stripe lo reintente; repetir un aviso no
 * duplica nada (ver billing_events y las funciones billing_*).
 */
export async function POST(request: NextRequest) {
  const billing = getStripe();
  if (!billing?.webhookSecret) {
    return NextResponse.json({ error: "billing_disabled" }, { status: 503 });
  }
  const signature = request.headers.get("stripe-signature");
  if (!signature) return NextResponse.json({ error: "missing_signature" }, { status: 400 });
  const body = await request.text();
  let event;
  try {
    event = billing.stripe.webhooks.constructEvent(body, signature, billing.webhookSecret);
  } catch {
    return NextResponse.json({ error: "invalid_signature" }, { status: 400 });
  }
  // Un aviso de cobro real nunca se procesa con una clave de pruebas (y al revés)
  if (event.livemode !== (billing.provider === "stripe")) {
    return NextResponse.json({ received: true, result: "wrong_mode" });
  }
  try {
    const result = await handleStripeEvent(event, billingDeps(billing.stripe));
    return NextResponse.json({ received: true, result });
  } catch (e) {
    console.error("[stripe webhook]", event.type, event.id, e);
    return NextResponse.json({ error: "processing_failed" }, { status: 500 });
  }
}

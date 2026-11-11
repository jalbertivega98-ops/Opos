"use server";

import { getLocale } from "next-intl/server";
import { redirect as externalRedirect } from "next/navigation";
import { redirect } from "@/i18n/navigation";
import { getSession } from "@/lib/auth/session";
import { publicEnv } from "@/lib/env";
import { createClient } from "@/lib/supabase/server";
import { buildCheckoutParams, type CheckoutProduct } from "./core";
import { checkoutSchema } from "./schema";
import { isAttemptsPack } from "@/lib/store/access";
import { ensureCustomer, findCustomer, getStripe } from "./stripe";

const withParam = (path: string, param: string) =>
  `${path}${path.includes("?") ? "&" : "?"}${param}`;

/**
 * Empieza una compra: comprueba sesión, producto publicado con precio activo y
 * que el alumno no lo tenga ya; crea la sesión de Stripe Checkout y redirige.
 * El acceso NO se da aquí: lo da el webhook (o la vuelta de Stripe) al confirmarse el pago.
 */
export async function startCheckoutAction(formData: FormData) {
  const locale = (await getLocale()) as "es" | "ca";
  const parsed = checkoutSchema.safeParse(Object.fromEntries(formData));
  const back = parsed.success ? parsed.data.back : "/app/perfil";
  if (!parsed.success) {
    const consent = parsed.error.issues.some((i) => i.path[0] === "consent");
    redirect({ href: withParam(back, `compra=${consent ? "consentimiento" : "error"}`), locale });
    return;
  }
  const { user, profile } = await getSession();
  if (!user || !profile) {
    redirect({ href: `/entrar?next=${encodeURIComponent(back)}`, locale });
    return;
  }
  if (profile.status !== "active") {
    redirect({ href: "/cuenta-suspendida", locale });
    return;
  }
  const billing = getStripe();
  if (!billing) {
    redirect({ href: withParam(back, "compra=desactivada"), locale });
    return;
  }

  const supabase = await createClient();
  const { data: row } = await supabase
    .from("products")
    .select(
      "id, slug, type, title, title_ca, status, is_test, config, prices:product_prices(id, amount_cents, currency, billing_interval, active)",
    )
    .eq("slug", parsed.data.slug)
    .eq("status", "published")
    .maybeSingle();
  const prices = (row?.prices ?? []) as {
    id: string;
    amount_cents: number;
    currency: string;
    billing_interval: "month" | "year" | null;
    active: boolean;
  }[];
  // Premium: el intervalo elegido (mensual por defecto, o anual); el resto, su pago único
  const active = prices.filter((p) => p.active && p.amount_cents > 0);
  const wanted = parsed.data.interval ?? "month";
  const price =
    row?.type === "subscription"
      ? (active.find((p) => p.billing_interval === wanted) ??
        (parsed.data.interval ? undefined : active.find((p) => p.billing_interval === "year")))
      : active.find((p) => p.billing_interval === null);
  if (!row || !price || row.is_test) {
    redirect({ href: withParam(back, "compra=no-disponible"), locale });
    return;
  }

  // ¿Ya lo tiene? (Premium de esa oposición, compra previa o incluido en un pack).
  // Los packs de intentos (config.attempts) se pueden comprar las veces que se quiera.
  const attemptsPack = row.type === "bundle" && isAttemptsPack(row);
  if (row.type === "subscription") {
    const { data: subs } = await supabase
      .from("subscriptions")
      .select("product_id, product:products(exam_body_id)")
      .eq("user_id", user.id)
      .in("status", ["active", "trialing"]);
    const already = (
      (subs ?? []) as unknown as {
        product_id: string;
        product: { exam_body_id: string | null } | null;
      }[]
    ).some((s) => s.product_id === row.id || s.product?.exam_body_id === null);
    if (already) {
      redirect({ href: "/app/perfil?compra=ya-premium", locale });
      return;
    }
  } else if (!attemptsPack) {
    const { data: has } = await supabase.rpc("my_product_access", { p_product: row.id });
    if (has) {
      redirect({ href: "/app/perfil?compra=ya-lo-tienes", locale });
      return;
    }
  }

  const product: CheckoutProduct = {
    id: row.id,
    slug: row.slug,
    type: row.type,
    title: (locale === "ca" && row.title_ca) || row.title,
    price: {
      id: price.id,
      amount_cents: price.amount_cents,
      currency: price.currency,
      interval: price.billing_interval,
    },
  };
  let url: string | null = null;
  try {
    const customerId = await ensureCustomer(billing.stripe, billing.provider, user);
    const session = await billing.stripe.checkout.sessions.create(
      buildCheckoutParams({
        product,
        userId: user.id,
        customerId,
        siteUrl: publicEnv.NEXT_PUBLIC_SITE_URL,
        locale,
        cancelPath: back,
        successPath: back,
      }),
    );
    url = session.url;
  } catch (e) {
    console.error("[checkout]", e);
  }
  if (!url) {
    redirect({ href: withParam(back, "compra=error"), locale });
    return;
  }
  externalRedirect(url);
}

/** Portal de Stripe: cambiar tarjeta, ver facturas o cancelar Premium. */
export async function openBillingPortalAction() {
  const locale = await getLocale();
  const { user } = await getSession();
  if (!user) {
    redirect({ href: "/entrar?next=/app/perfil", locale });
    return;
  }
  const billing = getStripe();
  const customer = billing ? await findCustomer(billing.provider, user.id) : null;
  let url: string | null = null;
  if (billing && customer) {
    try {
      const base =
        publicEnv.NEXT_PUBLIC_SITE_URL.replace(/\/$/, "") + (locale === "ca" ? "/ca" : "");
      const session = await billing.stripe.billingPortal.sessions.create({
        customer,
        return_url: `${base}/app/perfil`,
      });
      url = session.url;
    } catch (e) {
      console.error("[billing portal]", e);
    }
  }
  if (!url) {
    redirect({ href: "/app/perfil?compra=portal-error", locale });
    return;
  }
  externalRedirect(url);
}

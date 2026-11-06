"use server";

import { revalidatePath } from "next/cache";
import { z } from "zod";
import { getSession, isAdminRole } from "@/lib/auth/session";
import { ensureCustomer, getStripe } from "@/lib/billing/stripe";
import { createClient } from "@/lib/supabase/server";
import { createServiceClient } from "@/lib/supabase/service";
import { couponParams, promoCodeSchema, userGrantSchema } from "./user-schemas";

const schema = z.object({
  id: z.uuid(),
  status: z.enum(["active", "suspended"]),
});

export type AdminActionState = { status: "idle" | "error" | "success"; message?: string };

export async function setUserStatusAction(
  _: AdminActionState,
  formData: FormData,
): Promise<AdminActionState> {
  const parsed = schema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "errors.generic" };
  const supabase = await createClient();
  const { error } = await supabase.rpc("admin_set_user_status", {
    p_id: parsed.data.id,
    p_status: parsed.data.status,
  });
  if (error) {
    return {
      status: "error",
      message: error.code === "42501" ? "adminUsers.notAllowed" : "errors.generic",
    };
  }
  revalidatePath("/[locale]/admin/alumnos/[id]", "page");
  return { status: "success", message: "adminUsers.statusSaved" };
}

async function currentAdmin() {
  const { user, profile } = await getSession();
  return user && profile?.status === "active" && isAdminRole(profile.role) ? user : null;
}

const refreshUser = () => revalidatePath("/[locale]/admin/alumnos/[id]", "page");

/** Asignar a mano un pack (concesión) o un Premium (suscripción sin Stripe). Auditado en BD. */
export async function grantUserProductAction(
  _: AdminActionState,
  formData: FormData,
): Promise<AdminActionState> {
  if (!(await currentAdmin())) return { status: "error", message: "adminUsers.notAllowed" };
  const parsed = userGrantSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "adminUsers.insights.invalid" };
  const { user, product, days, note } = parsed.data;
  const supabase = await createClient();
  const { data: row } = await supabase
    .from("products")
    .select("type")
    .eq("id", product)
    .maybeSingle();
  if (!row) return { status: "error", message: "adminUsers.insights.invalid" };
  const { error } =
    row.type === "subscription"
      ? await supabase.rpc("admin_grant_premium", {
          p_user: user,
          p_product: product,
          p_days: days,
          p_note: note || null,
        })
      : await supabase.rpc("admin_grant_access", {
          p_user: user,
          p_product: product,
          p_days: days,
          p_note: note || null,
        });
  if (error) return { status: "error", message: "errors.generic" };
  refreshUser();
  return { status: "success", message: "adminUsers.insights.granted" };
}

export async function revokeUserGrantAction(formData: FormData) {
  if (!(await currentAdmin())) return;
  const id = z.uuid().safeParse(formData.get("id"));
  if (!id.success) return;
  const supabase = await createClient();
  await supabase.rpc("admin_revoke_access", { p_grant: id.data });
  refreshUser();
}

export async function endUserPremiumAction(formData: FormData) {
  if (!(await currentAdmin())) return;
  const id = z.uuid().safeParse(formData.get("id"));
  if (!id.success) return;
  const supabase = await createClient();
  await supabase.rpc("admin_end_premium", { p_subscription: id.data });
  refreshUser();
}

/**
 * Crea en Stripe un cupón y un código promocional que solo puede usar este
 * alumno (una vez) y lo apunta en su ficha. El alumno lo escribe en la página
 * de pago de Stripe («Añadir código promocional»).
 */
export async function createPromoCodeAction(
  _: AdminActionState,
  formData: FormData,
): Promise<AdminActionState> {
  if (!(await currentAdmin())) return { status: "error", message: "adminUsers.notAllowed" };
  const parsed = promoCodeSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    const field = String(parsed.error.issues[0]?.path[0] ?? "");
    return {
      status: "error",
      message: ["code", "value", "months"].includes(field)
        ? `adminUsers.promo.errors.${field}`
        : "adminUsers.insights.invalid",
    };
  }
  const input = parsed.data;
  const billing = getStripe();
  if (!billing) return { status: "error", message: "adminUsers.promo.errors.billingOff" };

  const { data: target } = await createServiceClient().auth.admin.getUserById(input.user);
  if (!target.user) return { status: "error", message: "adminUsers.insights.invalid" };

  const expiresAt = input.expiresDays
    ? new Date(Date.now() + input.expiresDays * 86_400_000)
    : null;
  let coupon: { id: string };
  let promo: { id: string };
  try {
    const customer = await ensureCustomer(billing.stripe, billing.provider, {
      id: target.user.id,
      email: target.user.email,
    });
    coupon = await billing.stripe.coupons.create({
      ...couponParams(input),
      metadata: { user_id: input.user, created_from: "admin" },
    });
    promo = await billing.stripe.promotionCodes.create({
      promotion: { type: "coupon", coupon: coupon.id },
      code: input.code,
      customer,
      max_redemptions: 1,
      ...(expiresAt ? { expires_at: Math.floor(expiresAt.getTime() / 1000) } : {}),
      metadata: { user_id: input.user },
    });
  } catch (e) {
    console.error("[promo code]", e);
    const taken = e instanceof Error && /already exists|exists/i.test(e.message);
    return {
      status: "error",
      message: taken ? "adminUsers.promo.errors.taken" : "adminUsers.promo.errors.stripe",
    };
  }
  const supabase = await createClient();
  const { error } = await supabase.rpc("admin_record_promo_code", {
    p_user: input.user,
    p_code: input.code,
    p_provider: billing.provider,
    p_coupon_ref: coupon.id,
    p_promotion_code_ref: promo.id,
    p_percent_off: input.kind === "percent" ? input.value : null,
    p_amount_off_cents: input.kind === "amount" ? Math.round(input.value * 100) : null,
    p_duration: input.duration,
    p_duration_in_months: input.duration === "repeating" ? input.months : null,
    p_expires_at: expiresAt?.toISOString() ?? null,
    p_note: input.note || null,
  });
  if (error) {
    console.error("[promo code] registro", error.message);
    return { status: "error", message: "adminUsers.promo.errors.record" };
  }
  refreshUser();
  return { status: "success", message: "adminUsers.promo.created" };
}

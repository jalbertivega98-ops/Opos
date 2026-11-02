"use server";

import { revalidatePath } from "next/cache";
import { getLocale } from "next-intl/server";
import { z } from "zod";
import { redirect } from "@/i18n/navigation";
import { getSession, isAdminRole } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";
import { grantSchema, productSchema } from "./schema";

export type StoreState = { status: "idle" | "error" | "success"; message?: string; field?: string };

async function admin() {
  const { user, profile } = await getSession();
  return user && profile?.status === "active" && isAdminRole(profile.role) ? user : null;
}

/** Crear o editar un producto y su precio (sin cobros: solo catálogo). */
export async function saveProductAction(_: StoreState, formData: FormData): Promise<StoreState> {
  if (!(await admin())) return { status: "error", message: "forbidden" };
  const id = formData.get("id")?.toString() || null;
  if (id && !z.uuid().safeParse(id).success) return { status: "error", message: "invalid" };
  const parsed = productSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) {
    const first = parsed.error.issues[0];
    return { status: "error", message: "invalid", field: String(first?.path[0] ?? first?.message) };
  }
  const { price, interval, ...fields } = parsed.data;
  const supabase = await createClient();
  const write = id
    ? supabase.from("products").update(fields).eq("id", id).select("id").single()
    : supabase.from("products").insert(fields).select("id").single();
  const { data, error } = await write;
  if (error || !data) {
    return { status: "error", message: error?.code === "23505" ? "slugTaken" : "db" };
  }
  const productId = data.id as string;

  // Precio: se conserva el histórico; se desactiva el anterior del mismo intervalo
  if (price !== null) {
    const billing = interval === "once" ? null : interval;
    const { data: current } = await supabase
      .from("product_prices")
      .select("id, amount_cents, billing_interval")
      .eq("product_id", productId)
      .eq("active", true);
    const same = (current ?? []).find((p) => p.billing_interval === billing);
    if (!same || same.amount_cents !== price) {
      if (same) await supabase.from("product_prices").update({ active: false }).eq("id", same.id);
      const { error: pe } = await supabase
        .from("product_prices")
        .insert({ product_id: productId, amount_cents: price, billing_interval: billing });
      if (pe) return { status: "error", message: "db" };
    }
  }
  revalidatePath("/[locale]/admin/productos", "layout");
  const locale = await getLocale();
  redirect({ href: `/admin/productos/${productId}?saved=1`, locale });
  return { status: "success" };
}

/** Selecciona las preguntas (revisadas) que forman un pack o simulacro. */
export async function setProductQuestionsAction(
  _: StoreState,
  formData: FormData,
): Promise<StoreState> {
  if (!(await admin())) return { status: "error", message: "forbidden" };
  const id = z.uuid().safeParse(formData.get("id"));
  const ids = z.array(z.uuid()).max(500).safeParse(formData.getAll("question").map(String));
  if (!id.success || !ids.success) return { status: "error", message: "invalid" };
  const supabase = await createClient();
  const { error: de } = await supabase
    .from("product_items")
    .delete()
    .eq("product_id", id.data)
    .not("question_id", "is", null);
  if (de) return { status: "error", message: "db" };
  if (ids.data.length) {
    const { error } = await supabase
      .from("product_items")
      .insert(ids.data.map((q, i) => ({ product_id: id.data, question_id: q, position: i })));
    if (error) return { status: "error", message: "db" };
  }
  revalidatePath("/[locale]/admin/productos/[id]", "page");
  return { status: "success", message: "itemsSaved" };
}

/** Concesión manual de acceso (regalo, prueba, incidencia). Auditada en BD. */
export async function grantAccessAction(_: StoreState, formData: FormData): Promise<StoreState> {
  if (!(await admin())) return { status: "error", message: "forbidden" };
  const parsed = grantSchema.safeParse(Object.fromEntries(formData));
  if (!parsed.success) return { status: "error", message: "invalid" };
  const { email, product, days, note } = parsed.data;
  const supabase = await createClient();
  const { data: users } = await supabase.rpc("admin_list_users", { p_query: email, p_limit: 5 });
  const user = ((users ?? []) as { id: string; email: string }[]).find(
    (u) => u.email.toLowerCase() === email.toLowerCase(),
  );
  if (!user) return { status: "error", message: "userNotFound" };
  const { error } = await supabase.rpc("admin_grant_access", {
    p_user: user.id,
    p_product: product,
    p_days: days,
    p_note: note || null,
  });
  if (error) return { status: "error", message: "db" };
  revalidatePath("/[locale]/admin/compras", "page");
  return { status: "success", message: "granted" };
}

export async function revokeAccessAction(formData: FormData) {
  if (!(await admin())) return;
  const id = z.uuid().safeParse(formData.get("id"));
  if (!id.success) return;
  const supabase = await createClient();
  await supabase.rpc("admin_revoke_access", { p_grant: id.data });
  revalidatePath("/[locale]/admin/compras", "page");
}

import "server-only";
import { createClient } from "@/lib/supabase/server";

export type ProductRow = {
  id: string;
  slug: string;
  type: string;
  status: string;
  title: string;
  title_ca: string | null;
  description: string | null;
  description_ca: string | null;
  exam_body_id: string | null;
  is_free: boolean;
  included_in_premium: boolean;
  updated_at: string;
  prices: { id: string; amount_cents: number; billing_interval: string | null; active: boolean }[];
};

const COLS =
  "id, slug, type, status, title, title_ca, description, description_ca, exam_body_id, is_free, included_in_premium, updated_at, prices:product_prices(id, amount_cents, billing_interval, active)";

export async function listProducts() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("products")
    .select(COLS)
    .order("updated_at", { ascending: false });
  return (data ?? []) as unknown as ProductRow[];
}

export async function getProduct(id: string) {
  const supabase = await createClient();
  const [{ data: product }, { data: items }] = await Promise.all([
    supabase.from("products").select(COLS).eq("id", id).maybeSingle(),
    supabase
      .from("product_items")
      .select("question_id")
      .eq("product_id", id)
      .not("question_id", "is", null),
  ]);
  if (!product) return null;
  return {
    product: product as unknown as ProductRow,
    questionIds: (items ?? []).map((i) => i.question_id as string),
  };
}

/** Preguntas que pueden incluirse en un producto (solo revisadas). */
export async function reviewedQuestions(limit = 200) {
  const supabase = await createClient();
  const { data } = await supabase
    .from("questions")
    .select("id, stem, category, status")
    .in("status", ["approved", "published"])
    .order("category")
    .limit(limit);
  return (data ?? []) as { id: string; stem: string; category: string; status: string }[];
}

export type Purchase = {
  kind: "order" | "grant" | "subscription";
  id: string;
  user_id: string | null;
  email: string | null;
  product_title: string | null;
  status: string;
  amount_cents: number | null;
  source: string;
  created_at: string;
  ends_at: string | null;
};

export async function listPurchases(limit = 100) {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_list_purchases", {
    p_limit: limit,
    p_offset: 0,
  });
  if (error) throw new Error(`purchases: ${error.message}`);
  return (data ?? []) as Purchase[];
}

export type LibraryItem = {
  product_id: string;
  slug: string;
  type: string;
  title: string;
  title_ca: string | null;
  source: string;
  ends_at: string | null;
};

export async function myLibrary() {
  const supabase = await createClient();
  const { data } = await supabase.rpc("my_library");
  return (data ?? []) as LibraryItem[];
}

/** Precio activo de Premium para mostrarlo (configurable en el panel). */
export async function premiumPrice() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("products")
    .select("status, prices:product_prices(amount_cents, billing_interval, active)")
    .eq("slug", "premium")
    .maybeSingle();
  const p = (
    data?.prices as
      { amount_cents: number; billing_interval: string | null; active: boolean }[] | undefined
  )?.find((x) => x.active && x.billing_interval === "month");
  return p?.amount_cents ?? null;
}

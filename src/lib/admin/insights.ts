import "server-only";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

export type UserInsights = {
  subscriptions: {
    id: string;
    product: string;
    status: string;
    provider: "none" | "stripe_test" | "stripe";
    current_period_end: string | null;
    cancel_at_period_end: boolean;
    created_at: string;
    active: boolean;
  }[];
  grants: {
    id: string;
    product: string;
    product_type: string;
    source: string;
    note: string | null;
    starts_at: string;
    ends_at: string | null;
    created_at: string;
    attempts: number | null;
    status: "active" | "expired" | "revoked";
  }[];
  orders: {
    id: string;
    status: string;
    total_cents: number;
    currency: string;
    provider: string;
    created_at: string;
    products: string | null;
  }[];
  promo_codes: {
    id: string;
    code: string;
    provider: string;
    percent_off: number | null;
    amount_off_cents: number | null;
    duration: "once" | "repeating" | "forever";
    duration_in_months: number | null;
    expires_at: string | null;
    note: string | null;
    created_at: string;
  }[];
  sessions: { action: string; created_at: string }[];
  presence: {
    today_seconds: number;
    last7_seconds: number;
    last30_seconds: number;
    days: { day: string; seconds: number; first_seen: string; last_seen: string }[];
  };
  study: {
    practice_count: number;
    answered: number;
    correct: number;
    answer_seconds: number;
    mock_count: number;
    recent: {
      kind: "practice" | "mock";
      started_at: string;
      finished_at: string | null;
      status: string;
      mode: string;
      item_type: string | null;
      answered: number;
      correct: number;
      total: number;
      title: string | null;
      mark: number | null;
      max_mark: number | null;
      passed: boolean | null;
    }[];
  };
};

/** Accesos, códigos, entradas, tiempo dentro y estudio de un alumno (auditado en BD). */
export async function getUserInsights(id: string) {
  if (!z.uuid().safeParse(id).success) return null;
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_user_insights", { p_id: id });
  if (error) throw new Error(`admin insights: ${error.message}`);
  return data as UserInsights | null;
}

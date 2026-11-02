import "server-only";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

export const PAGE_SIZE = 25;

export const userFilterSchema = z.object({
  q: z.string().trim().max(80).optional().catch(undefined),
  status: z.enum(["active", "suspended", "pending_deletion"]).optional().catch(undefined),
  role: z.enum(["student", "editor", "admin", "owner"]).optional().catch(undefined),
  exam: z
    .string()
    .regex(/^[a-z0-9-]{2,80}$/)
    .optional()
    .catch(undefined),
  onboarded: z.enum(["yes", "no"]).optional().catch(undefined),
  page: z.coerce.number().int().min(1).max(10_000).catch(1),
});
export type UserFilter = z.infer<typeof userFilterSchema>;

export type AdminUserRow = {
  id: string;
  email: string;
  display_name: string | null;
  role: string;
  status: string;
  locale: string;
  created_at: string;
  last_active_at: string | null;
  onboarding_completed_at: string | null;
  primary_exam: string | null;
  total_count: number;
};

export async function listUsers(
  filter: UserFilter,
  {
    limit = PAGE_SIZE,
    offset = (filter.page - 1) * PAGE_SIZE,
  }: { limit?: number; offset?: number } = {},
) {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_list_users", {
    p_query: filter.q ?? null,
    p_status: filter.status ?? null,
    p_role: filter.role ?? null,
    p_exam: filter.exam ?? null,
    p_onboarded: filter.onboarded ? filter.onboarded === "yes" : null,
    p_limit: limit,
    p_offset: offset,
  });
  if (error) throw new Error(`admin users: ${error.message}`);
  const rows = (data ?? []) as AdminUserRow[];
  return { rows, total: rows[0] ? Number(rows[0].total_count) : 0 };
}

export type AdminUserDetail = {
  id: string;
  email: string;
  email_confirmed_at: string | null;
  last_sign_in_at: string | null;
  display_name: string | null;
  role: string;
  status: "active" | "suspended" | "pending_deletion";
  locale: string;
  created_at: string;
  last_active_at: string | null;
  onboarding_completed_at: string | null;
  marketing_consent: boolean;
  targets: {
    exam: string;
    name: string;
    is_primary: boolean;
    follow_only: boolean;
    level: string | null;
    weekly_hours: number | null;
    goals: string[];
  }[];
  activity: { kind: string; created_at: string }[];
};

export async function getUser(id: string) {
  if (!z.uuid().safeParse(id).success) return null;
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_get_user", { p_id: id });
  if (error) throw new Error(`admin user: ${error.message}`);
  return data as AdminUserDetail | null;
}

export { csvCell } from "./csv";

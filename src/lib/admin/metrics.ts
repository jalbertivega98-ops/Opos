import "server-only";
import { createClient } from "@/lib/supabase/server";

/**
 * Métricas reales del panel de administración. Se consultan con la sesión
 * del administrador: RLS (is_admin) autoriza la lectura de todos los perfiles.
 */
export async function getUserMetrics(now = new Date()) {
  const supabase = await createClient();
  const weekAgo = new Date(now.getTime() - 7 * 24 * 3600 * 1000).toISOString();
  const count = { count: "exact" as const, head: true };

  const [total, newUsers, active, onboarded, targets, recent] = await Promise.all([
    supabase.from("profiles").select("id", count),
    supabase.from("profiles").select("id", count).gte("created_at", weekAgo),
    supabase.from("profiles").select("id", count).gte("last_active_at", weekAgo),
    supabase.from("profiles").select("id", count).not("onboarding_completed_at", "is", null),
    supabase.from("user_exam_targets").select("exam:exam_bodies(slug, name)").limit(5000),
    supabase
      .from("profiles")
      .select("id, display_name, role, status, created_at, last_active_at")
      .order("created_at", { ascending: false })
      .limit(10),
  ]);

  for (const r of [total, newUsers, active, onboarded, targets, recent]) {
    if (r.error) throw new Error(`admin metrics: ${r.error.message}`);
  }

  const tally = new Map<string, { name: string; count: number }>();
  for (const row of (targets.data ?? []) as unknown as {
    exam: { slug: string; name: string } | null;
  }[]) {
    if (!row.exam) continue;
    const cur = tally.get(row.exam.slug) ?? { name: row.exam.name, count: 0 };
    cur.count += 1;
    tally.set(row.exam.slug, cur);
  }
  const topExams = [...tally.entries()]
    .map(([slug, v]) => ({ slug, ...v }))
    .sort((a, b) => b.count - a.count)
    .slice(0, 5);

  return {
    totalUsers: total.count ?? 0,
    newUsers7d: newUsers.count ?? 0,
    active7d: active.count ?? 0,
    onboarded: onboarded.count ?? 0,
    topExams,
    recentUsers: recent.data ?? [],
  };
}

export type PracticeMetrics = {
  sessions_total: number;
  sessions_finished_7d: number;
  answers_7d: number;
  practicing_users_7d: number;
  by_type: { item_type: string; answered: number; correct: number; avg_time_ms: number }[];
};

/** Métricas agregadas de práctica (función SQL restringida a administradores). */
export async function getPracticeMetrics(): Promise<PracticeMetrics> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_practice_metrics");
  if (error) throw new Error(`admin practice metrics: ${error.message}`);
  return data as PracticeMetrics;
}

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

export type AudienceMetrics = {
  users_total: number;
  users_confirmed: number;
  signups_today: number;
  signups_7d: number;
  signups_30d: number;
  logins_today: number;
  logins_7d: number;
  logins_30d: number;
  visits_today: number;
  visits_7d: number;
  visits_30d: number;
};

/** Registrados, entradas (inicio de sesión) y visitas contadas (ADR-037). Solo administradores. */
export async function getAudienceMetrics(): Promise<AudienceMetrics> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_audience_metrics");
  if (error) throw new Error(`admin audience metrics: ${error.message}`);
  return data as AudienceMetrics;
}

export type AudienceDay = { day: string; visits: number; signups: number; logins: number };

/** Serie diaria de los últimos `days` días (hora de Madrid) para la gráfica del panel. */
export async function getAudienceDaily(days = 30): Promise<AudienceDay[]> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_audience_daily", { p_days: days });
  if (error) throw new Error(`admin audience daily: ${error.message}`);
  return ((data ?? []) as { day: string; visits: number; signups: number; logins: number }[]).map(
    (r) => ({
      day: String(r.day),
      visits: Number(r.visits),
      signups: Number(r.signups),
      logins: Number(r.logins),
    }),
  );
}

export const FUNNEL_STEPS = [
  "visits",
  "sample_start",
  "sample_finish",
  "signups",
  "onboarded",
  "practicing",
  "paying",
] as const;
export type FunnelStepKey = (typeof FUNNEL_STEPS)[number];

export type Funnel = {
  days: number;
  steps: { key: FunnelStepKey; value: number }[];
  byExam: { slug: string; name: string; starts: number; finishes: number }[];
};

/** Embudo de conversión de los últimos `days` días (ADR-047). Solo administradores. */
export async function getFunnel(days = 30): Promise<Funnel> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("admin_funnel", { p_days: days });
  if (error) throw new Error(`admin funnel: ${error.message}`);
  const raw = data as Record<FunnelStepKey, number> & {
    days: number;
    by_exam: { exam: string; starts: number; finishes: number }[];
  };
  const slugs = raw.by_exam.map((e) => e.exam);
  const names = new Map<string, string>();
  if (slugs.length) {
    const { data: exams } = await supabase
      .from("exam_bodies")
      .select("slug, name")
      .in("slug", slugs);
    for (const e of exams ?? []) names.set(e.slug, e.name);
  }
  return {
    days: Number(raw.days),
    steps: FUNNEL_STEPS.map((key) => ({ key, value: Number(raw[key] ?? 0) })),
    byExam: raw.by_exam.map((e) => ({
      slug: e.exam,
      name: names.get(e.exam) ?? e.exam,
      starts: Number(e.starts),
      finishes: Number(e.finishes),
    })),
  };
}

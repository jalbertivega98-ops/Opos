import "server-only";
import { createClient } from "@/lib/supabase/server";

export type AmbassadorRow = {
  id: string;
  code: string;
  name: string;
  network: string;
  handle: string | null;
  notes: string | null;
  active: boolean;
  created_at: string;
  exam_name: string | null;
  visitsPeriod: number;
  visitsTotal: number;
  signupsPeriod: number;
  signupsTotal: number;
  paidPeriod: number;
  paidTotal: number;
};

type StatsRow = {
  ambassador_id: string;
  visits_period: number | string;
  visits_total: number | string;
  signups_period: number | string;
  signups_total: number | string;
  paid_period: number | string;
  paid_total: number | string;
};

/** Embajadoras con sus cifras (visitas, registros y altas de pago) para /admin. */
export async function listAmbassadors(days = 30): Promise<AmbassadorRow[]> {
  const supabase = await createClient();
  const [{ data: rows }, { data: stats }] = await Promise.all([
    supabase
      .from("ambassadors")
      .select("id, code, name, network, handle, notes, active, created_at, exam_bodies(name)")
      .order("active", { ascending: false })
      .order("created_at", { ascending: false }),
    supabase.rpc("admin_ambassador_stats", { p_days: days }),
  ]);
  const byId = new Map(((stats ?? []) as StatsRow[]).map((s) => [s.ambassador_id, s]));
  return (rows ?? []).map((r) => {
    const s = byId.get(r.id);
    const exam = r.exam_bodies as { name: string } | { name: string }[] | null;
    return {
      id: r.id,
      code: r.code,
      name: r.name,
      network: r.network,
      handle: r.handle,
      notes: r.notes,
      active: r.active,
      created_at: r.created_at,
      exam_name: Array.isArray(exam) ? (exam[0]?.name ?? null) : (exam?.name ?? null),
      visitsPeriod: Number(s?.visits_period ?? 0),
      visitsTotal: Number(s?.visits_total ?? 0),
      signupsPeriod: Number(s?.signups_period ?? 0),
      signupsTotal: Number(s?.signups_total ?? 0),
      paidPeriod: Number(s?.paid_period ?? 0),
      paidTotal: Number(s?.paid_total ?? 0),
    };
  });
}

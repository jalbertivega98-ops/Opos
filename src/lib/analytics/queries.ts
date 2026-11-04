import "server-only";
import { createClient } from "@/lib/supabase/server";
import type { TrafficChannel, TrafficKind } from "./traffic";

export type TrafficRow = {
  day: string;
  kind: TrafficKind;
  channel: TrafficChannel;
  source: string;
  path: string;
  hits: number;
};

/** Últimos `days` días de traffic_daily (RLS: solo personal). */
export async function listTraffic(days = 30): Promise<TrafficRow[]> {
  const supabase = await createClient();
  const since = new Date(Date.now() - days * 86_400_000).toISOString().slice(0, 10);
  const { data, error } = await supabase
    .from("traffic_daily")
    .select("day, kind, channel, source, path, hits")
    .gte("day", since)
    .order("day", { ascending: false })
    .limit(5000)
    .returns<TrafficRow[]>();
  if (error) throw new Error(`traffic: ${error.message}`);
  return data ?? [];
}

/** Suma hits agrupando por la clave indicada, de mayor a menor. */
export function sumBy(rows: TrafficRow[], key: (r: TrafficRow) => string) {
  const m = new Map<string, number>();
  for (const r of rows) m.set(key(r), (m.get(key(r)) ?? 0) + r.hits);
  return [...m.entries()].map(([k, hits]) => ({ key: k, hits })).sort((a, b) => b.hits - a.hits);
}

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

/** Filas por página: Supabase devuelve como mucho 1000 filas por consulta. */
const PAGE = 1000;

/**
 * Últimos `days` días de traffic_daily (RLS: solo personal), leídos por páginas:
 * con una sola consulta se cortaba en 1000 filas y el panel de Tráfico se
 * quedaba sin los días más antiguos (ADR-065).
 */
export async function listTraffic(days = 30): Promise<TrafficRow[]> {
  const supabase = await createClient();
  const since = new Date(Date.now() - days * 86_400_000).toISOString().slice(0, 10);
  const all: TrafficRow[] = [];
  for (let from = 0; from < 50_000; from += PAGE) {
    const { data, error } = await supabase
      .from("traffic_daily")
      .select("day, kind, channel, source, path, hits")
      .gte("day", since)
      .order("day", { ascending: false })
      .order("kind")
      .order("channel")
      .order("source")
      .order("path")
      .range(from, from + PAGE - 1)
      .returns<TrafficRow[]>();
    if (error) throw new Error(`traffic: ${error.message}`);
    all.push(...(data ?? []));
    if (!data || data.length < PAGE) break;
  }
  return all;
}

/** Suma hits agrupando por la clave indicada, de mayor a menor. */
export function sumBy(rows: TrafficRow[], key: (r: TrafficRow) => string) {
  const m = new Map<string, number>();
  for (const r of rows) m.set(key(r), (m.get(key(r)) ?? 0) + r.hits);
  return [...m.entries()].map(([k, hits]) => ({ key: k, hits })).sort((a, b) => b.hits - a.hits);
}

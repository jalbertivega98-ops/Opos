import "server-only";
import type { NextRequest } from "next/server";
import { classifyRequest, type TrafficHit } from "./traffic";

/**
 * Registra una visita o un rastreo en traffic_daily (ADR-025) con la clave de
 * servicio, que solo vive en el servidor. Nunca bloquea ni rompe la respuesta:
 * si falta la clave o falla la red, no se cuenta y ya está.
 */
export function hitFromRequest(request: NextRequest): TrafficHit | null {
  const h = request.headers;
  return classifyRequest({
    pathname: request.nextUrl.pathname,
    host: request.nextUrl.host,
    userAgent: h.get("user-agent"),
    referer: h.get("referer"),
    utmSource: request.nextUrl.searchParams.get("utm_source"),
    secFetchDest: h.get("sec-fetch-dest"),
    accept: h.get("accept"),
    isPrefetch:
      h.has("next-router-prefetch") ||
      h.has("rsc") ||
      h.get("purpose") === "prefetch" ||
      h.get("sec-purpose")?.includes("prefetch") === true,
  });
}

export async function recordHit(hit: TrafficHit): Promise<void> {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key || process.env.TRAFFIC_ANALYTICS === "off") return;
  try {
    await fetch(`${url}/rest/v1/rpc/track_traffic`, {
      method: "POST",
      headers: { apikey: key, authorization: `Bearer ${key}`, "content-type": "application/json" },
      body: JSON.stringify({
        p_kind: hit.kind,
        p_channel: hit.channel,
        p_source: hit.source,
        p_path: hit.path,
      }),
      signal: AbortSignal.timeout(2000),
      cache: "no-store",
    });
  } catch {
    // La analítica nunca debe afectar a la navegación.
  }
}

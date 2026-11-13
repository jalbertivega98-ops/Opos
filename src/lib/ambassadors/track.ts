import "server-only";

/**
 * Suma una visita al enlace /r/<código> de una embajadora (ADR-054) con la clave
 * de servicio. Contador agregado por día, sin cookies ni datos personales. Nunca
 * lanza: si falta la clave o falla la red, simplemente no se cuenta.
 */
export async function recordAmbassadorVisit(code: string): Promise<void> {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!url || !key || process.env.TRAFFIC_ANALYTICS === "off") return;
  try {
    await fetch(`${url}/rest/v1/rpc/track_ambassador_visit`, {
      method: "POST",
      headers: { apikey: key, authorization: `Bearer ${key}`, "content-type": "application/json" },
      body: JSON.stringify({ p_code: code }),
      signal: AbortSignal.timeout(2000),
      cache: "no-store",
    });
  } catch {
    // La analítica nunca debe impedir la redirección.
  }
}

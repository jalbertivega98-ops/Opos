import "server-only";
import { publicEnv } from "@/lib/env";

/**
 * ¿Está activado «Continuar con Google» en Supabase Auth?
 * Se consulta a GoTrue (/auth/v1/settings) en vez de usar otra variable de entorno:
 * el botón aparece solo cuando el proveedor está configurado en el panel de Supabase
 * y desaparece si se desactiva. Ante cualquier fallo se oculta (no rompemos el login).
 */
export async function isGoogleAuthEnabled(): Promise<boolean> {
  try {
    const res = await fetch(`${publicEnv.NEXT_PUBLIC_SUPABASE_URL}/auth/v1/settings`, {
      headers: { apikey: publicEnv.NEXT_PUBLIC_SUPABASE_ANON_KEY },
      next: { revalidate: 300 },
      signal: AbortSignal.timeout(3000),
    });
    if (!res.ok) return false;
    const body = (await res.json()) as { external?: Record<string, unknown> };
    return body.external?.google === true;
  } catch {
    return false;
  }
}

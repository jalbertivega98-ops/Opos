import "server-only";
import { createClient } from "@supabase/supabase-js";
import { publicEnv } from "@/lib/env";

/**
 * Cliente con service_role: SALTA RLS. Úsalo solo en el servidor y solo para
 * llamar a funciones restringidas a service_role (p. ej. registrar resultados
 * de práctica ya corregidos en el servidor). Nunca para lecturas en nombre del
 * usuario: para eso está `createClient()` con su sesión.
 */
export function createServiceClient() {
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) throw new Error("Falta SUPABASE_SERVICE_ROLE_KEY (solo servidor)");
  return createClient(publicEnv.NEXT_PUBLIC_SUPABASE_URL, key, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}

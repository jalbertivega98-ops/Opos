"use server";

import { createClient } from "@/lib/supabase/server";

/**
 * Marca el tutorial de bienvenida como visto (terminado o cerrado) para el
 * alumno de la sesión, para que no vuelva a salir (ADR-055). Sin argumentos:
 * la función SQL solo toca el perfil de auth.uid().
 */
export async function completeWelcomeTourAction(): Promise<{ ok: boolean }> {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { ok: false };
  const { error } = await supabase.rpc("complete_welcome_tour");
  return { ok: !error };
}

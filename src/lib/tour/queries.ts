import "server-only";
import { createClient } from "@/lib/supabase/server";

/**
 * ¿Toca enseñar el tutorial de bienvenida? Solo si el perfil existe y
 * `tour_completed_at` es null. Si la columna aún no existe (código desplegado
 * antes que el SQL) o la consulta falla, no se enseña: mejor no molestar.
 */
export async function shouldShowWelcomeTour(userId: string): Promise<boolean> {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("profiles")
    .select("tour_completed_at")
    .eq("id", userId)
    .maybeSingle<{ tour_completed_at: string | null }>();
  if (error || !data) return false;
  return data.tour_completed_at === null;
}

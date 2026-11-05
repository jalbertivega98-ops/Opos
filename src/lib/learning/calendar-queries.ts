import "server-only";
import { createClient } from "@/lib/supabase/server";
import { toStudyEntry } from "./calendar";

/** Prácticas y simulacros del alumno actual entre dos instantes (RLS por auth.uid()). */
export async function getStudyLog(from: Date, to: Date) {
  const supabase = await createClient();
  const { data } = await supabase.rpc("my_study_log", {
    p_from: from.toISOString(),
    p_to: to.toISOString(),
  });
  return ((data ?? []) as Record<string, unknown>[]).map(toStudyEntry);
}

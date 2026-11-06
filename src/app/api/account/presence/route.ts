import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

/**
 * Latido de la zona del alumno (ADR-038): suma, como mucho, un minuto al día
 * de hoy. No guarda la página, la IP ni el dispositivo.
 */
export async function POST() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return new NextResponse(null, { status: 204 });
  await supabase.rpc("track_presence");
  return new NextResponse(null, { status: 204, headers: { "cache-control": "no-store" } });
}

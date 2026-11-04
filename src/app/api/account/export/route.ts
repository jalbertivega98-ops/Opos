import { NextResponse } from "next/server";
import { createClient } from "@/lib/supabase/server";

/** Descarga de datos personales del alumno autenticado (RGPD, art. 15 y 20). */
export async function GET() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "unauthorized" }, { status: 401 });

  await supabase.rpc("track_activity", { p_kind: "account.exported" });
  const { data, error } = await supabase.rpc("export_my_data");
  if (error) return NextResponse.json({ error: "export_failed" }, { status: 500 });

  const date = new Date().toISOString().slice(0, 10);
  return new NextResponse(JSON.stringify(data, null, 2), {
    headers: {
      "content-type": "application/json; charset=utf-8",
      "content-disposition": `attachment; filename="oposaprueba-mis-datos-${date}.json"`,
      "cache-control": "no-store",
    },
  });
}

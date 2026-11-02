import { NextResponse, type NextRequest } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { csvCell, listUsers, userFilterSchema } from "@/lib/admin/users";

/** Exportación CSV de alumnos: solo administración y siempre auditada. */
export async function GET(request: NextRequest) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "unauthorized" }, { status: 401 });
  const { data: isAdmin } = await supabase.rpc("is_admin");
  if (!isAdmin) return NextResponse.json({ error: "forbidden" }, { status: 403 });

  const filter = userFilterSchema.parse(Object.fromEntries(request.nextUrl.searchParams));
  const { rows } = await listUsers(filter, { limit: 5000, offset: 0 });
  await supabase.rpc("log_admin_action", {
    p_action: "users.exported_csv",
    p_target_type: "profiles",
    p_metadata: { count: rows.length, filter },
  });

  const header = [
    "id",
    "email",
    "nombre",
    "rol",
    "estado",
    "idioma",
    "alta",
    "ultima_actividad",
    "onboarding",
    "oposicion_principal",
  ];
  const lines = rows.map((r) =>
    [
      r.id,
      r.email,
      r.display_name,
      r.role,
      r.status,
      r.locale,
      r.created_at,
      r.last_active_at,
      r.onboarding_completed_at,
      r.primary_exam,
    ]
      .map(csvCell)
      .join(","),
  );
  const date = new Date().toISOString().slice(0, 10);
  return new NextResponse("﻿" + [header.join(","), ...lines].join("\r\n"), {
    headers: {
      "content-type": "text/csv; charset=utf-8",
      "content-disposition": `attachment; filename="alumnos-${date}.csv"`,
      "cache-control": "no-store",
    },
  });
}

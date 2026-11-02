import { createServerClient } from "@supabase/ssr";
import type { NextRequest, NextResponse } from "next/server";
import { publicEnv } from "@/lib/env";

/**
 * Refresca la sesión de Supabase en el proxy y copia las cookies
 * actualizadas a la respuesta (generada por next-intl).
 */
export async function refreshSession(request: NextRequest, response: NextResponse) {
  const supabase = createServerClient(
    publicEnv.NEXT_PUBLIC_SUPABASE_URL,
    publicEnv.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options),
          );
        },
      },
    },
  );
  // getUser() valida el JWT contra Auth (no confiar solo en la cookie).
  const {
    data: { user },
  } = await supabase.auth.getUser();
  return user;
}

import { NextResponse, type NextRequest } from "next/server";
import type { EmailOtpType } from "@supabase/supabase-js";
import { createClient } from "@/lib/supabase/server";
import { safeNextPath } from "@/lib/paths";

const TYPES: EmailOtpType[] = ["signup", "recovery", "email_change", "email", "invite"];

/**
 * Destino recomendado para plantillas de email en producción
 * ({{ .SiteURL }}/auth/confirm?token_hash={{ .TokenHash }}&type=...).
 * Funciona aunque el usuario abra el enlace en otro dispositivo.
 */
export async function GET(request: NextRequest) {
  const { searchParams, origin } = request.nextUrl;
  const tokenHash = searchParams.get("token_hash");
  const type = searchParams.get("type") as EmailOtpType | null;
  const next = safeNextPath(
    searchParams.get("next"),
    type === "recovery" ? "/restablecer" : "/app",
  );

  if (tokenHash && type && TYPES.includes(type)) {
    const supabase = await createClient();
    const { error } = await supabase.auth.verifyOtp({ type, token_hash: tokenHash });
    if (!error) return NextResponse.redirect(new URL(next, origin));
  }
  return NextResponse.redirect(new URL("/entrar?error=link", origin));
}

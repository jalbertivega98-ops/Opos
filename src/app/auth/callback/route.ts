import { NextResponse, type NextRequest } from "next/server";
import { createClient } from "@/lib/supabase/server";
import { safeNextPath, stripLocale } from "@/lib/paths";

/**
 * Destino de los enlaces de Auth con flujo PKCE (?code=...).
 * Confirmación de email, recuperación de contraseña y «Continuar con Google» (?via=google).
 */
export async function GET(request: NextRequest) {
  const { searchParams, origin } = request.nextUrl;
  const code = searchParams.get("code");
  const next = safeNextPath(searchParams.get("next"), "/app");
  const viaGoogle = searchParams.get("via") === "google";

  if (code) {
    const supabase = await createClient();
    const { error } = await supabase.auth.exchangeCodeForSession(code);
    if (!error) {
      const target = viaGoogle ? await afterGoogleSignIn(supabase, next) : next;
      return NextResponse.redirect(new URL(target, origin));
    }
  }
  // Si el alumno cancela en Google (o Google falla) volvemos al login con un aviso propio.
  const reason = viaGoogle || searchParams.has("error") ? "oauth" : "link";
  return NextResponse.redirect(new URL(`/entrar?error=${reason}`, origin));
}

/**
 * Tras entrar con Google: registra la entrada y, si la cuenta es nueva (sin onboarding),
 * guarda el idioma con el que llegó y la lleva al onboarding igual que el alta por correo.
 */
async function afterGoogleSignIn(
  supabase: Awaited<ReturnType<typeof createClient>>,
  next: string,
): Promise<string> {
  await supabase.rpc("track_activity", { p_kind: "auth.sign_in" });
  const bare = stripLocale(next);
  const prefix = next.slice(0, next.length - bare.length); // "" o "/ca"
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return next;
  const { data: profile } = await supabase
    .from("profiles")
    .select("onboarding_completed_at, locale")
    .eq("id", user.id)
    .maybeSingle();
  if (!profile || profile.onboarding_completed_at) return next;
  const locale = prefix === "/ca" ? "ca" : "es";
  if (profile.locale !== locale) {
    await supabase.from("profiles").update({ locale }).eq("id", user.id);
  }
  return bare === "/app" ? `${prefix}/app/onboarding` : next;
}

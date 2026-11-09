import createIntlMiddleware from "next-intl/middleware";
import { NextResponse, type NextFetchEvent, type NextRequest } from "next/server";
import { routing } from "@/i18n/routing";
import { refreshSession } from "@/lib/supabase/session";
import { isProtectedPath, stripLocale } from "@/lib/paths";
import { previewGate } from "@/lib/preview";
import { hitFromRequest, recordHit } from "@/lib/analytics/track";

const intl = createIntlMiddleware(routing);

export async function proxy(request: NextRequest, event: NextFetchEvent) {
  // Analítica de captación (buscadores, IA, rastreadores) en segundo plano, ADR-025.
  // Va antes de la contraseña de preview para ver también a los rastreadores rechazados.
  const hit = request.method === "GET" ? hitFromRequest(request) : null;
  if (hit) event.waitUntil(recordHit(hit));

  const denied = previewGate(request);
  if (denied) return denied;
  const response = intl(request);
  if (process.env.PREVIEW_PASSWORD) response.headers.set("X-Robots-Tag", "noindex, nofollow");
  // Si next-intl redirige (p. ej. normalización de idioma), no hace falta más.
  if (response.headers.get("location")) return response;

  const user = await refreshSession(request, response);

  if (!user && isProtectedPath(request.nextUrl.pathname)) {
    const url = request.nextUrl.clone();
    const localePrefix = request.nextUrl.pathname.startsWith("/ca") ? "/ca" : "";
    const target = stripLocale(request.nextUrl.pathname);
    // El onboarding solo lo pide quien aún no tiene cuenta («Preparar esta oposición»):
    // lo mandamos a crearla, no a entrar. Conservamos la consulta (?exam=…) en next.
    const page = target === "/app/onboarding" ? "registro" : "entrar";
    url.pathname = `${localePrefix}/${page}`;
    url.search = `?next=${encodeURIComponent(target + request.nextUrl.search)}`;
    const redirect = NextResponse.redirect(url);
    response.cookies.getAll().forEach((c) => redirect.cookies.set(c));
    return redirect;
  }
  return response;
}

export const config = {
  // Todo excepto estáticos, API internas de Next y el callback de auth.
  matcher: ["/((?!api|auth|_next|_vercel|.*\\..*).*)"],
};

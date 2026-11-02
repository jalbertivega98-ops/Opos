import createIntlMiddleware from "next-intl/middleware";
import { NextResponse, type NextRequest } from "next/server";
import { routing } from "@/i18n/routing";
import { refreshSession } from "@/lib/supabase/session";
import { isProtectedPath, stripLocale } from "@/lib/paths";

const intl = createIntlMiddleware(routing);

export async function proxy(request: NextRequest) {
  const response = intl(request);
  // Si next-intl redirige (p. ej. normalización de idioma), no hace falta más.
  if (response.headers.get("location")) return response;

  const user = await refreshSession(request, response);

  if (!user && isProtectedPath(request.nextUrl.pathname)) {
    const url = request.nextUrl.clone();
    const localePrefix = request.nextUrl.pathname.startsWith("/ca") ? "/ca" : "";
    url.pathname = `${localePrefix}/entrar`;
    url.search = `?next=${encodeURIComponent(stripLocale(request.nextUrl.pathname))}`;
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

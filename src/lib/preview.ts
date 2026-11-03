import { NextResponse, type NextRequest } from "next/server";

/**
 * Preview privada (sesión 3): si PREVIEW_PASSWORD está definida, toda la web
 * pide usuario/contraseña HTTP Basic y se marca como no indexable. No definirla
 * en producción ni en local.
 */
export function previewGate(request: NextRequest, password = process.env.PREVIEW_PASSWORD) {
  if (!password) return null;
  const header = request.headers.get("authorization") ?? "";
  const [scheme, encoded] = header.split(" ");
  if (scheme === "Basic" && encoded) {
    const decoded = atob(encoded);
    const pass = decoded.slice(decoded.indexOf(":") + 1);
    if (pass === password) return null;
  }
  return new NextResponse("Acceso restringido (preview privada)", {
    status: 401,
    headers: {
      "WWW-Authenticate": 'Basic realm="Aprobia preview", charset="UTF-8"',
      "X-Robots-Tag": "noindex, nofollow",
    },
  });
}

import { ambassadorCodeSchema } from "./schemas";

/**
 * Enlace propio de una embajadora: /r/<código> (o /ca/r/<código>). Devuelve el
 * código normalizado y el prefijo de idioma, o null si la ruta no es un enlace.
 */
export function parseAmbassadorPath(pathname: string): { code: string; prefix: "" | "/ca" } | null {
  const m = /^(\/ca)?\/r\/([^/]+)\/?$/i.exec(pathname);
  if (!m) return null;
  let raw: string;
  try {
    raw = decodeURIComponent(m[2]);
  } catch {
    return null;
  }
  const parsed = ambassadorCodeSchema.safeParse(raw);
  if (!parsed.success) return null;
  return { code: parsed.data, prefix: m[1] ? "/ca" : "" };
}

/** Destino del enlace: la página de registro con el código ya puesto. */
export function ambassadorTarget(link: { code: string; prefix: "" | "/ca" }): string {
  return `${link.prefix}/registro?ref=${encodeURIComponent(link.code)}`;
}

/** URL pública que se comparte con la embajadora. */
export function ambassadorUrl(siteUrl: string, code: string): string {
  return `${siteUrl.replace(/\/$/, "")}/r/${code}`;
}

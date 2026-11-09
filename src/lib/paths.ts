import { locales } from "@/i18n/routing";

/** Rutas que exigen sesión (sin prefijo de idioma). */
export const PROTECTED_PREFIXES = ["/app", "/admin"] as const;

/** Quita el prefijo de idioma (/ca/app -> /app). */
export function stripLocale(pathname: string): string {
  for (const l of locales) {
    if (pathname === `/${l}`) return "/";
    if (pathname.startsWith(`/${l}/`)) return pathname.slice(l.length + 1);
  }
  return pathname;
}

export function isProtectedPath(pathname: string): boolean {
  const p = stripLocale(pathname);
  return PROTECTED_PREFIXES.some((prefix) => p === prefix || p.startsWith(`${prefix}/`));
}

/**
 * Valida un destino de redirección: solo rutas internas absolutas.
 * Evita open redirects (//evil.com, /\evil.com, http://...).
 */
export function safeNextPath(next: string | null | undefined, fallback = "/app"): string {
  if (!next || typeof next !== "string") return fallback;
  if (!next.startsWith("/") || next.startsWith("//") || next.startsWith("/\\")) return fallback;
  if (/[\r\n\t]/.test(next) || next.length > 512) return fallback;
  try {
    const url = new URL(next, "http://localhost");
    if (url.host !== "localhost") return fallback;
    return url.pathname + url.search;
  } catch {
    return fallback;
  }
}

/** Slug de oposición válido en una URL (minúsculas, números y guiones). */
const EXAM_SLUG = /^[a-z0-9]+(?:-[a-z0-9]+)*$/;

/** Destino tras crear la cuenta: el onboarding con la oposición ya elegida. */
export function onboardingPath(exam?: string | null): string {
  return exam && EXAM_SLUG.test(exam) && exam.length <= 80
    ? `/app/onboarding?exam=${exam}`
    : "/app/onboarding";
}

/** Enlace a «Crear cuenta» que conserva la oposición que el visitante estaba mirando. */
export function signUpPath(exam?: string | null): string {
  return exam && EXAM_SLUG.test(exam) && exam.length <= 80 ? `/registro?exam=${exam}` : "/registro";
}

/** Oposición que pide un destino interno (`/app/onboarding?exam=…`), si la hay. */
export function examFromNext(next?: string | null): string | undefined {
  if (!next) return undefined;
  const url = new URL(safeNextPath(next, "/"), "http://localhost");
  const exam = url.searchParams.get("exam");
  return exam && EXAM_SLUG.test(exam) ? exam : undefined;
}

import type { Metadata } from "next";
import { locales, type Locale } from "@/i18n/routing";

/** Nombre comercial (ADR-023). Los identificadores técnicos siguen siendo «aprobia». */
export const BRAND = "OPOSAPRUEBA";

/** URL pública canónica, sin barra final (NEXT_PUBLIC_SITE_URL). */
export const siteUrl = () =>
  (process.env.NEXT_PUBLIC_SITE_URL || "http://localhost:3000").replace(/\/+$/, "");

/**
 * ¿Pueden indexar los buscadores? (ADR-025). No mientras la web esté protegida
 * con PREVIEW_PASSWORD, ni en despliegues «preview» de Vercel, ni en local.
 * Al quitar la contraseña en producción, robots.txt y las etiquetas cambian solas.
 */
export function isIndexable(env: Record<string, string | undefined> = process.env): boolean {
  if (env.PREVIEW_PASSWORD) return false;
  if (env.VERCEL_ENV && env.VERCEL_ENV !== "production") return false;
  if (env.SEO_INDEXABLE === "false") return false;
  const url = env.NEXT_PUBLIC_SITE_URL ?? "";
  return /^https:\/\//.test(url) && !/localhost|127\.0\.0\.1/.test(url);
}

/** Ruta con prefijo de idioma (es sin prefijo, ca con /ca). `path` empieza por «/». */
export function localePath(path: string, locale: string): string {
  if (locale === "ca") return path === "/" ? "/ca" : `/ca${path}`;
  return path;
}

export const absoluteUrl = (path: string, locale: string = "es") =>
  `${siteUrl()}${localePath(path, locale)}`;

/** canonical + hreflang (es, ca y x-default) de una página pública. */
export function alternatesFor(path: string, locale: string): NonNullable<Metadata["alternates"]> {
  const languages: Record<string, string> = {};
  for (const l of locales) languages[l] = localePath(path, l);
  languages["x-default"] = localePath(path, "es");
  return { canonical: localePath(path, locale), languages };
}

/** Imagen para compartir (public/og-image.png, generada con scripts/seo/render-logo.mjs). */
export const OG_IMAGE = {
  url: "/og-image.png",
  width: 1200,
  height: 630,
  alt: `${BRAND} · Test de oposiciones, temario y psicotécnicos`,
};

export const ogLocale = (locale: string) => (locale === "ca" ? "ca_ES" : "es_ES");

/** Metadatos SEO de una página pública indexable. */
export function pageMetadata({
  path,
  locale,
  title,
  description,
  absoluteTitle = false,
  index = true,
}: {
  path: string;
  locale: string;
  title: string;
  description: string;
  absoluteTitle?: boolean;
  /** false = noindex, follow (páginas finas o borradores). */
  index?: boolean;
}): Metadata {
  const url = localePath(path, locale);
  return {
    title: absoluteTitle ? { absolute: title } : title,
    description,
    alternates: alternatesFor(path, locale),
    openGraph: {
      type: "website",
      siteName: BRAND,
      locale: ogLocale(locale),
      alternateLocale: locales.filter((l) => l !== locale).map(ogLocale),
      url,
      title: absoluteTitle ? title : `${title} · ${BRAND}`,
      description,
      images: [OG_IMAGE],
    },
    twitter: { card: "summary_large_image", title, description, images: [OG_IMAGE.url] },
    ...(index ? {} : { robots: { index: false, follow: true } }),
  };
}

export const isLocale = (l: string): l is Locale => (locales as readonly string[]).includes(l);

/**
 * Códigos de verificación de Google Search Console y Bing Webmaster Tools
 * (variables de entorno públicas por diseño: van en una etiqueta <meta>).
 */
export function searchVerification(
  env: Record<string, string | undefined> = process.env,
): Metadata["verification"] | undefined {
  const google = env.GOOGLE_SITE_VERIFICATION?.trim();
  const bing = env.BING_SITE_VERIFICATION?.trim();
  if (!google && !bing) return undefined;
  return {
    ...(google ? { google } : {}),
    ...(bing ? { other: { "msvalidate.01": bing } } : {}),
  };
}

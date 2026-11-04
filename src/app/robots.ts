import type { MetadataRoute } from "next";
import { isIndexable, siteUrl } from "@/lib/seo/site";

/** Zonas privadas o sin valor para buscadores (con y sin prefijo /ca). */
const PRIVATE = ["/app", "/admin", "/api/", "/auth/", "/cuenta-suspendida"].flatMap((p) => [
  p,
  `/ca${p}`,
]);

/**
 * Rastreadores de buscadores y de IA a los que se da la bienvenida de forma
 * explícita (ADR-025). OAI-SearchBot y ChatGPT-User: búsqueda de ChatGPT;
 * PerplexityBot; Claude-SearchBot; Googlebot y Bingbot (también alimentan
 * Gemini/AI Overviews y Copilot). Todos siguen las mismas reglas que «*».
 * Los rastreadores de entrenamiento (GPTBot, Google-Extended, ClaudeBot, CCBot)
 * quedan permitidos por la regla general: decisión de negocio de joel (ver docs/SEO.md).
 */
export const AI_AND_SEARCH_BOTS = [
  "OAI-SearchBot",
  "ChatGPT-User",
  "PerplexityBot",
  "Perplexity-User",
  "Claude-SearchBot",
  "Claude-User",
  "Googlebot",
  "Bingbot",
  "Applebot",
  "DuckDuckBot",
];

export default function robots(): MetadataRoute.Robots {
  // Preview privada o despliegue no productivo: nada indexable.
  if (!isIndexable()) {
    return { rules: [{ userAgent: "*", disallow: "/" }] };
  }
  return {
    rules: [
      { userAgent: AI_AND_SEARCH_BOTS, allow: "/", disallow: PRIVATE },
      { userAgent: "*", allow: "/", disallow: PRIVATE },
    ],
    sitemap: `${siteUrl()}/sitemap.xml`,
    host: siteUrl(),
  };
}

/**
 * Clasificación de visitas y rastreadores para la analítica de captación (ADR-025).
 * Pura y sin datos personales: devuelve canal, fuente y ruta normalizada, o null
 * si la petición no se cuenta (navegación interna, prefetch, recursos…).
 */
export type TrafficKind = "visit" | "crawler";
export type TrafficChannel = "search" | "ai" | "social" | "referral" | "direct";
export type TrafficHit = {
  kind: TrafficKind;
  channel: TrafficChannel;
  source: string;
  path: string;
};

/** Rastreadores conocidos por User-Agent (orden: el primero que coincide). */
const CRAWLERS: { re: RegExp; source: string; channel: "ai" | "search" }[] = [
  { re: /OAI-SearchBot/i, source: "oai-searchbot", channel: "ai" },
  { re: /ChatGPT-User/i, source: "chatgpt-user", channel: "ai" },
  { re: /GPTBot/i, source: "gptbot", channel: "ai" },
  { re: /PerplexityBot/i, source: "perplexitybot", channel: "ai" },
  { re: /Perplexity-User/i, source: "perplexity-user", channel: "ai" },
  { re: /Claude-SearchBot/i, source: "claude-searchbot", channel: "ai" },
  { re: /Claude-User/i, source: "claude-user", channel: "ai" },
  { re: /ClaudeBot/i, source: "claudebot", channel: "ai" },
  { re: /Google-CloudVertexBot|Gemini-Deep-Research/i, source: "google-ai", channel: "ai" },
  { re: /MistralAI-User/i, source: "mistral-user", channel: "ai" },
  { re: /meta-externalagent|meta-externalfetcher/i, source: "meta-ai", channel: "ai" },
  { re: /Bytespider/i, source: "bytespider", channel: "ai" },
  { re: /CCBot/i, source: "ccbot", channel: "ai" },
  { re: /Amazonbot/i, source: "amazonbot", channel: "ai" },
  { re: /DuckAssistBot/i, source: "duckassist", channel: "ai" },
  { re: /Googlebot|Google-InspectionTool|GoogleOther/i, source: "googlebot", channel: "search" },
  { re: /bingbot|BingPreview|msnbot/i, source: "bingbot", channel: "search" },
  { re: /Applebot/i, source: "applebot", channel: "search" },
  { re: /DuckDuckBot/i, source: "duckduckbot", channel: "search" },
  { re: /YandexBot/i, source: "yandexbot", channel: "search" },
  { re: /Baiduspider/i, source: "baiduspider", channel: "search" },
];

/** Dominios de origen (referer o utm_source) → canal y fuente. */
const REFERRERS: { re: RegExp; source: string; channel: TrafficChannel }[] = [
  // IA (antes que google.* para no confundir gemini.google.com)
  { re: /(^|\.)(chatgpt\.com|chat\.openai\.com|openai\.com)$/, source: "chatgpt", channel: "ai" },
  { re: /(^|\.)perplexity\.ai$/, source: "perplexity", channel: "ai" },
  { re: /(^|\.)(gemini\.google\.com|bard\.google\.com)$/, source: "gemini", channel: "ai" },
  { re: /(^|\.)copilot\.microsoft\.com$/, source: "copilot", channel: "ai" },
  { re: /(^|\.)claude\.ai$/, source: "claude", channel: "ai" },
  { re: /(^|\.)(chat\.deepseek\.com|deepseek\.com)$/, source: "deepseek", channel: "ai" },
  { re: /(^|\.)chat\.mistral\.ai$/, source: "mistral", channel: "ai" },
  { re: /(^|\.)meta\.ai$/, source: "meta-ai", channel: "ai" },
  { re: /(^|\.)you\.com$/, source: "you", channel: "ai" },
  { re: /(^|\.)phind\.com$/, source: "phind", channel: "ai" },
  // Buscadores
  { re: /(^|\.)google\.[a-z.]{2,8}$/, source: "google", channel: "search" },
  { re: /(^|\.)bing\.com$/, source: "bing", channel: "search" },
  { re: /(^|\.)duckduckgo\.com$/, source: "duckduckgo", channel: "search" },
  { re: /(^|\.)search\.yahoo\.com$|(^|\.)yahoo\.com$/, source: "yahoo", channel: "search" },
  { re: /(^|\.)ecosia\.org$/, source: "ecosia", channel: "search" },
  { re: /(^|\.)search\.brave\.com$/, source: "brave", channel: "search" },
  { re: /(^|\.)yandex\.[a-z]{2,4}$/, source: "yandex", channel: "search" },
  { re: /(^|\.)qwant\.com$/, source: "qwant", channel: "search" },
  // Redes sociales
  { re: /(^|\.)(instagram\.com|l\.instagram\.com)$/, source: "instagram", channel: "social" },
  { re: /(^|\.)(facebook\.com|fb\.com|m\.facebook\.com)$/, source: "facebook", channel: "social" },
  { re: /(^|\.)(t\.co|x\.com|twitter\.com)$/, source: "x", channel: "social" },
  { re: /(^|\.)(linkedin\.com|lnkd\.in)$/, source: "linkedin", channel: "social" },
  { re: /(^|\.)tiktok\.com$/, source: "tiktok", channel: "social" },
  { re: /(^|\.)(youtube\.com|youtu\.be)$/, source: "youtube", channel: "social" },
  { re: /(^|\.)(reddit\.com)$/, source: "reddit", channel: "social" },
  { re: /(^|\.)(t\.me|telegram\.org)$/, source: "telegram", channel: "social" },
  { re: /(^|\.)(wa\.me|whatsapp\.com)$/, source: "whatsapp", channel: "social" },
];

/** utm_source sin dominio que usan algunas herramientas. */
const UTM_ALIASES: Record<string, string> = {
  chatgpt: "chatgpt.com",
  openai: "chatgpt.com",
  perplexity: "perplexity.ai",
  gemini: "gemini.google.com",
  copilot: "copilot.microsoft.com",
  claude: "claude.ai",
  instagram: "instagram.com",
  facebook: "facebook.com",
  tiktok: "tiktok.com",
  google: "google.com",
  bing: "bing.com",
};

function hostOf(value: string | null | undefined): string | null {
  if (!value) return null;
  const v = value.trim().toLowerCase();
  if (UTM_ALIASES[v]) return UTM_ALIASES[v];
  try {
    return new URL(/^[a-z][a-z0-9+.-]*:\/\//.test(v) ? v : `https://${v}`).hostname.replace(
      /^www\./,
      "",
    );
  } catch {
    return null;
  }
}

export function classifyHost(host: string): { source: string; channel: TrafficChannel } {
  for (const r of REFERRERS) if (r.re.test(host)) return { source: r.source, channel: r.channel };
  return { source: "other", channel: "referral" };
}

/** Ruta pública normalizada (acota la cardinalidad); el resto cuenta como «/otros». */
export function normalizePath(pathname: string): string {
  const p = pathname.toLowerCase().replace(/\/+$/, "") || "/";
  const m = p.match(/^(\/ca)?(\/.*)?$/);
  const prefix = m?.[1] ?? "";
  const rest = m?.[2] ?? "/";
  const ok =
    rest === "/" ||
    /^\/(oposiciones|psicotecnicos|legal)(\/[a-z0-9-]{2,80})?$/.test(rest) ||
    /^\/(registro|entrar|recuperar)$/.test(rest);
  if (!ok) return "/otros";
  return prefix && rest === "/" ? "/ca" : `${prefix}${rest}`;
}

export function classifyRequest(req: {
  pathname: string;
  host: string;
  userAgent: string | null;
  referer: string | null;
  utmSource: string | null;
  secFetchDest: string | null;
  accept: string | null;
  isPrefetch: boolean;
}): TrafficHit | null {
  const path = normalizePath(req.pathname);
  const ua = req.userAgent ?? "";
  for (const c of CRAWLERS) {
    if (c.re.test(ua)) return { kind: "crawler", channel: c.channel, source: c.source, path };
  }

  // Solo cargas de página completas: ni prefetch, ni RSC, ni recursos.
  if (req.isPrefetch) return null;
  const isDocument =
    req.secFetchDest === "document" ||
    (!req.secFetchDest && (req.accept ?? "").includes("text/html"));
  if (!isDocument) return null;

  const own = req.host.toLowerCase().replace(/^www\./, "");
  const utmHost = hostOf(req.utmSource);
  const refHost = hostOf(req.referer);
  const origin = utmHost ?? refHost;
  if (!origin) return { kind: "visit", channel: "direct", source: "direct", path };
  if (origin === own) return null; // navegación interna
  return { kind: "visit", ...classifyHost(origin), path };
}

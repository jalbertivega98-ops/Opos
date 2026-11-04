import { describe, expect, it } from "vitest";
import { classifyRequest, normalizePath } from "@/lib/analytics/traffic";

const base = {
  pathname: "/oposiciones/mossos-esquadra",
  host: "oposaprueba.com",
  userAgent: "Mozilla/5.0 (Windows NT 10.0) Chrome/140",
  referer: null,
  utmSource: null,
  secFetchDest: "document",
  accept: "text/html",
  isPrefetch: false,
};

describe("clasificación de tráfico", () => {
  it("reconoce rastreadores de IA y de buscadores por User-Agent", () => {
    const ua = (userAgent: string) => classifyRequest({ ...base, userAgent, secFetchDest: null });
    expect(
      ua("Mozilla/5.0; compatible; OAI-SearchBot/1.0; +https://openai.com/searchbot"),
    ).toMatchObject({
      kind: "crawler",
      channel: "ai",
      source: "oai-searchbot",
    });
    expect(ua("Mozilla/5.0 (compatible; PerplexityBot/1.0)")?.source).toBe("perplexitybot");
    expect(ua("Mozilla/5.0 (compatible; Googlebot/2.1)")).toMatchObject({ channel: "search" });
    expect(ua("Mozilla/5.0 (compatible; bingbot/2.0)")?.source).toBe("bingbot");
  });

  it("clasifica visitas por origen: IA, buscador, red social, otra web o directo", () => {
    const ref = (referer: string | null, utmSource: string | null = null) =>
      classifyRequest({ ...base, referer, utmSource });
    expect(ref("https://chatgpt.com/")).toMatchObject({
      kind: "visit",
      channel: "ai",
      source: "chatgpt",
    });
    expect(ref(null, "chatgpt.com")).toMatchObject({ channel: "ai", source: "chatgpt" });
    expect(ref("https://www.perplexity.ai/search?q=x")?.source).toBe("perplexity");
    expect(ref("https://gemini.google.com/app")?.source).toBe("gemini");
    expect(ref("https://www.google.es/")).toMatchObject({ channel: "search", source: "google" });
    expect(ref("https://www.bing.com/search?q=x")?.source).toBe("bing");
    expect(ref("https://l.instagram.com/")).toMatchObject({
      channel: "social",
      source: "instagram",
    });
    expect(ref("https://blog.example.org/post")).toMatchObject({
      channel: "referral",
      source: "other",
    });
    expect(ref(null)).toMatchObject({ channel: "direct", source: "direct" });
  });

  it("no cuenta navegación interna, prefetch ni recursos", () => {
    expect(classifyRequest({ ...base, referer: "https://oposaprueba.com/" })).toBeNull();
    expect(classifyRequest({ ...base, referer: "https://www.oposaprueba.com/x" })).toBeNull();
    expect(classifyRequest({ ...base, isPrefetch: true })).toBeNull();
    expect(classifyRequest({ ...base, secFetchDest: "empty", accept: "*/*" })).toBeNull();
  });

  it("normaliza rutas para acotar la cardinalidad", () => {
    expect(normalizePath("/")).toBe("/");
    expect(normalizePath("/ca")).toBe("/ca");
    expect(normalizePath("/ca/psicotecnicos/matrices/")).toBe("/ca/psicotecnicos/matrices");
    expect(normalizePath("/Oposiciones/Mossos-Esquadra")).toBe("/oposiciones/mossos-esquadra");
    expect(normalizePath("/app/practica/123")).toBe("/otros");
    expect(normalizePath("/wp-login.php")).toBe("/otros");
    expect(normalizePath("/oposiciones/a/b")).toBe("/otros");
  });
});

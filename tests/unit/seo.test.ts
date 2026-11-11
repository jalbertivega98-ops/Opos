import { describe, expect, it } from "vitest";
import { renderToStaticMarkup } from "react-dom/server";
import { alternatesFor, isIndexable, localePath, searchVerification } from "@/lib/seo/site";
import { JsonLd, faqLd } from "@/lib/seo/json-ld";
import { psychoGuides } from "@/lib/seo/psycho-guides";
import { examGuides } from "@/lib/seo/exam-guides";
import { buildLlmsTxt } from "@/lib/seo/llms";
import { PSYCHO_TYPES } from "@/lib/learning/psycho/types";
import { availableTypes } from "@/lib/learning/psycho/registry";

const PROD = { NEXT_PUBLIC_SITE_URL: "https://oposaprueba.com", VERCEL_ENV: "production" };

describe("indexabilidad", () => {
  it("solo indexa producción https sin contraseña de preview", () => {
    expect(isIndexable(PROD)).toBe(true);
    expect(isIndexable({ ...PROD, PREVIEW_PASSWORD: "x" })).toBe(false);
    expect(isIndexable({ ...PROD, VERCEL_ENV: "preview" })).toBe(false);
    expect(isIndexable({ ...PROD, SEO_INDEXABLE: "false" })).toBe(false);
    expect(isIndexable({ NEXT_PUBLIC_SITE_URL: "http://localhost:3000" })).toBe(false);
  });
});

describe("canonical y hreflang", () => {
  it("es sin prefijo, ca con /ca y x-default al castellano", () => {
    expect(localePath("/", "ca")).toBe("/ca");
    expect(alternatesFor("/oposiciones", "ca")).toEqual({
      canonical: "/ca/oposiciones",
      languages: { es: "/oposiciones", ca: "/ca/oposiciones", "x-default": "/oposiciones" },
    });
    expect(alternatesFor("/", "es").canonical).toBe("/");
  });
});

describe("verificación de buscadores", () => {
  it("solo emite las etiquetas configuradas", () => {
    expect(searchVerification({})).toBeUndefined();
    expect(searchVerification({ GOOGLE_SITE_VERIFICATION: "g1" })).toEqual({ google: "g1" });
    expect(searchVerification({ BING_SITE_VERIFICATION: "b1" })).toEqual({
      other: { "msvalidate.01": "b1" },
    });
  });
});

describe("JSON-LD", () => {
  it("escapa < para que el contenido no cierre el script", () => {
    const html = renderToStaticMarkup(JsonLd({ data: faqLd([{ q: "</script><b>", a: "x" }]) }));
    expect(html).not.toContain("</script><b>");
    expect(html).toContain("\\u003c/script>");
  });
});

describe("guías públicas", () => {
  it("hay una página por cada tipo de psicotécnico disponible, con slug único", () => {
    const slugs = psychoGuides().map((g) => g.slug);
    expect(new Set(slugs).size).toBe(slugs.length);
    expect(
      psychoGuides()
        .map((g) => g.type)
        .sort(),
    ).toEqual([...availableTypes()].sort());
    for (const g of psychoGuides()) {
      expect(g.slug).toMatch(/^[a-z0-9-]+$/);
      expect(g.description.es.length).toBeLessThanOrEqual(200);
      expect(g.description.ca.length).toBeLessThanOrEqual(200);
    }
  });
  it("las guías de oposición citan fuentes oficiales y solo tipos existentes", () => {
    for (const g of examGuides()) {
      expect(g.sources.length).toBeGreaterThan(0);
      for (const s of g.sources)
        expect(s.url).toMatch(
          /^https:\/\/(.+\.)?(gencat\.cat|boe\.es|inap\.gob\.es|mjusticia\.gob\.es|policia\.es|guardiacivil\.es|barcelona\.cat|terrassa\.cat|diba\.cat|institucionpenitenciaria\.es)\//,
        );
      for (const t of g.psychoTypes) expect(PSYCHO_TYPES).toContain(t);
      expect(g.seoTitle.es.length).toBeLessThanOrEqual(70);
      expect(g.verifiedOn).toMatch(/^\d{4}-\d{2}-\d{2}$/);
    }
  });
  it("llms.txt enlaza oposiciones y psicotécnicos", () => {
    const txt = buildLlmsTxt([
      {
        slug: "mossos-esquadra",
        name: "Mossos d'Esquadra",
        name_ca: null,
        short_description: null,
        availability: "available",
        updated_at: null,
      },
    ]);
    expect(txt).toMatch(/^# OPOSAPRUEBA/);
    expect(txt).toContain("/oposiciones/mossos-esquadra");
    expect(txt).toContain("/psicotecnicos/interpretacion-de-tablas");
  });
});

describe("examShortName (ADR-050)", () => {
  it("quita «Oposiciones a» y la convocatoria, en los dos idiomas", async () => {
    const { examGuides, examShortName, getExamGuide } = await import("@/lib/seo/exam-guides");
    const mossos = getExamGuide("mossos-esquadra")!;
    expect(examShortName(mossos, "es")).toBe("Mossos d'Esquadra");
    expect(examShortName(mossos, "ca")).toBe("Mossos d'Esquadra");
    for (const g of examGuides()) {
      for (const l of ["es", "ca"]) {
        const n = examShortName(g, l);
        expect(n).not.toMatch(/^Oposici/i);
        expect(n.charAt(0)).toBe(n.charAt(0).toUpperCase());
      }
    }
  });
});

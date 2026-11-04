import { BRAND, absoluteUrl, siteUrl } from "./site";

/**
 * Datos estructurados Schema.org (ADR-025). Solo información real y comprobable:
 * nada de valoraciones, testimonios, cifras de alumnos ni precios sin fijar.
 */
type Thing = Record<string, unknown>;

/** Inserta JSON-LD escapando «<» para que el contenido no pueda cerrar el <script>. */
export function JsonLd({ data }: { data: Thing | Thing[] }) {
  const json = JSON.stringify(data).replace(/</g, "\\u003c");
  return <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: json }} />;
}

export const orgId = () => `${siteUrl()}/#organization`;
export const websiteId = () => `${siteUrl()}/#website`;

export function organizationLd(description: string): Thing {
  return {
    "@context": "https://schema.org",
    "@type": "EducationalOrganization",
    "@id": orgId(),
    name: BRAND,
    url: `${siteUrl()}/`,
    logo: `${siteUrl()}/logo-512.png`,
    description,
    areaServed: { "@type": "Country", name: "España" },
    knowsLanguage: ["es", "ca"],
  };
}

export function websiteLd(locale: string, description: string): Thing {
  return {
    "@context": "https://schema.org",
    "@type": "WebSite",
    "@id": websiteId(),
    name: BRAND,
    url: `${siteUrl()}/`,
    inLanguage: locale === "ca" ? "ca-ES" : "es-ES",
    description,
    publisher: { "@id": orgId() },
  };
}

export function breadcrumbLd(items: { name: string; path: string }[], locale: string): Thing {
  return {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: items.map((it, i) => ({
      "@type": "ListItem",
      position: i + 1,
      name: it.name,
      item: absoluteUrl(it.path, locale),
    })),
  };
}

export function faqLd(qas: { q: string; a: string }[]): Thing {
  return {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: qas.map(({ q, a }) => ({
      "@type": "Question",
      name: q,
      acceptedAnswer: { "@type": "Answer", text: a },
    })),
  };
}

/** Ejercicio interactivo gratuito (página de un tipo de psicotécnico). */
export function quizLd(opts: {
  name: string;
  description: string;
  path: string;
  locale: string;
  teaches: string;
}): Thing {
  return {
    "@context": "https://schema.org",
    "@type": ["LearningResource", "Quiz"],
    name: opts.name,
    description: opts.description,
    url: absoluteUrl(opts.path, opts.locale),
    inLanguage: opts.locale === "ca" ? "ca-ES" : "es-ES",
    learningResourceType: "Quiz",
    educationalUse: "practice",
    interactivityType: "active",
    isAccessibleForFree: true,
    teaches: opts.teaches,
    audience: { "@type": "EducationalAudience", educationalRole: "student" },
    provider: { "@id": orgId() },
    publisher: { "@id": orgId() },
  };
}

/** Página guía de una oposición: describe el examen oficial con sus fuentes. */
export function examGuideLd(opts: {
  name: string;
  description: string;
  path: string;
  locale: string;
  about: string;
  dateModified: string;
  citations: { name: string; url: string }[];
}): Thing {
  return {
    "@context": "https://schema.org",
    "@type": "WebPage",
    name: opts.name,
    description: opts.description,
    url: absoluteUrl(opts.path, opts.locale),
    inLanguage: opts.locale === "ca" ? "ca-ES" : "es-ES",
    dateModified: opts.dateModified,
    isPartOf: { "@id": websiteId() },
    publisher: { "@id": orgId() },
    about: { "@type": "Thing", name: opts.about },
    citation: opts.citations.map((c) => ({ "@type": "CreativeWork", name: c.name, url: c.url })),
  };
}

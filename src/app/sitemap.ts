import type { MetadataRoute } from "next";
import { locales } from "@/i18n/routing";
import { listPublicExams, isExamIndexable } from "@/lib/seo/catalog";
import { getExamGuide } from "@/lib/seo/exam-guides";
import { physicalGuides } from "@/lib/seo/physical-tests";
import { psychoGuides } from "@/lib/seo/psycho-guides";
import { absoluteUrl } from "@/lib/seo/site";
import { examSampleQuestions, SAMPLE_MIN } from "@/lib/learning/sample/queries";

// Se regenera cada hora para recoger oposiciones que pasen a «disponible».
export const revalidate = 3600;

type Entry = MetadataRoute.Sitemap[number];

/** Una entrada por idioma, cada una con sus alternativas hreflang. */
function entries(
  path: string,
  opts: Pick<Entry, "changeFrequency" | "priority" | "lastModified"> = {},
): MetadataRoute.Sitemap {
  const languages = Object.fromEntries(locales.map((l) => [l, absoluteUrl(path, l)]));
  return locales.map((l) => ({
    url: absoluteUrl(path, l),
    alternates: { languages },
    ...opts,
  }));
}

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const exams = (await listPublicExams()).filter(isExamIndexable);
  // Test gratis sin registro (ADR-041): solo si hay preguntas suficientes.
  const withSample = (
    await Promise.all(
      exams.map(async (e) =>
        (await examSampleQuestions(e.slug, "es")).length >= SAMPLE_MIN ? e.slug : null,
      ),
    )
  ).filter((s): s is string => s !== null);
  return [
    ...entries("/", { changeFrequency: "weekly", priority: 1 }),
    ...entries("/oposiciones", { changeFrequency: "weekly", priority: 0.9 }),
    ...exams.flatMap((e) =>
      entries(`/oposiciones/${e.slug}`, {
        changeFrequency: "weekly",
        priority: 0.8,
        lastModified: getExamGuide(e.slug)?.verifiedOn ?? e.updated_at ?? undefined,
      }),
    ),
    ...withSample.flatMap((slug) =>
      entries(`/oposiciones/${slug}/test`, { changeFrequency: "daily", priority: 0.8 }),
    ),
    ...physicalGuides()
      .filter((g) => exams.some((e) => e.slug === g.examSlug))
      .flatMap((g) =>
        entries(`/oposiciones/${g.examSlug}/prueba-fisica`, {
          changeFrequency: "weekly",
          priority: 0.8,
          lastModified: g.verifiedOn,
        }),
      ),
    ...entries("/psicotecnicos", { changeFrequency: "monthly", priority: 0.8 }),
    ...psychoGuides().flatMap((g) =>
      entries(`/psicotecnicos/${g.slug}`, { changeFrequency: "monthly", priority: 0.7 }),
    ),
  ];
}

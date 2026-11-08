import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowRight } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Alert } from "@/components/ui/form";
import { Breadcrumbs } from "@/components/seo/breadcrumbs";
import { SamplePlayer } from "@/components/questions/sample-player";
import { getExamBody, localized } from "@/lib/catalog/queries";
import { isExamIndexable } from "@/lib/seo/catalog";
import { JsonLd, quizLd } from "@/lib/seo/json-ld";
import { pageMetadata } from "@/lib/seo/site";
import { examSampleQuestions, SAMPLE_MIN } from "@/lib/learning/sample/queries";

/**
 * Test gratis sin registro de una oposición (ADR-041): preguntas publicadas de sus
 * temas gratis, corregidas de una en una y sin guardar nada. Pensada para quien
 * busca «test <oposición>» y quiere practicar ya.
 */
export async function generateMetadata({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]/test">): Promise<Metadata> {
  const { locale, slug } = await params;
  const exam = await getExamBody(slug);
  if (!exam) return {};
  const items = await examSampleQuestions(slug, locale);
  const t = await getTranslations({ locale, namespace: "seo.sample" });
  const name = localized(locale, exam.name, exam.name_ca);
  return pageMetadata({
    path: `/oposiciones/${slug}/test`,
    locale,
    title: t("title", { exam: name, n: items.length }),
    description: t("description", { exam: name, n: items.length }),
    absoluteTitle: true,
    index: isExamIndexable(exam) && items.length >= SAMPLE_MIN,
  });
}

export default async function ExamSampleTestPage({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]/test">) {
  const { locale, slug } = await params;
  setRequestLocale(locale);
  const exam = await getExamBody(slug);
  if (!exam) notFound();
  const items = await examSampleQuestions(slug, locale);
  if (items.length === 0) notFound();
  const t = await getTranslations();
  const name = localized(locale, exam.name, exam.name_ca);
  const path = `/oposiciones/${slug}/test`;
  const otherLanguage = items.some((i) => i.locale !== locale);

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:py-14">
      <JsonLd
        data={quizLd({
          name: t("seo.sample.h1", { exam: name }),
          description: t("seo.sample.description", { exam: name, n: items.length }),
          path,
          locale,
          teaches: name,
        })}
      />
      <Breadcrumbs
        locale={locale}
        label={t("seo.breadcrumbs")}
        items={[
          { name: t("seo.home_crumb"), path: "/" },
          { name: t("nav.catalog"), path: "/oposiciones" },
          { name, path: `/oposiciones/${slug}` },
          { name: t("seo.sample.crumb"), path },
        ]}
      />
      <h1 className="mt-3 text-3xl font-bold sm:text-4xl">{t("seo.sample.h1", { exam: name })}</h1>
      <p className="text-muted-foreground mt-3 text-lg">
        {t("seo.sample.intro", { exam: name, n: items.length })}
      </p>
      {otherLanguage && items[0].locale === "ca" && (
        <Alert className="mt-4">{t("seo.sample.localeNote")}</Alert>
      )}
      <div className="mt-6">
        <SamplePlayer examSlug={slug} items={items} />
      </div>
      <p className="mt-8">
        <Link
          href={`/oposiciones/${slug}`}
          className="text-accent inline-flex items-center gap-1 font-medium hover:underline"
        >
          {t("seo.sample.guide", { exam: name })} <ArrowRight className="size-4" aria-hidden />
        </Link>
      </p>
    </div>
  );
}

import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowRight, ExternalLink } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { Badge, Card } from "@/components/ui/card";
import { getExamBody, listExamTopics, localized } from "@/lib/catalog/queries";
import { Breadcrumbs } from "@/components/seo/breadcrumbs";
import { ExamGuideSection } from "@/components/seo/exam-guide";
import { isExamIndexable } from "@/lib/seo/catalog";
import { getPhysicalGuide } from "@/lib/seo/physical-tests";
import { getExamGuide, tr } from "@/lib/seo/exam-guides";
import { JsonLd, examGuideLd } from "@/lib/seo/json-ld";
import { pageMetadata } from "@/lib/seo/site";
import { examOffer } from "@/lib/store/queries";
import { ExamOfferSection } from "@/components/store/exam-offer";
import { billingStatus } from "@/lib/billing/queries";
import { CheckoutNoticeAlert, parseCheckoutNotice } from "@/components/billing/checkout-notice";
import { examSampleQuestions, SAMPLE_MIN } from "@/lib/learning/sample/queries";
import { ExamVideo } from "@/components/help/exam-video";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]">): Promise<Metadata> {
  const { locale, slug } = await params;
  const exam = await getExamBody(slug);
  if (!exam) return {};
  const guide = getExamGuide(slug);
  return pageMetadata({
    path: `/oposiciones/${slug}`,
    locale,
    title: guide ? tr(guide.seoTitle, locale) : localized(locale, exam.name, exam.name_ca),
    description: guide
      ? tr(guide.seoDescription, locale)
      : localized(locale, exam.short_description, exam.short_description_ca),
    absoluteTitle: !!guide,
    // Las fichas «próximamente» sin guía no aportan contenido propio: noindex, follow.
    index: isExamIndexable(exam),
  });
}

export default async function ExamPage({
  params,
  searchParams,
}: PageProps<"/[locale]/oposiciones/[slug]">) {
  const { locale, slug } = await params;
  const notice = parseCheckoutNotice((await searchParams).compra);
  setRequestLocale(locale);
  const exam = await getExamBody(slug);
  if (!exam) notFound();
  const t = await getTranslations();
  const calls = exam.calls.filter((c) => c.is_published).sort((a, b) => b.year - a.year);
  const tests = [...exam.exam_tests].sort((a, b) => a.order_index - b.order_index);
  const sources = exam.exam_body_sources.map((s) => s.source).filter((s) => s !== null);
  const guide = getExamGuide(exam.slug);
  const [offer, topics, sample] = await Promise.all([
    examOffer(exam.slug),
    guide ? listExamTopics(exam.id) : Promise.resolve([]),
    examSampleQuestions(exam.slug, locale),
  ]);
  const name = localized(locale, exam.name, exam.name_ca);
  const offerSection = offer ? (
    <ExamOfferSection
      examSlug={slug}
      offer={offer}
      locale={locale}
      back={`/oposiciones/${slug}`}
      billing={billingStatus()}
    />
  ) : null;
  const hasSample = sample.length >= SAMPLE_MIN;

  return (
    <div className="mx-auto max-w-4xl px-4 pt-10 pb-28 sm:py-14">
      <Breadcrumbs
        locale={locale}
        label={t("seo.breadcrumbs")}
        items={[
          { name: t("seo.home_crumb"), path: "/" },
          { name: t("nav.catalog"), path: "/oposiciones" },
          { name, path: `/oposiciones/${exam.slug}` },
        ]}
      />
      {guide && (
        <JsonLd
          data={examGuideLd({
            name: tr(guide.seoTitle, locale),
            description: tr(guide.seoDescription, locale),
            path: `/oposiciones/${exam.slug}`,
            locale,
            about: name,
            dateModified: guide.verifiedOn,
            citations: guide.sources.map((s) => ({ name: s.title, url: s.url })),
          })}
        />
      )}
      <div className="mt-4 flex flex-wrap gap-2">
        <Badge
          tone={
            exam.availability === "available"
              ? "success"
              : exam.availability === "partial"
                ? "accent"
                : "warning"
          }
        >
          {t(`availability.${exam.availability}`)}
        </Badge>
        <Badge>{t(`category.${exam.category}`)}</Badge>
      </div>
      <h1 className="mt-3 text-3xl font-bold sm:text-4xl">{guide ? tr(guide.h1, locale) : name}</h1>
      <p className="text-muted-foreground mt-2 text-lg">
        {localized(locale, exam.short_description, exam.short_description_ca)}
      </p>
      {exam.organization && (
        <dl className="mt-4 flex flex-wrap gap-x-6 gap-y-1 text-sm">
          <div className="flex gap-1">
            <dt className="text-muted-foreground">{t("catalog.organization")}:</dt>
            <dd>{exam.organization.name}</dd>
          </div>
          <div className="flex gap-1">
            <dt className="text-muted-foreground">{t("catalog.scope")}:</dt>
            <dd>{t(`scope.${exam.organization.scope}`)}</dd>
          </div>
        </dl>
      )}

      {exam.availability === "coming_soon" && (
        <Alert className="mt-6">{t("catalog.comingSoonNotice")}</Alert>
      )}
      <Button asChild variant="accent" size="lg" className="mt-6">
        <Link href={`/app/onboarding?exam=${exam.slug}`} data-testid="prepare-exam">
          {exam.availability === "coming_soon" ? t("catalog.follow") : t("catalog.prepare")}
        </Link>
      </Button>

      {hasSample && (
        <Link
          href={`/oposiciones/${exam.slug}/test`}
          className="border-border hover:border-accent mt-6 flex items-center justify-between gap-4 rounded-xl border p-4 transition-colors"
          data-testid="sample-test-link"
        >
          <span>
            <span className="block font-semibold">{t("seo.sample.cta", { exam: name })}</span>
            <span className="text-muted-foreground text-sm">
              {t("seo.sample.ctaHint", { n: sample.length })}
            </span>
          </span>
          <ArrowRight className="text-accent size-5 shrink-0" aria-hidden />
        </Link>
      )}

      {getPhysicalGuide(exam.slug) && (
        <Link
          href={`/oposiciones/${exam.slug}/prueba-fisica`}
          className="border-border hover:border-accent mt-3 flex items-center justify-between gap-4 rounded-xl border p-4 transition-colors"
          data-testid="physical-test-link"
        >
          <span>
            <span className="block font-semibold">{t("seo.physical.cta")}</span>
            <span className="text-muted-foreground text-sm">{t("seo.physical.ctaHint")}</span>
          </span>
          <ArrowRight className="text-accent size-5 shrink-0" aria-hidden />
        </Link>
      )}

      <ExamVideo slug={exam.slug} examName={name} locale={locale} />

      <CheckoutNoticeAlert notice={notice} />
      {guide ? (
        <ExamGuideSection guide={guide} locale={locale} topics={topics} offer={offerSection} />
      ) : (
        offerSection
      )}

      <div className="mt-10 grid gap-4">
        {(!guide || calls.length > 0) && (
          <Card>
            <h2 className="text-lg font-semibold">{t("catalog.calls")}</h2>
            {calls.length === 0 ? (
              <p className="text-muted-foreground mt-2 text-sm">{t("catalog.noCalls")}</p>
            ) : (
              <ul className="mt-3 space-y-2 text-sm">
                {calls.map((c) => (
                  <li key={c.id}>
                    {c.year} · {c.title}
                    {c.vacancies ? ` · ${c.vacancies}` : ""}
                  </li>
                ))}
              </ul>
            )}
          </Card>
        )}
        {(!guide || tests.length > 0) && (
          <Card>
            <h2 className="text-lg font-semibold">{t("catalog.tests")}</h2>
            {tests.length === 0 ? (
              <p className="text-muted-foreground mt-2 text-sm">{t("catalog.noTests")}</p>
            ) : (
              <ol className="mt-3 list-decimal space-y-1 pl-5 text-sm">
                {tests.map((test) => (
                  <li key={test.id}>{test.name}</li>
                ))}
              </ol>
            )}
          </Card>
        )}
        {(!guide || sources.length > 0) && (
          <Card>
            <h2 className="text-lg font-semibold">{t("catalog.sources")}</h2>
            {sources.length === 0 ? (
              <p className="text-muted-foreground mt-2 text-sm">{t("catalog.noSources")}</p>
            ) : (
              <ul className="mt-3 space-y-1 text-sm">
                {sources.map((s) => (
                  <li key={s.id}>
                    <a
                      href={s.url}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-accent inline-flex items-center gap-1 hover:underline"
                    >
                      {s.title} <ExternalLink className="size-3" aria-hidden />
                    </a>
                  </li>
                ))}
              </ul>
            )}
          </Card>
        )}
      </div>

      {/* Barra fija en móvil: test gratis + oferta siempre a mano (la ficha mide ~7 pantallas). */}
      {exam.availability === "available" && (
        <div
          className="border-border bg-background/95 fixed inset-x-0 bottom-0 z-40 border-t px-4 py-3 backdrop-blur sm:hidden"
          data-testid="exam-sticky-cta"
        >
          <div className="flex gap-2">
            {hasSample && (
              <Button asChild variant="outline" className="flex-1">
                <Link href={`/oposiciones/${exam.slug}/test`}>{t("catalog.stickyTest")}</Link>
              </Button>
            )}
            <Button asChild variant="accent" className="flex-1">
              <Link href={offer ? "#oferta" : `/app/onboarding?exam=${exam.slug}`}>
                {offer ? t("catalog.stickyOffer") : t("catalog.prepare")}
              </Link>
            </Button>
          </div>
        </div>
      )}
    </div>
  );
}

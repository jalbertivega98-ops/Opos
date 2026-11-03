import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowLeft, ExternalLink } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { Badge, Card } from "@/components/ui/card";
import { getExamBody, localized } from "@/lib/catalog/queries";
import { examOffer, premiumPrice } from "@/lib/store/queries";
import { ExamOfferSection } from "@/components/store/exam-offer";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]">): Promise<Metadata> {
  const { locale, slug } = await params;
  const exam = await getExamBody(slug);
  if (!exam) return {};
  return {
    title: localized(locale, exam.name, exam.name_ca),
    description: localized(locale, exam.short_description, exam.short_description_ca),
  };
}

export default async function ExamPage({ params }: PageProps<"/[locale]/oposiciones/[slug]">) {
  const { locale, slug } = await params;
  setRequestLocale(locale);
  const exam = await getExamBody(slug);
  if (!exam) notFound();
  const t = await getTranslations();
  const calls = exam.calls.filter((c) => c.is_published).sort((a, b) => b.year - a.year);
  const tests = [...exam.exam_tests].sort((a, b) => a.order_index - b.order_index);
  const sources = exam.exam_body_sources.map((s) => s.source).filter((s) => s !== null);
  const [offer, premiumCents] = await Promise.all([examOffer(exam.slug), premiumPrice()]);

  return (
    <div className="mx-auto max-w-4xl px-4 py-10 sm:py-14">
      <Link
        href="/oposiciones"
        className="text-muted-foreground inline-flex items-center gap-1 text-sm hover:underline"
      >
        <ArrowLeft className="size-4" aria-hidden /> {t("catalog.back")}
      </Link>
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
      <h1 className="mt-3 text-3xl font-bold sm:text-4xl">
        {localized(locale, exam.name, exam.name_ca)}
      </h1>
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
        <Link href={`/app/onboarding?exam=${exam.slug}`}>
          {exam.availability === "coming_soon" ? t("catalog.follow") : t("catalog.prepare")}
        </Link>
      </Button>

      {offer && <ExamOfferSection offer={offer} locale={locale} premiumCents={premiumCents} />}

      <div className="mt-10 grid gap-4">
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
      </div>
    </div>
  );
}

import type { Metadata } from "next";
import { connection } from "next/server";
import { randomInt } from "node:crypto";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowRight } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { PsychoTrainer } from "@/components/psycho/trainer";
import { Breadcrumbs } from "@/components/seo/breadcrumbs";
import { examHasPsychoMock } from "@/lib/catalog/exam-format";
import { availableTypes, difficultyPlan, generateItem } from "@/lib/learning/psycho/registry";
import { toPublicItem } from "@/lib/learning/psycho/types";
import { examShortName, tr } from "@/lib/seo/exam-guides";
import { getExamPsycho } from "@/lib/seo/exam-psycho";
import { JsonLd, quizLd } from "@/lib/seo/json-ld";
import { psychoGuideByType } from "@/lib/seo/psycho-guides";
import { pageMetadata } from "@/lib/seo/site";

const DEMO_SIZE = 10;

/**
 * «Psicotécnicos de <oposición> gratis» (ADR-063): formato oficial de la prueba (de la
 * guía verificada), 10 ejercicios mezclando los tipos que la entrenan y enlaces a cada tipo.
 */
export async function generateMetadata({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]/psicotecnicos">): Promise<Metadata> {
  const { locale, slug } = await params;
  const p = getExamPsycho(slug);
  if (!p) return {};
  const t = await getTranslations({ locale, namespace: "seo.examPsycho" });
  const exam = examShortName(p.guide, locale);
  return pageMetadata({
    path: `/oposiciones/${slug}/psicotecnicos`,
    locale,
    title: t("title", { exam }),
    description: t("description", { exam, n: p.guide.psychoTypes.length }),
    absoluteTitle: true,
  });
}

export default async function ExamPsychoPage({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]/psicotecnicos">) {
  const { locale, slug } = await params;
  setRequestLocale(locale);
  const p = getExamPsycho(slug);
  if (!p) notFound();
  const t = await getTranslations();
  const tp = await getTranslations("psycho.types");
  // Ejercicios nuevos en cada visita.
  await connection();

  const exam = examShortName(p.guide, locale);
  const path = `/oposiciones/${slug}/psicotecnicos`;
  const types = p.guide.psychoTypes.filter((type) => availableTypes().includes(type));
  if (types.length === 0) notFound();
  // Mezcla los tipos de la oposición, con dificultad creciente.
  const items = difficultyPlan(DEMO_SIZE).map((d, i) =>
    toPublicItem(generateItem(types[i % types.length], randomInt(0, 2 ** 32), d)),
  );

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:py-14">
      <JsonLd
        data={quizLd({
          name: t("seo.examPsycho.h1", { exam }),
          description: t("seo.examPsycho.description", { exam, n: types.length }),
          path,
          locale,
          teaches: t("seo.examPsycho.teaches", { exam }),
        })}
      />
      <Breadcrumbs
        locale={locale}
        label={t("seo.breadcrumbs")}
        items={[
          { name: t("seo.home_crumb"), path: "/" },
          { name: t("nav.catalog"), path: "/oposiciones" },
          { name: exam, path: `/oposiciones/${slug}` },
          { name: t("seo.examPsycho.crumb"), path },
        ]}
      />
      <h1 className="mt-3 text-3xl font-bold sm:text-4xl">{t("seo.examPsycho.h1", { exam })}</h1>
      <p className="text-muted-foreground mt-3 text-lg">{t("seo.examPsycho.intro", { exam })}</p>

      {p.part && (
        <Card className="mt-6" data-testid="official-format">
          <h2 className="text-lg font-semibold">{t("seo.examPsycho.official")}</h2>
          <p className="mt-1 text-sm font-medium">{tr(p.part.name, locale)}</p>
          <p className="text-muted-foreground mt-1">{tr(p.part.detail, locale)}</p>
          <p className="text-muted-foreground mt-3 text-xs">
            {t("seo.examPsycho.verified", { date: p.guide.verifiedOn })}{" "}
            <Link href={`/oposiciones/${slug}`} className="text-accent hover:underline">
              {t("seo.examPsycho.sources")}
            </Link>
          </p>
        </Card>
      )}

      <section aria-labelledby="practice" className="mt-10">
        <h2 id="practice" className="text-2xl font-bold">
          {t("seo.examPsycho.practice")}
        </h2>
        <p className="text-muted-foreground mt-1 text-sm">{t("seo.examPsycho.practiceNote")}</p>
        <div className="mt-6">
          <PsychoTrainer items={items} mode={{ kind: "demo" }} />
        </div>
      </section>

      <section aria-labelledby="types" className="mt-12">
        <h2 id="types" className="text-2xl font-bold">
          {t("seo.examPsycho.types", { exam })}
        </h2>
        <p className="text-muted-foreground mt-1 text-sm">{tr(p.guide.psychoNote, locale)}</p>
        <ul className="mt-4 grid gap-3 sm:grid-cols-2">
          {types.map((type) => {
            const g = psychoGuideByType(type);
            if (!g) return null;
            return (
              <li key={type}>
                <Link
                  href={`/psicotecnicos/${g.slug}`}
                  className="border-border hover:border-accent flex items-center justify-between gap-3 rounded-xl border p-4 transition-colors"
                >
                  <span>
                    <span className="block font-semibold">{tp(`${type}.name`)}</span>
                    <span className="text-muted-foreground text-sm">
                      {t("seo.examPsycho.typeHint")}
                    </span>
                  </span>
                  <ArrowRight className="text-accent size-5 shrink-0" aria-hidden />
                </Link>
              </li>
            );
          })}
        </ul>
      </section>

      {examHasPsychoMock(slug) && (
        <Card className="mt-12">
          <h2 className="text-xl font-bold">{t("seo.examPsycho.mock", { exam })}</h2>
          <p className="text-muted-foreground mt-1">{t("seo.examPsycho.mockHint")}</p>
          <Button asChild variant="accent" size="lg" className="mt-4">
            <Link href={`/app/onboarding?exam=${slug}`}>{t("seo.examPsycho.register")}</Link>
          </Button>
        </Card>
      )}

      <p className="mt-8">
        <Link
          href={`/oposiciones/${slug}`}
          className="text-accent inline-flex items-center gap-1 font-medium hover:underline"
        >
          {t("seo.examPsycho.guide", { exam })} <ArrowRight className="size-4" aria-hidden />
        </Link>
      </p>
    </div>
  );
}

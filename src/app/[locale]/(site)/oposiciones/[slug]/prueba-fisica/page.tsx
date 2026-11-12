import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowRight, ExternalLink } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Breadcrumbs } from "@/components/seo/breadcrumbs";
import { FaqList } from "@/components/seo/faq-list";
import { PhysicalCalculator } from "@/components/seo/physical-calculator";
import { getExamBody, localized } from "@/lib/catalog/queries";
import { JsonLd, faqLd } from "@/lib/seo/json-ld";
import { getPhysicalGuide, type Sex } from "@/lib/seo/physical-tests";
import { tr } from "@/lib/seo/psycho-guides";
import { pageMetadata } from "@/lib/seo/site";

/**
 * Guía de la prueba física de una oposición (ADR-052): ejercicios, normas y
 * baremos de las bases oficiales, con una calculadora orientativa de la nota.
 */
export async function generateMetadata({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]/prueba-fisica">): Promise<Metadata> {
  const { locale, slug } = await params;
  const guide = getPhysicalGuide(slug);
  if (!guide) return {};
  return pageMetadata({
    path: `/oposiciones/${slug}/prueba-fisica`,
    locale,
    title: tr(guide.seoTitle, locale),
    description: tr(guide.seoDescription, locale),
    absoluteTitle: true,
  });
}

/** Marca de la tabla con el signo de la fila 0 o 10 («>21,5», «<16,3»). */
function cell(value: number, sign: "<" | ">" | "", locale: string) {
  const n = value.toLocaleString(locale === "ca" ? "ca-ES" : "es-ES");
  return `${sign}${n}`;
}

export default async function PhysicalTestPage({
  params,
}: PageProps<"/[locale]/oposiciones/[slug]/prueba-fisica">) {
  const { locale, slug } = await params;
  setRequestLocale(locale);
  const guide = getPhysicalGuide(slug);
  if (!guide) notFound();
  const exam = await getExamBody(slug);
  if (!exam) notFound();
  const t = await getTranslations();
  const format = await getFormatter();
  const name = localized(locale, exam.name, exam.name_ca);
  const path = `/oposiciones/${slug}/prueba-fisica`;
  const faq = guide.faq.map(({ q, a }) => ({ q: tr(q, locale), a: tr(a, locale) }));
  const verified = format.dateTime(new Date(`${guide.verifiedOn}T12:00:00Z`), {
    day: "numeric",
    month: "long",
    year: "numeric",
  });
  const sexes: Sex[] = ["men", "women"];

  return (
    <div className="mx-auto max-w-4xl px-4 py-10 sm:py-14">
      <JsonLd data={faqLd(faq)} />
      <Breadcrumbs
        locale={locale}
        label={t("seo.breadcrumbs")}
        items={[
          { name: t("seo.home_crumb"), path: "/" },
          { name: t("nav.catalog"), path: "/oposiciones" },
          { name, path: `/oposiciones/${slug}` },
          { name: t("seo.physical.crumb"), path },
        ]}
      />
      <h1 className="mt-3 text-3xl font-bold sm:text-4xl">{tr(guide.h1, locale)}</h1>
      <p className="text-muted-foreground mt-3 text-lg">{tr(guide.intro, locale)}</p>

      <dl className="border-border mt-8 divide-y rounded-2xl border">
        {guide.facts.map((f) => (
          <div key={f.label.es} className="grid gap-1 px-5 py-3 sm:grid-cols-[12rem_1fr]">
            <dt className="text-muted-foreground text-sm font-medium">{tr(f.label, locale)}</dt>
            <dd>{tr(f.value, locale)}</dd>
          </div>
        ))}
      </dl>

      <section aria-labelledby="pf-calc" className="mt-10">
        <h2 id="pf-calc" className="text-2xl font-bold">
          {t("seo.physical.calculator")}
        </h2>
        <p className="text-muted-foreground mt-2">{t("seo.physical.calculatorIntro")}</p>
        <div className="mt-4">
          <PhysicalCalculator examSlug={slug} />
        </div>
      </section>

      <section aria-labelledby="pf-scoring" className="mt-10">
        <h2 id="pf-scoring" className="text-2xl font-bold">
          {t("seo.physical.scoring")}
        </h2>
        <ul className="mt-4 grid list-disc gap-2 pl-5">
          {guide.scoring.map((s) => (
            <li key={s.es}>{tr(s, locale)}</li>
          ))}
        </ul>
      </section>

      <section aria-labelledby="pf-exercises" className="mt-10">
        <h2 id="pf-exercises" className="text-2xl font-bold">
          {t("seo.physical.exercises")}
        </h2>
        <div className="mt-4 grid gap-6">
          {guide.exercises.map((ex, i) => (
            <article key={ex.key} className="border-border rounded-2xl border p-5">
              <h3 className="text-lg font-semibold">
                {i + 1}. {tr(ex.name, locale)}
              </h3>
              <p className="text-muted-foreground mt-1">{tr(ex.goal, locale)}</p>
              <ol className="mt-3 grid list-decimal gap-1 pl-5">
                {ex.description.map((d) => (
                  <li key={d.es}>{tr(d, locale)}</li>
                ))}
              </ol>
              <h4 className="mt-4 font-semibold">{t("seo.physical.rules")}</h4>
              <ul className="mt-1 grid list-disc gap-1 pl-5">
                {ex.rules.map((r) => (
                  <li key={r.es}>{tr(r, locale)}</li>
                ))}
              </ul>
              <p className="mt-3 text-sm">
                <strong>{t("seo.physical.attempts")}</strong> {tr(ex.attempts, locale)}
              </p>
            </article>
          ))}
        </div>
      </section>

      <section aria-labelledby="pf-scales" className="mt-10">
        <h2 id="pf-scales" className="text-2xl font-bold">
          {t("seo.physical.scales")}
        </h2>
        <p className="text-muted-foreground mt-2">{t("seo.physical.scalesIntro")}</p>
        <div className="mt-4 grid gap-6 md:grid-cols-2">
          {sexes.map((sex) => (
            <div key={sex} className="overflow-x-auto">
              <table className="border-border w-full border text-sm" data-testid={`scale-${sex}`}>
                <caption className="mb-2 text-left font-semibold">
                  {t(`seo.physical.${sex}`)}
                </caption>
                <thead>
                  <tr className="bg-surface-2">
                    <th scope="col" className="px-2 py-1 text-left">
                      {t("seo.physical.pointsCol")}
                    </th>
                    {guide.exercises.map((ex) => (
                      <th key={ex.key} scope="col" className="px-2 py-1 text-left">
                        {tr(ex.name, locale).split(" (")[0]}
                        <span className="text-muted-foreground block text-xs font-normal">
                          {tr(ex.unit, locale)}
                        </span>
                      </th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {Array.from({ length: 11 }, (_, p) => (
                    <tr key={p} className="border-border border-t">
                      <th scope="row" className="px-2 py-1 text-left">
                        {p}
                      </th>
                      {guide.exercises.map((ex) => {
                        const s = ex.scale[sex];
                        const worse = ex.lowerIsBetter ? ">" : "<";
                        const better = ex.lowerIsBetter ? "<" : ">";
                        const text =
                          p === 0
                            ? cell(s.steps[0], worse, locale)
                            : p === 10
                              ? cell(s.top.value, s.top.strict ? better : "", locale)
                              : cell(s.steps[p - 1], "", locale);
                        return (
                          <td key={ex.key} className="px-2 py-1 tabular-nums">
                            {text}
                          </td>
                        );
                      })}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ))}
        </div>
      </section>

      <section aria-labelledby="pf-after" className="mt-10">
        <h2 id="pf-after" className="text-2xl font-bold">
          {t("seo.physical.after")}
        </h2>
        <p className="mt-3">{tr(guide.after, locale)}</p>
        <Link
          href={`/oposiciones/${slug}`}
          className="border-border hover:border-accent mt-4 flex items-center justify-between gap-4 rounded-xl border p-4 transition-colors"
        >
          <span className="font-semibold">{t("seo.physical.backToExam", { exam: name })}</span>
          <ArrowRight className="text-accent size-5 shrink-0" aria-hidden />
        </Link>
      </section>

      <section aria-labelledby="pf-faq" className="mt-10">
        <h2 id="pf-faq" className="text-2xl font-bold">
          {t("seo.physical.faq")}
        </h2>
        <div className="mt-4">
          <FaqList items={faq} />
        </div>
      </section>

      <section aria-labelledby="pf-sources" className="mt-10">
        <h2 id="pf-sources" className="text-2xl font-bold">
          {t("seo.physical.sources")}
        </h2>
        <ul className="mt-3 grid gap-2">
          {guide.sources.map((s) => (
            <li key={s.url}>
              <a
                href={s.url}
                target="_blank"
                rel="noopener noreferrer"
                className="text-accent inline-flex items-center gap-1 underline-offset-4 hover:underline"
              >
                {s.title}
                <ExternalLink className="size-3.5" aria-hidden />
              </a>
            </li>
          ))}
        </ul>
        <p className="text-muted-foreground mt-4 text-sm">
          {t("seo.guide.verified", { date: verified })}
        </p>
      </section>
    </div>
  );
}

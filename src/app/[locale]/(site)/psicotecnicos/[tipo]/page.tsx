import type { Metadata } from "next";
import { randomInt } from "node:crypto";
import { notFound } from "next/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { ArrowRight } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { PsychoTrainer } from "@/components/psycho/trainer";
import { Breadcrumbs } from "@/components/seo/breadcrumbs";
import { FaqList } from "@/components/seo/faq-list";
import { getSession } from "@/lib/auth/session";
import { availableTypes, difficultyPlan, generateItem } from "@/lib/learning/psycho/registry";
import { toPublicItem, type Difficulty } from "@/lib/learning/psycho/types";
import { WorkedExamples } from "@/components/psycho/worked-examples";
import { examGuides, examShortName, tr as trExam } from "@/lib/seo/exam-guides";
import { JsonLd, faqLd, quizLd } from "@/lib/seo/json-ld";
import { psychoGuideBySlug, psychoGuides, tr } from "@/lib/seo/psycho-guides";
import { pageMetadata } from "@/lib/seo/site";

const DEMO_SIZE = 10;

/** Semillas fijas de los ejemplos resueltos: el contenido no cambia entre visitas. */
const EXAMPLES: { seed: number; difficulty: Difficulty }[] = [
  { seed: 20261110, difficulty: 2 },
  { seed: 20261111, difficulty: 3 },
  { seed: 20261112, difficulty: 4 },
];

export function generateStaticParams() {
  return psychoGuides().map((g) => ({ tipo: g.slug }));
}

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/psicotecnicos/[tipo]">): Promise<Metadata> {
  const { locale, tipo } = await params;
  const g = psychoGuideBySlug(tipo);
  if (!g) return {};
  return pageMetadata({
    path: `/psicotecnicos/${g.slug}`,
    locale,
    title: tr(g.title, locale),
    description: tr(g.description, locale),
  });
}

export default async function PsychoTypePage({
  params,
}: PageProps<"/[locale]/psicotecnicos/[tipo]">) {
  const { locale, tipo } = await params;
  setRequestLocale(locale);
  const g = psychoGuideBySlug(tipo);
  if (!g || !availableTypes().includes(g.type)) notFound();
  const t = await getTranslations("seo.psychoType");
  const tSeo = await getTranslations("seo");
  const tp = await getTranslations("psycho");
  const { user } = await getSession();

  const items = difficultyPlan(DEMO_SIZE).map((d) =>
    toPublicItem(generateItem(g.type, randomInt(0, 2 ** 32), d)),
  );
  const path = `/psicotecnicos/${g.slug}`;
  const title = tr(g.title, locale);
  const faq = g.faq.map(({ q, a }) => ({ q: tr(q, locale), a: tr(a, locale) }));
  const exams = examGuides().filter((e) => e.psychoTypes.includes(g.type));
  const others = psychoGuides().filter((o) => o.slug !== g.slug);
  // Ejemplos resueltos en el HTML (contenido estable para buscadores y lectores).
  const examples = EXAMPLES.map(({ seed, difficulty }) => {
    const it = generateItem(g.type, seed, difficulty);
    return {
      presentation: it.presentation,
      options: it.options,
      solution: it.answerIndex,
      explanation: it.explanation,
    };
  });

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:py-14">
      <JsonLd
        data={[
          quizLd({
            name: title,
            description: tr(g.description, locale),
            path,
            locale,
            teaches: tp(`types.${g.type}.name`),
          }),
          faqLd(faq),
        ]}
      />
      <Breadcrumbs
        locale={locale}
        label={tSeo("breadcrumbs")}
        items={[
          { name: tSeo("home_crumb"), path: "/" },
          { name: tp("title"), path: "/psicotecnicos" },
          { name: tp(`types.${g.type}.name`), path },
        ]}
      />
      <p className="text-accent mt-6 text-sm font-semibold">{t("eyebrow")}</p>
      <h1 className="mt-1 text-3xl font-bold sm:text-4xl">{title}</h1>
      <p className="text-muted-foreground mt-3 text-lg">{tr(g.intro, locale)}</p>

      <section aria-labelledby="practice" className="mt-8">
        <h2 id="practice" className="text-2xl font-bold">
          {t("practice")}
        </h2>
        <p className="text-muted-foreground mt-1 text-sm">{t("practiceNote")}</p>
        <div className="mt-6">
          <PsychoTrainer key={g.type} items={items} mode={{ kind: "demo", signedIn: !!user }} />
        </div>
      </section>

      <section aria-labelledby="method" className="mt-12">
        <h2 id="method" className="text-2xl font-bold">
          {t("method")}
        </h2>
        <ol className="mt-4 list-decimal space-y-2 pl-5">
          {g.method.map((m) => (
            <li key={m.es}>{tr(m, locale)}</li>
          ))}
        </ol>
      </section>

      <section aria-labelledby="examples" className="mt-12">
        <h2 id="examples" className="text-2xl font-bold">
          {t("examples")}
        </h2>
        <p className="text-muted-foreground mt-1 text-sm">{t("examplesNote")}</p>
        <WorkedExamples type={g.type} items={examples} />
      </section>

      {exams.length > 0 && (
        <section aria-labelledby="exams" className="mt-12">
          <h2 id="exams" className="text-2xl font-bold">
            {t("exams")}
          </h2>
          <ul className="mt-4 grid gap-3">
            {exams.map((e) => (
              <li key={e.slug} className="border-border rounded-2xl border p-4">
                <Link
                  href={`/oposiciones/${e.slug}`}
                  className="hover:text-accent inline-flex items-center gap-1 font-semibold"
                >
                  {examShortName(e, locale)}
                  <ArrowRight className="size-4" aria-hidden />
                </Link>
                <p className="text-muted-foreground mt-1 text-sm">{trExam(e.psychoNote, locale)}</p>
              </li>
            ))}
          </ul>
        </section>
      )}

      <section aria-labelledby="faq" className="mt-12">
        <h2 id="faq" className="text-2xl font-bold">
          {t("faq")}
        </h2>
        <div className="mt-4">
          <FaqList items={faq} />
        </div>
      </section>

      <nav aria-labelledby="others" className="mt-12">
        <h2 id="others" className="text-xl font-bold">
          {t("others")}
        </h2>
        <ul className="mt-3 flex flex-wrap gap-2">
          {others.map((o) => (
            <li key={o.slug}>
              <Link
                href={`/psicotecnicos/${o.slug}`}
                className="border-border hover:border-accent hover:text-accent inline-flex rounded-full border px-3 py-1.5 text-sm"
              >
                {tp(`types.${o.type}.name`)}
              </Link>
            </li>
          ))}
        </ul>
      </nav>
    </div>
  );
}

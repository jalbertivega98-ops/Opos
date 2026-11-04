import { randomInt } from "node:crypto";
import { getLocale, getTranslations, setRequestLocale } from "next-intl/server";
import {
  ArrowRight,
  Check,
  FileCheck2,
  Plus,
  RefreshCcw,
  Scale,
  Search,
  CalendarCheck,
  UserCheck,
} from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/card";
import { IconBadge } from "@/components/ui/icon-badge";
import { Eyebrow, Section, SectionHeader } from "@/components/ui/section";
import { Reveal } from "@/components/ui/reveal";
import { PracticePicker } from "@/components/landing/practice-picker";
import { ProductTour, type TourTab } from "@/components/landing/product-tour";
import { listExamBodies, localized, type ExamBodyCard } from "@/lib/catalog/queries";
import { examOffer } from "@/lib/store/queries";
import { availableTypes, generateItem } from "@/lib/learning/psycho/registry";
import { toPublicItem, type PsychoType } from "@/lib/learning/psycho/types";
import { cn } from "@/lib/utils";

const FAQ = ["1", "2", "3", "4", "5"] as const;
const STEPS = [
  { key: "1", icon: Search },
  { key: "2", icon: CalendarCheck },
  { key: "3", icon: RefreshCcw },
] as const;
const TRUST = [
  { key: "sources", icon: FileCheck2 },
  { key: "review", icon: UserCheck },
  { key: "independent", icon: Scale },
] as const;
/** Categorías del selector de la portada (las que existen en el generador). */
const PICKER_TYPES: PsychoType[] = [
  "series",
  "letters",
  "matrices",
  "analogies",
  "spatial",
  "percentages",
];
const PICKER_DIFFICULTY = 2;

export default async function Landing({ params, searchParams }: PageProps<"/[locale]">) {
  const { locale } = await params;
  const { cuenta } = await searchParams;
  setRequestLocale(locale);
  const t = await getTranslations("landing");
  const tNotice = await getTranslations("landingNotice");
  const exams = await listExamBodies({}, 6);

  // Un ejercicio real por categoría; la respuesta se comprueba en el servidor.
  const types = availableTypes();
  const pickerItems = PICKER_TYPES.filter((ty) => types.includes(ty)).map((ty) =>
    toPublicItem(generateItem(ty, randomInt(0, 2 ** 32), PICKER_DIFFICULTY)),
  );

  // Cifras reales (solo agregados publicados) de las oposiciones con contenido.
  const ready = exams.filter((e) => e.availability !== "coming_soon");
  const offers = await Promise.all(ready.map((e) => examOffer(e.slug)));
  const featured = ready.map((exam, i) => ({ exam, offer: offers[i] }));
  const upcoming = exams.filter((e) => e.availability === "coming_soon");

  const point = (k: string) => ({ title: t(`features.${k}.title`), body: t(`features.${k}.body`) });
  const tabs: TourTab[] = [
    {
      id: "training",
      label: t("tour.training.label"),
      title: t("tour.training.title"),
      body: t("tour.training.body"),
      points: [point("tests"), point("psycho"), point("mocks")],
    },
    {
      id: "results",
      label: t("tour.results.label"),
      title: t("tour.results.title"),
      body: t("tour.results.body"),
      points: [
        { title: t("tour.results.explained"), body: t("tour.results.explainedBody") },
        point("review"),
        { ...point("tutor"), soon: t("comingSoon") },
      ],
    },
    {
      id: "progress",
      label: t("tour.progress.label"),
      title: t("tour.progress.title"),
      body: t("tour.progress.body"),
      points: [
        point("plan"),
        { title: t("tour.progress.stats"), body: t("tour.progress.statsBody") },
      ],
    },
  ];

  return (
    <>
      {cuenta === "eliminada" && (
        <div
          role="status"
          className="bg-accent-soft border-border border-b px-4 py-3 text-center text-sm"
        >
          {tNotice("deleted")}
        </div>
      )}

      {/* 1 · Hero: promesa corta + acción principal; a la derecha, un ejercicio real para resolver */}
      <section className="bg-surface bg-grid border-border relative overflow-hidden border-b">
        <HeroDoodles />
        <div className="relative mx-auto grid max-w-6xl gap-12 px-4 pt-12 pb-16 sm:pt-20 sm:pb-24 lg:grid-cols-[1.05fr_1fr] lg:items-center">
          <div className="min-w-0">
            <p className="border-border bg-background text-muted-foreground inline-flex items-center gap-2 rounded-full border px-3 py-1 text-xs font-semibold">
              <span className="bg-accent size-2 rounded-full" aria-hidden />
              {t("eyebrow")}
            </p>
            <h1 className="mt-5 text-4xl leading-[1.05] font-extrabold tracking-tight sm:text-5xl xl:text-[3.75rem]">
              {t.rich("titleRich", { mark: (c) => <span className="marker">{c}</span> })}
            </h1>
            <p className="text-muted-foreground mt-5 max-w-xl text-base sm:text-lg">
              {t("subtitle")}
            </p>
            <p className="mt-3 max-w-xl text-sm font-medium">{t("audience")}</p>

            <div className="mt-8 flex flex-col gap-3 sm:flex-row">
              <Button asChild variant="accent" size="lg" className="h-13 px-7 text-base">
                <Link href="/registro">
                  {t("ctaPrimary")}
                  <ArrowRight aria-hidden />
                </Link>
              </Button>
              <Button asChild variant="outline" size="lg" className="h-13">
                <Link href="/psicotecnicos">{t("demoCta")}</Link>
              </Button>
            </div>
            <ul className="text-muted-foreground mt-5 flex flex-wrap gap-x-5 gap-y-2 text-sm">
              {(t.raw("trustItems") as string[]).map((item) => (
                <li key={item} className="flex items-center gap-1.5">
                  <Check className="text-accent size-4" aria-hidden />
                  {item}
                </li>
              ))}
            </ul>

            <form
              action={`${locale === "es" ? "" : `/${locale}`}/oposiciones`}
              role="search"
              className="border-border mt-10 max-w-xl border-t pt-6"
            >
              <label htmlFor="hero-search" className="text-sm font-semibold">
                {t("searchLabel")}
              </label>
              <div className="mt-2 flex gap-2">
                <div className="relative flex-1">
                  <Search
                    className="text-muted-foreground pointer-events-none absolute top-1/2 left-3 size-4 -translate-y-1/2"
                    aria-hidden
                  />
                  <input
                    id="hero-search"
                    name="q"
                    type="search"
                    placeholder={t("searchPlaceholder")}
                    className="border-input bg-background h-12 w-full rounded-lg border pr-3 pl-9 text-base"
                  />
                </div>
                <Button type="submit" size="lg">
                  {t("searchButton")}
                </Button>
              </div>
            </form>
          </div>

          <div id="probar" className="min-w-0 scroll-mt-20">
            <PracticePicker items={pickerItems} />
          </div>
        </div>
      </section>

      {/* 2 · Cómo funciona: un recorrido con tres paradas */}
      <Section id="como-funciona" className="scroll-mt-20" aria-labelledby="steps-title">
        <Reveal>
          <SectionHeader
            id="steps-title"
            eyebrow={t("stepsEyebrow")}
            title={t("stepsTitle")}
            description={t("stepsSubtitle")}
          />
          <div className="relative mt-12">
            <RoutePath />
            <ol className="relative grid gap-10 md:grid-cols-3 md:gap-8">
              {STEPS.map(({ key, icon }, i) => (
                <li
                  key={key}
                  className={cn("relative", i === 1 && "md:mt-16", i === 2 && "md:mt-4")}
                >
                  <div className="flex items-center gap-4">
                    <span className="bg-ink text-ink-foreground font-display grid size-14 shrink-0 place-items-center rounded-2xl text-2xl font-extrabold tabular-nums shadow-lg shadow-black/10">
                      {i + 1}
                    </span>
                    <IconBadge icon={icon} tone="accent" />
                  </div>
                  <h3 className="mt-4 text-xl font-bold">{t(`steps.${key}.title`)}</h3>
                  <p className="text-muted-foreground mt-2">{t(`steps.${key}.body`)}</p>
                </li>
              ))}
            </ol>
          </div>
        </Reveal>
      </Section>

      {/* 3 · Producto: pestañas entrenamiento / resultados / progreso */}
      <Section
        tone="surface"
        id="funcionalidades"
        className="scroll-mt-20"
        aria-labelledby="features-title"
      >
        <Reveal>
          <SectionHeader
            id="features-title"
            align="center"
            eyebrow={t("featuresEyebrow")}
            title={t("featuresTitle")}
            description={t("featuresSubtitle")}
          />
          <div className="mt-10">
            <ProductTour
              tabs={tabs}
              exampleLabel={t("tour.example")}
              labels={t.raw("tour.labels") as Record<string, string>}
            />
          </div>
        </Reveal>
      </Section>

      {/* 4 · Confianza: franja marina */}
      <Section tone="ink" aria-labelledby="trust-title">
        <Reveal className="grid gap-10 lg:grid-cols-[1fr_1.4fr] lg:items-center">
          <SectionHeader
            id="trust-title"
            onInk
            eyebrow={t("trustEyebrow")}
            title={t("trustTitle")}
            description={t("trustBody")}
          />
          <ul className="grid gap-4 sm:grid-cols-3 lg:grid-cols-1">
            {TRUST.map(({ key, icon }) => (
              <li key={key} className="bg-ink-2 flex gap-4 rounded-2xl p-5">
                <IconBadge icon={icon} tone="onInk" />
                <div>
                  <h3 className="font-semibold">{t(`trust.${key}.title`)}</h3>
                  <p className="text-ink-muted mt-1 text-sm">{t(`trust.${key}.body`)}</p>
                </div>
              </li>
            ))}
          </ul>
        </Reveal>
      </Section>

      {/* 5 · Catálogo: disponibles con cifras reales; el resto, en lista */}
      <Section aria-labelledby="catalog-title">
        <Reveal>
          <SectionHeader
            id="catalog-title"
            eyebrow={t("catalogEyebrow")}
            title={t("catalogTitle")}
            description={t("catalogSubtitle")}
            action={
              <Button asChild variant="outline">
                <Link href="/oposiciones">
                  {t("catalogCta")} <ArrowRight aria-hidden />
                </Link>
              </Button>
            }
          />
          {featured.length > 0 && (
            <div className={cn("mt-8 grid gap-4", featured.length > 1 && "md:grid-cols-2")}>
              {featured.map(({ exam, offer }) => (
                <FeaturedExam
                  key={exam.id}
                  exam={exam}
                  questions={offer?.questions ?? 0}
                  topics={offer?.topics ?? 0}
                />
              ))}
            </div>
          )}
          {upcoming.length > 0 && (
            <div className="mt-8">
              <p className="text-sm font-semibold">{t("catalogUpcoming")}</p>
              <ul className="mt-3 flex flex-wrap gap-2">
                {upcoming.map((exam) => (
                  <UpcomingExam key={exam.id} exam={exam} />
                ))}
              </ul>
            </div>
          )}
        </Reveal>
      </Section>

      {/* 6 · Precios */}
      <Section tone="surface" id="precios" className="scroll-mt-20" aria-labelledby="pricing-title">
        <Reveal>
          <SectionHeader
            id="pricing-title"
            align="center"
            eyebrow={t("pricingEyebrow")}
            title={t("pricingTitle")}
            description={t("pricingSubtitle")}
          />
          <div className="mx-auto mt-10 grid max-w-4xl gap-4 md:grid-cols-2">
            {(["free", "premium"] as const).map((plan) => (
              <div
                key={plan}
                className={cn(
                  "flex flex-col rounded-2xl border p-6 sm:p-8",
                  plan === "premium"
                    ? "bg-ink text-ink-foreground border-transparent"
                    : "border-border bg-background",
                )}
              >
                <h3 className="text-xl font-bold">{t(`${plan}.name`)}</h3>
                <p className="mt-3">
                  <span className="font-display text-5xl font-extrabold">{t(`${plan}.price`)}</span>{" "}
                  <span className={plan === "premium" ? "text-ink-muted" : "text-muted-foreground"}>
                    {t(`${plan}.period`)}
                  </span>
                </p>
                <ul className="mt-6 flex-1 space-y-3 text-sm">
                  {(t.raw(`${plan}.items`) as string[]).map((item) => (
                    <li key={item} className="flex gap-2">
                      <Check
                        className={cn(
                          "mt-0.5 size-4 shrink-0",
                          plan === "premium" ? "text-highlight" : "text-accent",
                        )}
                        aria-hidden
                      />
                      {item}
                    </li>
                  ))}
                </ul>
                <div className="mt-8">
                  {plan === "free" ? (
                    <Button asChild variant="accent" size="lg" className="w-full">
                      <Link href="/registro">{t("free.cta")}</Link>
                    </Button>
                  ) : (
                    <>
                      <Button
                        className="bg-ink-foreground text-ink w-full disabled:opacity-70"
                        size="lg"
                        disabled
                      >
                        {t("premium.cta")}
                      </Button>
                      <p className="text-ink-muted mt-2 text-center text-xs">{t("premium.note")}</p>
                    </>
                  )}
                </div>
              </div>
            ))}
          </div>
        </Reveal>
      </Section>

      {/* 7 · FAQ */}
      <Section id="faq" aria-labelledby="faq-title">
        <Reveal className="grid gap-8 lg:grid-cols-[1fr_2fr] lg:items-start">
          <SectionHeader id="faq-title" eyebrow={t("faqEyebrow")} title={t("faqTitle")} />
          <div className="divide-border border-border divide-y rounded-2xl border">
            {FAQ.map((n) => (
              <details key={n} className="group px-5">
                <summary className="flex min-h-14 cursor-pointer list-none items-center justify-between gap-4 py-4 font-semibold [&::-webkit-details-marker]:hidden">
                  {t(`faq.q${n}`)}
                  <Plus
                    className="text-accent size-5 shrink-0 transition-transform group-open:rotate-45"
                    aria-hidden
                  />
                </summary>
                <p className="text-muted-foreground pb-5 text-sm">{t(`faq.a${n}`)}</p>
              </details>
            ))}
          </div>
        </Reveal>
      </Section>

      {/* 8 · CTA final */}
      <section className="px-4 pb-16 sm:pb-24">
        <Reveal className="bg-ink text-ink-foreground bg-grid relative mx-auto max-w-6xl overflow-hidden rounded-3xl px-6 py-12 text-center sm:px-12 sm:py-16">
          <Eyebrow onInk>{t("finalEyebrow")}</Eyebrow>
          <h2 className="mt-3 text-3xl font-extrabold sm:text-4xl">{t("finalTitle")}</h2>
          <p className="text-ink-muted mx-auto mt-3 max-w-xl">{t("finalBody")}</p>
          <div className="mt-8 flex flex-col justify-center gap-3 sm:flex-row">
            <Button asChild variant="accent" size="lg">
              <Link href="/registro">{t("ctaPrimary")}</Link>
            </Button>
            <Button
              asChild
              size="lg"
              className="text-ink-foreground border border-white/25 bg-transparent hover:bg-white/10"
            >
              <Link href="/oposiciones">{t("ctaSecondary")}</Link>
            </Button>
          </div>
        </Reveal>
      </section>
    </>
  );
}

/** Oposición con contenido: cifras publicadas reales (preguntas y temas). */
async function FeaturedExam({
  exam,
  questions,
  topics,
}: {
  exam: ExamBodyCard;
  questions: number;
  topics: number;
}) {
  const locale = await getLocale();
  const t = await getTranslations();
  const fmt = new Intl.NumberFormat(locale === "ca" ? "ca-ES" : "es-ES");
  return (
    <Link
      href={`/oposiciones/${exam.slug}`}
      data-testid="featured-exam"
      className="group press border-border bg-background hover:border-accent relative flex flex-col gap-5 overflow-hidden rounded-3xl border p-6 transition-colors sm:p-7"
    >
      <span aria-hidden className="bg-accent absolute inset-y-0 left-0 w-1.5" />
      <div className="flex flex-wrap items-center gap-2">
        <Badge tone={exam.availability === "available" ? "success" : "accent"}>
          {t(`availability.${exam.availability}`)}
        </Badge>
        <Badge>{t(`category.${exam.category}`)}</Badge>
      </div>
      <div>
        <h3 className="group-hover:text-accent text-xl font-bold">
          {localized(locale, exam.name, exam.name_ca)}
        </h3>
        <p className="text-muted-foreground mt-1 text-sm">
          {localized(locale, exam.short_description, exam.short_description_ca)}
        </p>
      </div>
      <dl className="mt-auto flex gap-8">
        <div>
          <dt className="text-muted-foreground text-xs font-semibold">
            {t("landing.statQuestions")}
          </dt>
          <dd className="font-display text-3xl font-extrabold tabular-nums">
            {fmt.format(questions)}
          </dd>
        </div>
        <div>
          <dt className="text-muted-foreground text-xs font-semibold">{t("landing.statTopics")}</dt>
          <dd className="font-display text-3xl font-extrabold tabular-nums">
            {fmt.format(topics)}
          </dd>
        </div>
      </dl>
    </Link>
  );
}

async function UpcomingExam({ exam }: { exam: ExamBodyCard }) {
  const locale = await getLocale();
  const t = await getTranslations();
  return (
    <li>
      <Link
        href={`/oposiciones/${exam.slug}`}
        className="press border-border bg-background hover:border-accent inline-flex min-h-11 items-center gap-2 rounded-full border px-4 text-sm font-medium"
      >
        {localized(locale, exam.name, exam.name_ca)}
        <span className="text-warning text-[11px] font-bold">{t("availability.coming_soon")}</span>
      </Link>
    </li>
  );
}

/** Ilustración propia: trazos de cuaderno (casilla marcada, serie y flecha), solo decorativa. */
function HeroDoodles() {
  return (
    <svg
      aria-hidden
      viewBox="0 0 1200 600"
      preserveAspectRatio="xMidYMid slice"
      className="pointer-events-none absolute inset-0 hidden h-full w-full lg:block"
      fill="none"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <g className="stroke-accent/25" strokeWidth="3">
        <rect x="560" y="70" width="44" height="44" rx="10" />
        <path d="M570 93 l10 10 l18 -22" className="stroke-highlight" strokeWidth="4" />
      </g>
      <path
        d="M520 520 C 600 470, 640 560, 720 500"
        className="stroke-ink/15 dark:stroke-ink-foreground/15"
        strokeWidth="3"
        strokeDasharray="2 10"
      />
      <path
        d="M708 488 l14 12 l-16 8"
        className="stroke-ink/15 dark:stroke-ink-foreground/15"
        strokeWidth="3"
      />
      <circle cx="1150" cy="80" r="70" className="fill-highlight/20" stroke="none" />
    </svg>
  );
}

/** Ilustración propia: camino discontinuo que une los tres pasos. */
function RoutePath() {
  return (
    <svg
      aria-hidden
      viewBox="0 0 1000 120"
      preserveAspectRatio="none"
      className="pointer-events-none absolute top-2 left-0 hidden h-28 w-full md:block"
      fill="none"
    >
      <path
        d="M40 30 C 220 30, 260 100, 380 96 S 600 40, 700 44 S 900 40, 980 20"
        className="stroke-accent/40"
        strokeWidth="3"
        strokeDasharray="4 12"
        strokeLinecap="round"
      />
    </svg>
  );
}

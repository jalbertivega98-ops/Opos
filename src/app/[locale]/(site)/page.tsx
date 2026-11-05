import { getTranslations, setRequestLocale } from "next-intl/server";
import {
  ArrowRight,
  BookOpen,
  BrainCircuit,
  CalendarCheck,
  Check,
  ClipboardList,
  FileCheck2,
  Plus,
  RefreshCcw,
  Scale,
  Search,
  Shapes,
  Timer,
  UserCheck,
} from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/card";
import { IconBadge } from "@/components/ui/icon-badge";
import { Eyebrow, Section, SectionHeader } from "@/components/ui/section";
import { Meter, ProgressRing } from "@/components/ui/progress";
import { ExamCard } from "@/components/exam-card";
import { ExerciseSample } from "@/components/landing/exercise-sample";
import { Reveal, type RevealEffect } from "@/components/ui/reveal";
import { listExamBodies } from "@/lib/catalog/queries";
import { billingStatus } from "@/lib/billing/queries";
import { premiumInfo } from "@/lib/store/queries";
import { cn } from "@/lib/utils";
import type { Metadata } from "next";
import { JsonLd, faqLd, organizationLd, websiteLd } from "@/lib/seo/json-ld";
import { pageMetadata } from "@/lib/seo/site";

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

export async function generateMetadata({ params }: PageProps<"/[locale]">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "seo.home" });
  return pageMetadata({
    path: "/",
    locale,
    title: t("title"),
    description: t("description"),
    absoluteTitle: true,
  });
}

export default async function Landing({ params, searchParams }: PageProps<"/[locale]">) {
  const { locale } = await params;
  const { cuenta } = await searchParams;
  setRequestLocale(locale);
  const t = await getTranslations("landing");
  const tNotice = await getTranslations("landingNotice");
  const [exams, premium] = await Promise.all([listExamBodies({}, 6), premiumInfo()]);
  // Premium a la venta: pagos activos y producto publicado con precio mensual
  const premiumOn = billingStatus().enabled && premium.published && premium.cents !== null;

  const tSeo = await getTranslations("seo");
  const faqItems = FAQ.map((n) => ({ q: t(`faq.q${n}`), a: t(`faq.a${n}`) }));

  return (
    <>
      <JsonLd
        data={[
          organizationLd(tSeo("org")),
          websiteLd(locale, tSeo("home.description")),
          faqLd(faqItems),
        ]}
      />
      {cuenta === "eliminada" && (
        <div
          role="status"
          className="bg-accent-soft border-border border-b px-4 py-3 text-center text-sm"
        >
          {tNotice("deleted")}
        </div>
      )}

      {/* 1 · Hero: qué es, para quién y acción principal + muestra del entrenamiento */}
      <section className="bg-surface bg-grid border-border relative overflow-hidden border-b">
        <div className="wrap grid gap-12 pt-12 pb-16 sm:pt-20 sm:pb-24 lg:grid-cols-[1.1fr_1fr] lg:items-center 2xl:gap-24 2xl:pt-28 2xl:pb-32">
          <div>
            <p className="border-border bg-background text-muted-foreground inline-flex items-center gap-2 rounded-full border px-3 py-1 text-xs font-semibold">
              <span className="bg-accent size-2 rounded-full" aria-hidden />
              {t("eyebrow")}
            </p>
            <h1 className="mt-5 text-4xl leading-[1.08] font-extrabold sm:text-5xl xl:text-[3.5rem] 2xl:text-7xl">
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

          <div className="relative mx-auto w-full max-w-md lg:max-w-none">
            <p className="mb-3 flex items-center gap-2 text-sm font-semibold">
              <Badge tone="accent">{t("sample.badge")}</Badge>
              {t("sample.title")}
            </p>
            <ExerciseSample />
            <div className="scroll-drift">
              <ProgressPreview
                title={t("preview.title")}
                note={t("preview.note")}
                accuracy={t("preview.accuracy")}
                rows={t.raw("preview.rows") as string[]}
              />
            </div>
          </div>
        </div>
      </section>

      {/* 2 · Cómo funciona: tres pasos */}
      <Section id="como-funciona" className="scroll-mt-20" aria-labelledby="steps-title">
        <Reveal effect="blur">
          <SectionHeader
            id="steps-title"
            eyebrow={t("stepsEyebrow")}
            title={t("stepsTitle")}
            description={t("stepsSubtitle")}
          />
        </Reveal>
        <ol className="mt-10 grid gap-6 md:grid-cols-3">
          {STEPS.map(({ key, icon }, i) => (
            <Reveal as="li" key={key} effect="up" delay={i * 150} className="relative">
              <div className="flex items-center gap-4">
                <span className="font-display text-ink dark:text-highlight text-5xl leading-none font-extrabold tabular-nums">
                  {i + 1}
                </span>
                <IconBadge icon={icon} tone="accent" />
                {i < STEPS.length - 1 && (
                  <span aria-hidden className="bg-border hidden h-px flex-1 md:block" />
                )}
              </div>
              <h3 className="mt-4 text-xl font-bold">{t(`steps.${key}.title`)}</h3>
              <p className="text-muted-foreground mt-2">{t(`steps.${key}.body`)}</p>
            </Reveal>
          ))}
        </ol>
      </Section>

      {/* 3 · Qué puedes entrenar: bento con vistas del producto */}
      <Section
        tone="surface"
        id="funcionalidades"
        className="scroll-mt-20"
        aria-labelledby="features-title"
      >
        <Reveal effect="left">
          <SectionHeader
            id="features-title"
            eyebrow={t("featuresEyebrow")}
            title={t("featuresTitle")}
            description={t("featuresSubtitle")}
          />
        </Reveal>
        <div className="mt-10 grid gap-4 md:grid-cols-6">
          <FeatureTile
            effect="left"
            className="md:col-span-3"
            icon={ClipboardList}
            title={t("features.tests.title")}
            body={t("features.tests.body")}
          >
            <QuestionMini source={t("minis.source")} explanation={t("minis.explanation")} />
          </FeatureTile>
          <FeatureTile
            effect="right"
            className="md:col-span-3"
            icon={Shapes}
            title={t("features.psycho.title")}
            body={t("features.psycho.body")}
            action={
              <Link
                href="/psicotecnicos"
                className="text-accent inline-flex min-h-10 items-center gap-1 text-sm font-semibold hover:underline"
              >
                {t("demoCta")} <ArrowRight className="size-4" aria-hidden />
              </Link>
            }
          >
            <MatrixMini />
          </FeatureTile>
          <FeatureTile
            effect="up"
            className="md:col-span-2"
            icon={CalendarCheck}
            title={t("features.plan.title")}
            body={t("features.plan.body")}
          >
            <ul aria-hidden className="space-y-1.5 text-xs">
              {(t.raw("minis.plan") as string[]).map((row, i) => (
                <li key={row} className="bg-surface flex items-center gap-2 rounded-lg px-3 py-2">
                  {i === 0 ? (
                    <BookOpen className="text-accent size-3.5" />
                  ) : i === 1 ? (
                    <Shapes className="text-accent size-3.5" />
                  ) : (
                    <Timer className="text-accent size-3.5" />
                  )}
                  {row}
                </li>
              ))}
            </ul>
          </FeatureTile>
          <FeatureTile
            effect="up"
            delay={120}
            className="md:col-span-2"
            icon={Timer}
            title={t("features.mocks.title")}
            body={t("features.mocks.body")}
          >
            <div aria-hidden className="flex items-center gap-3">
              <span className="font-display bg-ink text-ink-foreground rounded-lg px-3 py-2 text-xl font-extrabold tabular-nums">
                35:00
              </span>
              <div className="flex flex-wrap gap-1.5">
                {(t.raw("minis.mock") as string[]).map((c) => (
                  <span
                    key={c}
                    className="border-border rounded-full border px-2 py-0.5 text-[11px] font-medium"
                  >
                    {c}
                  </span>
                ))}
              </div>
            </div>
          </FeatureTile>
          <FeatureTile
            effect="up"
            delay={240}
            className="md:col-span-2"
            icon={RefreshCcw}
            title={t("features.review.title")}
            body={t("features.review.body")}
          >
            <div aria-hidden className="space-y-1.5">
              {[0, 1].map((i) => (
                <div
                  key={i}
                  className="bg-highlight-soft flex items-center justify-between rounded-lg px-3 py-2 text-xs"
                >
                  <span className="bg-highlight/70 h-1.5 w-24 rounded-full" />
                  <span className="text-highlight-foreground dark:text-highlight font-semibold">
                    {t("minis.review")}
                  </span>
                </div>
              ))}
            </div>
          </FeatureTile>
          <Reveal
            effect="zoom"
            className="border-border bg-background flex flex-col gap-3 rounded-2xl border border-dashed p-5 sm:flex-row sm:items-center md:col-span-6"
          >
            <IconBadge icon={BrainCircuit} tone="neutral" />
            <div className="flex-1">
              <h3 className="flex flex-wrap items-center gap-2 font-semibold">
                {t("features.tutor.title")} <Badge tone="warning">{t("comingSoon")}</Badge>
              </h3>
              <p className="text-muted-foreground text-sm">{t("features.tutor.body")}</p>
            </div>
          </Reveal>
        </div>
      </Section>

      {/* 4 · Confianza: franja marina */}
      <Section tone="ink" className="scroll-grow" aria-labelledby="trust-title">
        <div className="grid gap-10 lg:grid-cols-[1fr_1.4fr] lg:items-center">
          <SectionHeader
            id="trust-title"
            onInk
            eyebrow={t("trustEyebrow")}
            title={t("trustTitle")}
            description={t("trustBody")}
          />
          <ul className="grid gap-4 sm:grid-cols-3 lg:grid-cols-1">
            {TRUST.map(({ key, icon }, i) => (
              <Reveal
                as="li"
                key={key}
                effect="right"
                delay={i * 120}
                className="bg-ink-2 flex gap-4 rounded-2xl p-5"
              >
                <IconBadge icon={icon} tone="onInk" />
                <div>
                  <h3 className="font-semibold">{t(`trust.${key}.title`)}</h3>
                  <p className="text-ink-muted mt-1 text-sm">{t(`trust.${key}.body`)}</p>
                </div>
              </Reveal>
            ))}
          </ul>
        </div>
      </Section>

      {/* 5 · Catálogo */}
      <Section aria-labelledby="catalog-title">
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
        <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3 2xl:gap-6">
          {exams.map((exam, i) => (
            <Reveal key={exam.id} effect="zoom" delay={(i % 3) * 100}>
              <ExamCard exam={exam} />
            </Reveal>
          ))}
        </div>
      </Section>

      {/* 6 · Precios */}
      <Section tone="surface" id="precios" className="scroll-mt-20" aria-labelledby="pricing-title">
        <SectionHeader
          id="pricing-title"
          align="center"
          eyebrow={t("pricingEyebrow")}
          title={t("pricingTitle")}
          description={t("pricingSubtitle")}
        />
        <div className="mx-auto mt-10 grid max-w-4xl gap-4 md:grid-cols-2">
          {(["free", "premium"] as const).map((plan) => (
            <Reveal
              key={plan}
              effect={plan === "free" ? "left" : "right"}
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
                    {premiumOn ? (
                      <Button asChild className="bg-ink-foreground text-ink w-full" size="lg">
                        <Link href="/app/productos">{t("premium.ctaOn")}</Link>
                      </Button>
                    ) : (
                      <Button
                        className="bg-ink-foreground text-ink w-full disabled:opacity-70"
                        size="lg"
                        disabled
                      >
                        {t("premium.cta")}
                      </Button>
                    )}
                    <p className="text-ink-muted mt-2 text-center text-xs">
                      {t(premiumOn ? "premium.noteOn" : "premium.note")}
                    </p>
                  </>
                )}
              </div>
            </Reveal>
          ))}
        </div>
      </Section>

      {/* 7 · FAQ */}
      <Section id="faq" aria-labelledby="faq-title">
        <div className="grid gap-8 lg:grid-cols-[1fr_2fr] lg:items-start">
          <SectionHeader id="faq-title" eyebrow={t("faqEyebrow")} title={t("faqTitle")} />
          <Reveal effect="blur" className="divide-border border-border divide-y rounded-2xl border">
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
          </Reveal>
        </div>
      </Section>

      {/* 8 · CTA final */}
      <section className="wrap pb-16 sm:pb-24">
        <Reveal
          effect="tilt"
          className="bg-ink text-ink-foreground bg-grid relative overflow-hidden rounded-3xl px-6 py-12 text-center sm:px-12 sm:py-16 2xl:py-24"
        >
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

function FeatureTile({
  icon,
  title,
  body,
  children,
  action,
  className,
  effect = "up",
  delay = 0,
}: {
  icon: Parameters<typeof IconBadge>[0]["icon"];
  title: string;
  body: string;
  children: React.ReactNode;
  action?: React.ReactNode;
  className?: string;
  effect?: RevealEffect;
  delay?: number;
}) {
  return (
    <Reveal
      effect={effect}
      delay={delay}
      className={cn(
        "border-border bg-background flex flex-col gap-5 rounded-2xl border p-5 sm:p-6",
        className,
      )}
    >
      <div className="flex items-start gap-4">
        <IconBadge icon={icon} />
        <div>
          <h3 className="text-lg font-bold">{title}</h3>
          <p className="text-muted-foreground mt-1 text-sm">{body}</p>
          {action}
        </div>
      </div>
      <div className="mt-auto">{children}</div>
    </Reveal>
  );
}

/** Vista del producto: una pregunta tipo test con su fuente (esquemática, sin contenido real). */
function QuestionMini({ source, explanation }: { source: string; explanation: string }) {
  return (
    <div aria-hidden className="bg-surface space-y-2 rounded-xl p-4">
      <div className="bg-surface-2 h-2.5 w-4/5 rounded-full" />
      <div className="bg-surface-2 h-2.5 w-3/5 rounded-full" />
      <div className="grid gap-1.5 pt-2">
        {[0, 1, 2, 3].map((i) => (
          <div
            key={i}
            className={cn(
              "flex items-center gap-2 rounded-lg border px-3 py-2",
              i === 1 ? "border-success bg-accent-soft" : "border-border bg-background",
            )}
          >
            <span
              className={cn(
                "size-3 rounded-full border-2",
                i === 1 ? "border-success bg-success" : "border-input",
              )}
            />
            <span className="bg-surface-2 h-2 rounded-full" style={{ width: `${40 + i * 12}%` }} />
          </div>
        ))}
      </div>
      <div className="flex flex-wrap items-center gap-2 pt-1 text-[11px] font-semibold">
        <span className="bg-background border-border inline-flex items-center gap-1 rounded-full border px-2 py-0.5">
          <FileCheck2 className="text-accent size-3" /> {source}
        </span>
        <span className="text-muted-foreground">{explanation}</span>
      </div>
    </div>
  );
}

/** Vista del producto: matriz de figuras con la casilla a resolver. */
function MatrixMini() {
  const cells = [
    "circle",
    "square",
    "triangle",
    "square",
    "triangle",
    "circle",
    "triangle",
    "circle",
    "?",
  ];
  return (
    <div aria-hidden className="bg-surface flex justify-center rounded-xl p-4">
      <div className="grid grid-cols-3 gap-2">
        {cells.map((c, i) => (
          <span
            key={i}
            className={cn(
              "grid size-12 place-items-center rounded-lg",
              c === "?"
                ? "border-accent text-accent border-2 border-dashed text-lg font-extrabold"
                : "bg-background border-border border",
            )}
          >
            {c === "circle" && <span className="bg-ink dark:bg-ink-muted size-5 rounded-full" />}
            {c === "square" && <span className="bg-accent size-5 rounded-sm" />}
            {c === "triangle" && (
              <svg viewBox="0 0 20 20" className="fill-highlight size-5">
                <path d="M10 2 19 18H1z" />
              </svg>
            )}
            {c === "?" && "?"}
          </span>
        ))}
      </div>
    </div>
  );
}

/** Vista del panel con valores de ejemplo, marcada como tal. */
function ProgressPreview({
  title,
  note,
  accuracy,
  rows,
}: {
  title: string;
  note: string;
  accuracy: string;
  rows: string[];
}) {
  const values = [80, 55, 30];
  return (
    <div className="border-border bg-background mt-4 flex items-center gap-5 rounded-2xl border p-4 shadow-lg shadow-black/5 sm:ml-12">
      <ProgressRing value={68} size={76} stroke={8} label={`${title}: ${note}`}>
        <span className="font-display text-lg font-extrabold tabular-nums">68%</span>
      </ProgressRing>
      <div className="min-w-0 flex-1 space-y-2" aria-hidden>
        <p className="flex items-center justify-between gap-2 text-sm font-semibold">
          {title}
          <span className="text-muted-foreground text-[11px] font-medium">{note}</span>
        </p>
        <p className="text-muted-foreground text-xs">{accuracy}</p>
        {rows.map((r, i) => (
          <div key={r} className="flex items-center gap-2 text-[11px]">
            <span className="w-20 shrink-0 truncate">{r}</span>
            <Meter value={values[i] ?? 0} max={100} label={r} />
          </div>
        ))}
      </div>
    </div>
  );
}

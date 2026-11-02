import { getTranslations, setRequestLocale } from "next-intl/server";
import {
  BrainCircuit,
  CalendarCheck,
  Check,
  ClipboardList,
  RefreshCcw,
  Search,
  Shapes,
  Timer,
} from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { ExamCard } from "@/components/exam-card";
import { listExamBodies } from "@/lib/catalog/queries";

const FEATURES = [
  { key: "plan", icon: CalendarCheck },
  { key: "tests", icon: ClipboardList },
  { key: "psycho", icon: Shapes },
  { key: "mocks", icon: Timer },
  { key: "review", icon: RefreshCcw },
  { key: "tutor", icon: BrainCircuit },
] as const;

const FAQ = ["1", "2", "3", "4", "5"] as const;

export default async function Landing({ params, searchParams }: PageProps<"/[locale]">) {
  const { locale } = await params;
  const { cuenta } = await searchParams;
  setRequestLocale(locale);
  const t = await getTranslations("landing");
  const exams = await listExamBodies({}, 6);

  const tNotice = await getTranslations("landingNotice");
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
      {/* Hero */}
      <section className="border-border from-surface to-background relative overflow-hidden border-b bg-gradient-to-b">
        <div className="mx-auto grid max-w-6xl gap-10 px-4 py-16 sm:py-24 lg:grid-cols-[1.2fr_1fr] lg:items-center">
          <div className="space-y-6">
            <p className="bg-accent-soft text-accent inline-flex rounded-full px-3 py-1 text-xs font-semibold">
              {t("eyebrow")}
            </p>
            <h1 className="text-4xl leading-tight font-extrabold sm:text-5xl">{t("title")}</h1>
            <p className="text-muted-foreground max-w-xl text-lg">{t("subtitle")}</p>
            <form
              action={`${locale === "es" ? "" : `/${locale}`}/oposiciones`}
              role="search"
              className="flex max-w-xl gap-2"
            >
              <label htmlFor="hero-search" className="sr-only">
                {t("searchLabel")}
              </label>
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
            </form>
            <div className="flex flex-wrap gap-3">
              <Button asChild variant="accent" size="lg">
                <Link href="/registro">{t("ctaPrimary")}</Link>
              </Button>
              <Button asChild variant="outline" size="lg">
                <Link href="/oposiciones">{t("ctaSecondary")}</Link>
              </Button>
            </div>
            <p className="text-muted-foreground text-sm">{t("trust")}</p>
          </div>
          <HeroPreview />
        </div>
      </section>

      {/* Funcionalidades */}
      <section id="funcionalidades" className="mx-auto max-w-6xl scroll-mt-20 px-4 py-16 sm:py-20">
        <h2 className="text-3xl font-bold">{t("featuresTitle")}</h2>
        <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {FEATURES.map(({ key, icon: Icon }) => (
            <Card key={key} className="space-y-3">
              <span className="bg-accent-soft text-accent inline-flex size-10 items-center justify-center rounded-lg">
                <Icon className="size-5" aria-hidden />
              </span>
              <h3 className="font-semibold">{t(`features.${key}.title`)}</h3>
              <p className="text-muted-foreground text-sm">{t(`features.${key}.body`)}</p>
            </Card>
          ))}
        </div>
      </section>

      {/* Catálogo */}
      <section className="border-border bg-surface border-y">
        <div className="mx-auto max-w-6xl px-4 py-16 sm:py-20">
          <div className="flex flex-wrap items-end justify-between gap-4">
            <div>
              <h2 className="text-3xl font-bold">{t("catalogTitle")}</h2>
              <p className="text-muted-foreground mt-2 max-w-2xl">{t("catalogSubtitle")}</p>
            </div>
            <Button asChild variant="outline">
              <Link href="/oposiciones">{t("catalogCta")}</Link>
            </Button>
          </div>
          <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {exams.map((exam) => (
              <ExamCard key={exam.id} exam={exam} />
            ))}
          </div>
        </div>
      </section>

      {/* Precios */}
      <section id="precios" className="mx-auto max-w-6xl scroll-mt-20 px-4 py-16 sm:py-20">
        <h2 className="text-3xl font-bold">{t("pricingTitle")}</h2>
        <p className="text-muted-foreground mt-2">{t("pricingSubtitle")}</p>
        <div className="mt-8 grid gap-4 md:grid-cols-2">
          {(["free", "premium"] as const).map((plan) => (
            <Card
              key={plan}
              className={plan === "premium" ? "border-accent ring-accent ring-1" : undefined}
            >
              <h3 className="text-xl font-bold">{t(`${plan}.name`)}</h3>
              <p className="mt-3">
                <span className="font-display text-4xl font-extrabold">{t(`${plan}.price`)}</span>{" "}
                <span className="text-muted-foreground">{t(`${plan}.period`)}</span>
              </p>
              <ul className="mt-6 space-y-2 text-sm">
                {(t.raw(`${plan}.items`) as string[]).map((item) => (
                  <li key={item} className="flex gap-2">
                    <Check className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                    {item}
                  </li>
                ))}
              </ul>
              <div className="mt-6">
                {plan === "free" ? (
                  <Button asChild className="w-full">
                    <Link href="/registro">{t("free.cta")}</Link>
                  </Button>
                ) : (
                  <>
                    <Button className="w-full" variant="accent" disabled>
                      {t("premium.cta")}
                    </Button>
                    <p className="text-muted-foreground mt-2 text-center text-xs">
                      {t("premium.note")}
                    </p>
                  </>
                )}
              </div>
            </Card>
          ))}
        </div>
      </section>

      {/* FAQ */}
      <section id="faq" className="border-border bg-surface border-t">
        <div className="mx-auto max-w-3xl px-4 py-16 sm:py-20">
          <h2 className="text-3xl font-bold">{t("faqTitle")}</h2>
          <div className="divide-border border-border bg-background mt-8 divide-y rounded-xl border">
            {FAQ.map((n) => (
              <details key={n} className="group p-5">
                <summary className="cursor-pointer list-none font-semibold marker:hidden">
                  {t(`faq.q${n}`)}
                </summary>
                <p className="text-muted-foreground mt-3 text-sm">{t(`faq.a${n}`)}</p>
              </details>
            ))}
          </div>
        </div>
      </section>

      {/* CTA final */}
      <section className="mx-auto max-w-6xl px-4 py-16 text-center sm:py-20">
        <h2 className="text-3xl font-bold">{t("finalTitle")}</h2>
        <p className="text-muted-foreground mx-auto mt-3 max-w-xl">{t("finalBody")}</p>
        <Button asChild variant="accent" size="lg" className="mt-6">
          <Link href="/registro">{t("ctaPrimary")}</Link>
        </Button>
      </section>
    </>
  );
}

/** Ilustración del producto (decorativa, sin datos reales). */
function HeroPreview() {
  return (
    <div
      aria-hidden
      className="border-border bg-background hidden rounded-2xl border p-5 shadow-xl lg:block"
    >
      <div className="flex items-center justify-between">
        <div className="bg-surface-2 h-3 w-32 rounded" />
        <div className="bg-accent-soft h-6 w-16 rounded-full" />
      </div>
      <div className="mt-5 grid grid-cols-3 gap-3">
        {[72, 45, 88].map((v) => (
          <div key={v} className="bg-surface rounded-xl p-3">
            <div className="bg-surface-2 h-2 w-10 rounded" />
            <div className="bg-surface-2 mt-3 h-2 rounded">
              <div className="bg-accent h-2 rounded" style={{ width: `${v}%` }} />
            </div>
          </div>
        ))}
      </div>
      <div className="mt-4 space-y-2">
        {[1, 2, 3].map((i) => (
          <div key={i} className="border-border flex items-center gap-3 rounded-lg border p-3">
            <div className="border-accent size-6 rounded-full border-2" />
            <div className="bg-surface-2 h-2 flex-1 rounded" />
          </div>
        ))}
      </div>
    </div>
  );
}

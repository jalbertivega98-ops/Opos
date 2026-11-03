import { getTranslations } from "next-intl/server";
import { BookOpen, Brain, CalendarCheck, Check, RotateCcw, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card } from "@/components/ui/card";
import { localized } from "@/lib/catalog/queries";
import { formatPrice } from "@/lib/store/schema";
import type { ExamOffer, OfferProduct } from "@/lib/store/queries";
import { BuyForm } from "@/components/billing/buy-form";

/**
 * «Qué incluye»: contenido real publicado, qué es gratis y qué es de pago.
 * Con pagos activos (Stripe) se compra el pack o Premium; si no, el botón sale desactivado.
 */
export async function ExamOfferSection({
  offer,
  locale,
  premiumCents,
  back,
  billing,
}: {
  offer: ExamOffer;
  locale: string;
  premiumCents: number | null;
  back: string;
  billing: { enabled: boolean; testMode: boolean; premium: boolean };
}) {
  const t = await getTranslations("offer");
  if (offer.products.length === 0) return null;
  const bySlug = new Map(offer.products.map((p) => [p.slug, p]));
  const bundle = offer.products.find((p) => p.type === "bundle");
  const included = bundle
    ? bundle.includes.map((s) => bySlug.get(s)).filter((p): p is OfferProduct => !!p)
    : offer.products;
  const mocks = included.filter((p) => p.type === "mock_exam");
  const packs = included.filter((p) => p.type === "question_pack");
  const questions = bundle?.questions || packs.reduce((n, p) => n + p.questions, 0);
  const price = bundle?.price;
  // Qué se compra: el pack completo si tiene precio; si no, Premium
  const buy = !billing.enabled
    ? null
    : bundle && price
      ? {
          slug: bundle.slug,
          label: t("paid.buy", { price: formatPrice(price.amount_cents, locale) }),
        }
      : premiumCents !== null && billing.premium
        ? { slug: "premium", label: t("paid.buyPremium") }
        : null;

  return (
    <section className="mt-10 space-y-4" aria-labelledby="offer-title" data-testid="exam-offer">
      <h2 id="offer-title" className="text-2xl font-bold">
        {t("title")}
      </h2>
      <p className="text-muted-foreground">
        {t("summary", { questions, topics: offer.topics, mocks: mocks.length })}
      </p>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="space-y-3">
          <div>
            <h3 className="text-lg font-semibold">{t("free.title")}</h3>
            <p className="text-muted-foreground text-sm">{t("free.price")}</p>
          </div>
          <ul className="space-y-2 text-sm">
            {(["plan", "psycho", "progress"] as const).map((k) => (
              <li key={k} className="flex gap-2">
                <Check className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                {t(`free.items.${k}`)}
              </li>
            ))}
          </ul>
          <Button asChild className="w-full">
            <Link href="/registro">{t("free.cta")}</Link>
          </Button>
        </Card>

        <Card className="border-accent ring-accent space-y-3 ring-1" data-testid="offer-paid">
          <div>
            <h3 className="text-lg font-semibold">
              {bundle ? localized(locale, bundle.title, bundle.title_ca) : t("paid.title")}
            </h3>
            <p className="text-sm" data-testid="offer-price">
              {price
                ? price.interval
                  ? t("paid.priceRecurring", {
                      price: formatPrice(price.amount_cents, locale),
                      interval: t(`paid.intervals.${price.interval}` as never),
                    })
                  : t("paid.priceOnce", { price: formatPrice(price.amount_cents, locale) })
                : premiumCents !== null
                  ? t("paid.inPremium", { price: formatPrice(premiumCents, locale) })
                  : t("paid.priceTbd")}
            </p>
          </div>
          <ul className="space-y-3 text-sm">
            <li className="flex gap-2">
              <BookOpen className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
              <span>
                <span className="font-medium">{t("paid.syllabus", { questions })}</span>
                <br />
                <span className="text-muted-foreground">
                  {packs.map((p) => localized(locale, p.title, p.title_ca)).join(" · ")}
                </span>
              </span>
            </li>
            {mocks.map((m) => (
              <li key={m.slug} className="flex gap-2">
                {m.config.kind === "psycho" ? (
                  <Brain className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                ) : (
                  <Timer className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                )}
                <span>
                  <span className="font-medium">{localized(locale, m.title, m.title_ca)}</span>
                  <br />
                  <span className="text-muted-foreground">
                    {t(m.config.penalty ? "paid.mockFormat" : "paid.mockFormatNoPenalty", {
                      questions: m.config.questions ?? 30,
                      minutes: m.config.minutes ?? 35,
                      penalty: m.config.penalty ?? 0,
                      min: m.config.pass_mark ?? 5,
                    })}
                  </span>
                </span>
              </li>
            ))}
            <li className="flex gap-2">
              <RotateCcw className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
              {t("paid.review")}
            </li>
            <li className="flex gap-2">
              <CalendarCheck className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
              {t("paid.plan")}
            </li>
          </ul>
          {buy ? (
            <BuyForm slug={buy.slug} back={back} label={buy.label} testMode={billing.testMode} />
          ) : (
            <>
              <Button variant="accent" className="w-full" disabled>
                {t("paid.cta")}
              </Button>
              <p className="text-muted-foreground text-center text-xs">{t("paid.note")}</p>
            </>
          )}
        </Card>
      </div>

      <details className="border-border rounded-xl border p-4">
        <summary className="cursor-pointer font-semibold">
          {t("topicsTitle", { count: offer.topic_list.length })}
        </summary>
        <ul className="mt-3 grid gap-1 text-sm sm:grid-cols-2" data-testid="offer-topics">
          {offer.topic_list.map((tp) => (
            <li key={tp.slug} className="flex justify-between gap-2">
              <span>{tp.title}</span>
              <Badge>{t("topicQuestions", { count: tp.questions })}</Badge>
            </li>
          ))}
        </ul>
        <p className="text-muted-foreground mt-3 text-xs">{t("sourceNote")}</p>
      </details>
    </section>
  );
}

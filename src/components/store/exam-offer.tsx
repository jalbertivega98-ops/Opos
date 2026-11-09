import { getTranslations } from "next-intl/server";
import { BookOpen, Brain, CalendarCheck, Check, RotateCcw, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card } from "@/components/ui/card";
import { localized } from "@/lib/catalog/queries";
import { formatPrice } from "@/lib/store/schema";
import { isAttemptsPack, type ExamOffer, type OfferProduct } from "@/lib/store/queries";
import { BuyForm } from "@/components/billing/buy-form";
import { examHasPsycho } from "@/lib/catalog/exam-format";
import { signUpPath } from "@/lib/paths";

/**
 * «Qué incluye»: contenido real publicado, qué es gratis y qué es de pago (ADR-035).
 * Gratis: 3 temas en test, fichas, plan y estadísticas. De pago: el Premium de esta
 * oposición (una suscripción) y packs sueltos de intentos de simulacro.
 * Sin pagos activos (Stripe) el botón sale desactivado.
 */
export async function ExamOfferSection({
  offer,
  locale,
  back,
  billing,
  examSlug,
}: {
  examSlug: string;
  offer: ExamOffer;
  locale: string;
  back: string;
  billing: { enabled: boolean; testMode: boolean };
}) {
  const t = await getTranslations("offer");
  if (offer.products.length === 0) return null;
  const bySlug = new Map(offer.products.map((p) => [p.slug, p]));
  const bundle = offer.products.find((p) => p.type === "bundle" && !isAttemptsPack(p));
  const extras = offer.products.filter((p) => isAttemptsPack(p) && p.price);
  const included = bundle
    ? bundle.includes.map((s) => bySlug.get(s)).filter((p): p is OfferProduct => !!p)
    : offer.products.filter((p) => !p.is_free && !isAttemptsPack(p));
  const mocks = included.filter((p) => p.type === "mock_exam");
  const packs = included.filter((p) => p.type === "question_pack");
  const questions = bundle?.questions || packs.reduce((n, p) => n + p.questions, 0);
  const premium = offer.premium;
  const price = premium?.price ?? null;
  const freeQuestions = offer.free_topics.reduce((n, tp) => n + tp.questions, 0);
  const freeItems = [
    ...(offer.free_topics.length > 0 ? (["topics"] as const) : []),
    "notes" as const,
    "plan" as const,
    ...(examHasPsycho(examSlug) ? (["psycho"] as const) : []),
    "progress" as const,
  ];

  return (
    <section
      id="oferta"
      className="mt-10 scroll-mt-24 space-y-4"
      aria-labelledby="offer-title"
      data-testid="exam-offer"
    >
      <h2 id="offer-title" className="text-2xl font-bold">
        {t("title")}
      </h2>
      <p className="text-muted-foreground">
        {t("summary", { questions, topics: offer.topics, mocks: mocks.length })}
      </p>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="space-y-3" data-testid="offer-free">
          <div>
            <h3 className="text-lg font-semibold">{t("free.title")}</h3>
            <p className="text-muted-foreground text-sm">{t("free.price")}</p>
          </div>
          <ul className="space-y-2 text-sm">
            {freeItems.map((k) => (
              <li key={k} className="flex gap-2">
                <Check className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                {k === "topics"
                  ? t("free.items.topics", {
                      topics: offer.free_topics.map((tp) => tp.title).join(" · "),
                      questions: freeQuestions,
                    })
                  : t(`free.items.${k}`)}
              </li>
            ))}
          </ul>
          <Button asChild className="w-full">
            <Link href={signUpPath(examSlug)}>{t("free.cta")}</Link>
          </Button>
        </Card>

        <Card className="border-accent ring-accent space-y-3 ring-1" data-testid="offer-paid">
          <div>
            <h3 className="text-lg font-semibold">
              {premium ? localized(locale, premium.title, premium.title_ca) : t("paid.title")}
            </h3>
            <p className="text-sm" data-testid="offer-price">
              {price
                ? t("paid.priceRecurring", {
                    price: formatPrice(price.amount_cents, locale),
                    interval: t(`paid.intervals.${price.interval ?? "month"}` as never),
                  })
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
                    {t(
                      m.config.kind === "sections"
                        ? "paid.mockFormatSections"
                        : m.config.penalty
                          ? "paid.mockFormat"
                          : "paid.mockFormatNoPenalty",
                      {
                        questions: m.config.questions ?? 30,
                        minutes: m.config.minutes ?? 35,
                        penalty: m.config.penalty ?? 0,
                        min: m.config.pass_mark ?? 5,
                      },
                    )}
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
          {billing.enabled && premium && price ? (
            <>
              <BuyForm
                slug={premium.slug}
                back={back}
                label={t("paid.buyPremium", { price: formatPrice(price.amount_cents, locale) })}
                testMode={billing.testMode}
              />
              <p className="text-muted-foreground text-center text-xs">{t("paid.cancel")}</p>
            </>
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

      {extras.length > 0 && (
        <div className="space-y-3" data-testid="offer-extras">
          <div>
            <h3 className="text-lg font-semibold">{t("extras.title")}</h3>
            <p className="text-muted-foreground text-sm">{t("extras.subtitle")}</p>
          </div>
          <ul className="grid gap-4 md:grid-cols-2">
            {extras.map((x) => (
              <li key={x.slug}>
                <Card className="flex h-full flex-col gap-3" data-testid="offer-extra">
                  <div className="flex-1 space-y-1">
                    <p className="font-semibold">{localized(locale, x.title, x.title_ca)}</p>
                    <p className="text-sm">
                      {t("extras.attempts", { count: x.config.attempts ?? 0 })} ·{" "}
                      {formatPrice(x.price!.amount_cents, locale)}
                    </p>
                    <p className="text-muted-foreground text-xs">
                      {t("extras.mocks", {
                        list: x.includes
                          .map((s) => bySlug.get(s))
                          .filter((p): p is OfferProduct => !!p)
                          .map((p) => localized(locale, p.title, p.title_ca))
                          .join(" · "),
                      })}
                    </p>
                  </div>
                  {billing.enabled && (
                    <BuyForm
                      slug={x.slug}
                      back={back}
                      size="sm"
                      label={t("extras.buy", { price: formatPrice(x.price!.amount_cents, locale) })}
                      testMode={billing.testMode}
                    />
                  )}
                </Card>
              </li>
            ))}
          </ul>
        </div>
      )}

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

import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Lock, Package } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { requireUser } from "@/lib/auth/session";
import { localized } from "@/lib/catalog/queries";
import { examOffer, myLibrary, mySubscription, premiumInfo } from "@/lib/store/queries";
import { billingStatus, confirmCheckout, hasBillingAccount } from "@/lib/billing/queries";
import { openBillingPortalAction } from "@/lib/billing/actions";
import { BuyForm } from "@/components/billing/buy-form";
import { SubmitButton } from "@/components/billing/submit-button";
import { CheckoutNoticeAlert, parseCheckoutNotice } from "@/components/billing/checkout-notice";
import { getPrimaryExamSlug } from "@/lib/learning/plan-queries";
import { formatPrice } from "@/lib/store/schema";
import { Alert } from "@/components/ui/form";
import { startProductPracticeAction } from "@/lib/learning/questions/actions";
import { PACK_SIZES } from "@/lib/learning/questions/schema";
import { startMockAction } from "@/lib/learning/mock/actions";
import { mockFormats, myMockAttempts } from "@/lib/learning/mock/queries";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/productos">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "store.library" });
  return { title: t("title"), robots: { index: false } };
}

export default async function LibraryPage({
  params,
  searchParams,
}: PageProps<"/[locale]/app/productos">) {
  const { locale } = await params;
  const sp = await searchParams;
  const errorKey =
    typeof sp.error === "string" && ["invalid", "access", "start", "pool"].includes(sp.error)
      ? sp.error
      : null;
  setRequestLocale(locale);
  const { user } = await requireUser(locale, "/app/productos");
  const t = await getTranslations("store");
  const tb = await getTranslations("billing");
  const format = await getFormatter();
  // Vuelta de Stripe: se confirma la compra aquí mismo (sin esperar al webhook)
  let notice = parseCheckoutNotice(sp.compra);
  if (notice === "ok") {
    const sessionId = typeof sp.session_id === "string" ? sp.session_id : "";
    const confirmed = await confirmCheckout(sessionId, user.id);
    notice = confirmed === "ok" ? "ok" : confirmed === "pending" ? "pendiente" : null;
  }
  const billing = billingStatus();
  const [items, premium, attempts, examSlug, subscription, isCustomer] = await Promise.all([
    myLibrary(),
    premiumInfo(),
    myMockAttempts(5),
    getPrimaryExamSlug(),
    mySubscription(user.id),
    hasBillingAccount(user.id),
  ]);
  const price = premium.cents;
  // Lo de pago de su oposición que aún no tiene: se ve, con candado, y lleva a «Qué incluye».
  const offer = examSlug ? await examOffer(examSlug) : null;
  const owned = new Set(items.map((it) => it.slug));
  const locked = (offer?.products ?? []).filter((p) => !p.is_free && !owned.has(p.slug));
  const formats = await mockFormats(
    items.filter((it) => it.type === "mock_exam").map((it) => it.product_id),
  );
  const activeMock = new Set(attempts.filter((a) => a.inProgress).map((a) => a.product_id));
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">{t("library.title")}</h1>
        <p className="text-muted-foreground mt-1">{t("library.subtitle")}</p>
      </div>
      {errorKey && <Alert tone="error">{t(`library.errors.${errorKey}` as never)}</Alert>}
      <CheckoutNoticeAlert notice={notice} />
      {items.length === 0 ? (
        <EmptyState
          title={t("library.empty")}
          description={t("library.emptyBody")}
          action={
            <Button asChild variant="accent">
              <Link href="/app/practica">{t("library.practice")}</Link>
            </Button>
          }
        />
      ) : (
        <ul className="grid gap-4 md:grid-cols-2" data-testid="library">
          {items.map((it) => (
            <li key={it.product_id}>
              <Card className="flex items-start gap-4" data-testid="library-item">
                <span className="bg-accent-soft text-accent inline-flex size-10 shrink-0 items-center justify-center rounded-lg">
                  <Package className="size-5" aria-hidden />
                </span>
                <div className="min-w-0 flex-1 space-y-1">
                  <p className="font-semibold">{localized(locale, it.title, it.title_ca)}</p>
                  <p className="text-muted-foreground text-sm">{t(`types.${it.type}` as never)}</p>
                  <div className="flex flex-wrap gap-2 text-xs">
                    {it.is_test && <Badge tone="warning">{t("library.test")}</Badge>}
                    <Badge tone="accent">{t(`library.sources.${it.source}` as never)}</Badge>
                    {it.question_count > 0 && (
                      <Badge>{t("library.questionsCount", { count: it.question_count })}</Badge>
                    )}
                    {it.ends_at && (
                      <Badge>
                        {t("library.until", {
                          date: format.dateTime(new Date(it.ends_at), { dateStyle: "medium" }),
                        })}
                      </Badge>
                    )}
                  </div>
                  {it.type === "mock_exam" ? (
                    <form action={startMockAction} className="space-y-2 pt-2">
                      <input type="hidden" name="productId" value={it.product_id} />
                      <p className="text-muted-foreground text-xs" data-testid="mock-format">
                        {t(
                          formats.get(it.product_id)?.penalty === 0
                            ? "library.mockFormatNoPenalty"
                            : "library.mockFormat",
                          {
                            questions: formats.get(it.product_id)?.questions ?? 30,
                            minutes: formats.get(it.product_id)?.minutes ?? 35,
                            penalty: formats.get(it.product_id)?.penalty ?? 0.25,
                            min: formats.get(it.product_id)?.pass_mark ?? 4,
                          },
                        )}
                      </p>
                      <Button type="submit" variant="accent" size="sm" data-testid="mock-start">
                        {activeMock.has(it.product_id)
                          ? t("library.resumeMock")
                          : t("library.startMock")}
                      </Button>
                    </form>
                  ) : (
                    it.question_count > 0 && (
                      <form
                        action={startProductPracticeAction}
                        className="flex flex-wrap items-end gap-2 pt-2"
                      >
                        <input type="hidden" name="productId" value={it.product_id} />
                        <label className="space-y-1 text-xs font-medium">
                          {t("library.count")}
                          <select
                            name="count"
                            defaultValue={String(Math.min(10, it.question_count))}
                            className="border-input bg-background block h-10 rounded-lg border px-2 text-sm"
                          >
                            {PACK_SIZES.filter((n) => n <= Math.max(5, it.question_count)).map(
                              (n) => (
                                <option key={n} value={n}>
                                  {n}
                                </option>
                              ),
                            )}
                          </select>
                        </label>
                        <Button type="submit" variant="accent" size="sm">
                          {t("library.start")}
                        </Button>
                      </form>
                    )
                  )}
                </div>
              </Card>
            </li>
          ))}
        </ul>
      )}
      {examSlug && locked.length > 0 && (
        <section aria-labelledby="locked-title" className="space-y-3" data-testid="locked-products">
          <div>
            <h2 id="locked-title" className="text-lg font-semibold">
              {t("library.lockedTitle")}
            </h2>
            <p className="text-muted-foreground text-sm">{t("library.lockedSubtitle")}</p>
          </div>
          <ul className="grid gap-4 md:grid-cols-2">
            {locked.map((p) => (
              <li key={p.slug}>
                <Card
                  className="bg-surface flex h-full items-start gap-4"
                  data-testid="locked-item"
                >
                  <span className="bg-highlight-soft text-warning inline-flex size-10 shrink-0 items-center justify-center rounded-lg">
                    <Lock className="size-5" aria-hidden />
                  </span>
                  <div className="min-w-0 flex-1 space-y-1">
                    <p className="font-semibold">{localized(locale, p.title, p.title_ca)}</p>
                    <p className="text-muted-foreground text-sm">{t(`types.${p.type}` as never)}</p>
                    <div className="flex flex-wrap gap-2 text-xs">
                      <Badge className="bg-highlight-soft text-highlight-foreground dark:text-highlight">
                        <Lock className="size-3" aria-hidden />
                        {p.included_in_premium ? t("library.lockedBadge") : t("library.paidBadge")}
                      </Badge>
                      {p.questions > 0 && (
                        <Badge>{t("library.questionsCount", { count: p.questions })}</Badge>
                      )}
                    </div>
                    {billing.enabled && p.price && !p.price.interval ? (
                      <BuyForm
                        slug={p.slug}
                        back="/app/productos"
                        size="sm"
                        className="mt-2"
                        testMode={billing.testMode}
                        label={tb("buy", { price: formatPrice(p.price.amount_cents, locale) })}
                      />
                    ) : (
                      <Button asChild variant="outline" size="sm" className="mt-2">
                        <Link href={`/oposiciones/${examSlug}`}>{t("library.lockedCta")}</Link>
                      </Button>
                    )}
                  </div>
                </Card>
              </li>
            ))}
          </ul>
        </section>
      )}
      {attempts.length > 0 && (
        <section aria-labelledby="mock-history" className="space-y-3">
          <h2 id="mock-history" className="text-lg font-semibold">
            {t("library.mockHistory")}
          </h2>
          <ul className="divide-border divide-y rounded-xl border" data-testid="mock-history">
            {attempts.map((a) => (
              <li key={a.id}>
                <Link
                  href={`/app/simulacros/${a.id}`}
                  className="hover:bg-surface flex flex-wrap items-center justify-between gap-2 px-4 py-3 text-sm"
                >
                  <span className="font-medium">{localized(locale, a.title, a.title_ca)}</span>
                  <span className="text-muted-foreground">
                    {format.dateTime(new Date(a.started_at), {
                      dateStyle: "medium",
                      timeStyle: "short",
                    })}
                  </span>
                  {a.status === "active" ? (
                    <Badge tone="accent">{t("library.mockInProgress")}</Badge>
                  ) : (
                    <Badge tone={a.passed ? "success" : "warning"}>
                      {format.number(a.mark ?? 0)} / {a.config.max_mark}
                    </Badge>
                  )}
                </Link>
              </li>
            ))}
          </ul>
        </section>
      )}
      {subscription ? (
        <Card
          className="border-accent flex flex-wrap items-center justify-between gap-4"
          data-testid="premium-active"
        >
          <div>
            <h2 className="font-semibold">{t("library.premiumTitle")}</h2>
            <p className="text-muted-foreground text-sm">
              {subscription.status === "past_due"
                ? tb("pastDue")
                : subscription.current_period_end
                  ? tb(subscription.cancel_at_period_end ? "endsOn" : "renewsOn", {
                      date: format.dateTime(new Date(subscription.current_period_end), {
                        dateStyle: "long",
                      }),
                    })
                  : tb("active")}
            </p>
          </div>
          {isCustomer && (
            <form action={openBillingPortalAction}>
              <SubmitButton variant="outline" pendingLabel={tb("redirecting")}>
                {tb("manage")}
              </SubmitButton>
            </form>
          )}
        </Card>
      ) : (
        price !== null && (
          <Card className="border-accent flex flex-wrap items-center justify-between gap-4">
            <div className="min-w-0 flex-1 basis-64">
              <h2 className="font-semibold">{t("library.premiumTitle")}</h2>
              <p className="text-muted-foreground text-sm">
                {billing.enabled && premium.published
                  ? tb("premiumBody", { price: formatPrice(price, locale) })
                  : t("library.premiumBody", { price: formatPrice(price, locale) })}
              </p>
            </div>
            {billing.enabled && premium.published ? (
              <BuyForm
                slug="premium"
                back="/app/productos"
                className="w-full sm:w-72"
                testMode={billing.testMode}
                label={tb("buyPremium")}
              />
            ) : (
              <Button variant="accent" disabled>
                {t("library.soon")}
              </Button>
            )}
          </Card>
        )
      )}
    </div>
  );
}

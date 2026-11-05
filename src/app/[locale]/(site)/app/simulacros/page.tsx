import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Lock, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { requireUser } from "@/lib/auth/session";
import { localized } from "@/lib/catalog/queries";
import { examOffer, isAttemptsPack, myLibrary, mySubscriptions } from "@/lib/store/queries";
import { billingStatus } from "@/lib/billing/queries";
import { checkoutReturnNotice } from "@/lib/billing/checkout-return";
import { BuyForm } from "@/components/billing/buy-form";
import { CheckoutNoticeAlert } from "@/components/billing/checkout-notice";
import { getPrimaryExamSlug } from "@/lib/learning/plan-queries";
import { formatPrice } from "@/lib/store/schema";
import { startMockAction } from "@/lib/learning/mock/actions";
import { mockFormats, myMockAttempts } from "@/lib/learning/mock/queries";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/simulacros">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "mockList" });
  return { title: t("title"), robots: { index: false } };
}

/**
 * Simulacros del alumno (ADR-036): los que puede hacer (Premium, pack completo o
 * packs de intentos), su historial con nota y, si no tiene, los packs de intentos
 * de su oposición a la venta. Sustituye a la antigua pestaña «Mis productos».
 */
export default async function MocksPage({
  params,
  searchParams,
}: PageProps<"/[locale]/app/simulacros">) {
  const { locale } = await params;
  const sp = await searchParams;
  setRequestLocale(locale);
  const { user } = await requireUser(locale, "/app/simulacros");
  const t = await getTranslations("store");
  const tm = await getTranslations("mockList");
  const tb = await getTranslations("billing");
  const format = await getFormatter();
  const errorKey =
    typeof sp.error === "string" && ["invalid", "access", "start", "pool"].includes(sp.error)
      ? sp.error
      : null;
  const notice = await checkoutReturnNotice(sp, user.id);
  const billing = billingStatus();
  const [items, attempts, examSlug, subscriptions] = await Promise.all([
    myLibrary(),
    myMockAttempts(10),
    getPrimaryExamSlug(),
    mySubscriptions(user.id),
  ]);
  const offer = examSlug ? await examOffer(examSlug) : null;
  const hasExamPremium = subscriptions.some(
    (s) =>
      s.status !== "past_due" &&
      (s.product.exam_body_id === null || s.product.slug === offer?.premium?.slug),
  );
  const mocks = items.filter((it) => it.type === "mock_exam");
  const packs = items.filter((it) => it.attempts_left !== null);
  // Packs de intentos a la venta (se pueden volver a comprar); con Premium no hacen falta
  const forSale = (offer?.products ?? []).filter(
    (p) => isAttemptsPack(p) && !hasExamPremium && p.price !== null,
  );
  const formats = await mockFormats(mocks.map((it) => it.product_id));
  const activeMock = new Set(attempts.filter((a) => a.inProgress).map((a) => a.product_id));

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">{tm("title")}</h1>
        <p className="text-muted-foreground mt-1">{tm("subtitle")}</p>
      </div>
      {errorKey && <Alert tone="error">{t(`library.errors.${errorKey}` as never)}</Alert>}
      <CheckoutNoticeAlert notice={notice} />
      {packs.length > 0 && (
        <ul className="flex flex-wrap gap-2 text-sm" data-testid="attempt-packs">
          {packs.map((p) => (
            <li key={p.product_id}>
              <Badge tone={(p.attempts_left ?? 0) > 0 ? "success" : "warning"}>
                {localized(locale, p.title, p.title_ca)} ·{" "}
                {t("library.attemptsLeft", { count: p.attempts_left ?? 0 })}
              </Badge>
            </li>
          ))}
        </ul>
      )}
      {mocks.length === 0 ? (
        <EmptyState
          title={tm("empty")}
          description={tm("emptyBody")}
          action={
            examSlug ? (
              <Button asChild variant="accent">
                <Link href={`/oposiciones/${examSlug}`}>{t("library.lockedCta")}</Link>
              </Button>
            ) : undefined
          }
        />
      ) : (
        <ul className="grid gap-4 md:grid-cols-2" data-testid="library">
          {mocks.map((it) => {
            const f = formats.get(it.product_id);
            return (
              <li key={it.product_id}>
                <Card className="flex items-start gap-4" data-testid="library-item">
                  <span className="bg-accent-soft text-accent inline-flex size-10 shrink-0 items-center justify-center rounded-lg">
                    <Timer className="size-5" aria-hidden />
                  </span>
                  <form action={startMockAction} className="min-w-0 flex-1 space-y-2">
                    <input type="hidden" name="productId" value={it.product_id} />
                    <p className="font-semibold">{localized(locale, it.title, it.title_ca)}</p>
                    {it.is_test && <Badge tone="warning">{t("library.test")}</Badge>}
                    <p className="text-muted-foreground text-xs" data-testid="mock-format">
                      {t(
                        f?.kind === "sections"
                          ? "library.mockFormatSections"
                          : f?.penalty === 0
                            ? "library.mockFormatNoPenalty"
                            : "library.mockFormat",
                        {
                          questions: f?.questions ?? 30,
                          minutes: f?.minutes ?? 35,
                          penalty: f?.penalty ?? 0.25,
                          min: f?.pass_mark ?? 4,
                        },
                      )}
                    </p>
                    <Button type="submit" variant="accent" size="sm" data-testid="mock-start">
                      {activeMock.has(it.product_id)
                        ? t("library.resumeMock")
                        : t("library.startMock")}
                    </Button>
                  </form>
                </Card>
              </li>
            );
          })}
        </ul>
      )}
      {examSlug && forSale.length > 0 && (
        <section aria-labelledby="buy-title" className="space-y-3" data-testid="locked-products">
          <div>
            <h2 id="buy-title" className="text-lg font-semibold">
              {tm("buyTitle")}
            </h2>
            <p className="text-muted-foreground text-sm">{tm("buySubtitle")}</p>
          </div>
          <ul className="grid gap-4 md:grid-cols-2">
            {forSale.map((p) => (
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
                    {billing.enabled && p.price && !p.price.interval ? (
                      <BuyForm
                        slug={p.slug}
                        back="/app/simulacros"
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
                      timeZone: "Europe/Madrid",
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
    </div>
  );
}

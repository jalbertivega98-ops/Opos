import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Download } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Link } from "@/i18n/navigation";
import { Alert } from "@/components/ui/form";
import {
  ChangeEmailForm,
  ChangePasswordForm,
  DeleteAccountForm,
  ProfileForm,
} from "@/components/account-forms";
import { requireUser } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";
import { localized } from "@/lib/catalog/queries";
import { examOffer, myLibrary, mySubscriptions } from "@/lib/store/queries";
import { billingStatus, hasBillingAccount } from "@/lib/billing/queries";
import { checkoutReturnNotice } from "@/lib/billing/checkout-return";
import { openBillingPortalAction } from "@/lib/billing/actions";
import { BuyForm } from "@/components/billing/buy-form";
import { hasPassword } from "@/lib/auth/identity";
import { SubmitButton } from "@/components/billing/submit-button";
import { CheckoutNoticeAlert } from "@/components/billing/checkout-notice";
import { getPrimaryExamSlug } from "@/lib/learning/plan-queries";
import { formatPrice } from "@/lib/store/schema";
import { Badge } from "@/components/ui/card";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/perfil">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "profile" });
  return { title: t("title"), robots: { index: false } };
}

export default async function ProfilePage({
  params,
  searchParams,
}: PageProps<"/[locale]/app/perfil">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  const { user, profile } = await requireUser(locale, "/app/perfil");
  const t = await getTranslations("profile");
  const withPassword = hasPassword(user);
  const format = await getFormatter();
  const supabase = await createClient();
  const tb = await getTranslations("billing");
  const ts = await getTranslations("store");
  const to = await getTranslations("offer");
  const [{ data: consent }, notice, subscriptions, isCustomer, examSlug, library] =
    await Promise.all([
      supabase.from("profiles").select("marketing_consent").eq("id", user.id).single(),
      checkoutReturnNotice(sp, user.id),
      mySubscriptions(user.id),
      hasBillingAccount(user.id),
      getPrimaryExamSlug(),
      myLibrary(),
    ]);
  // Suscripción y compras (ADR-036: antes en «Mis productos»)
  const billing = billingStatus();
  const premium = examSlug ? ((await examOffer(examSlug))?.premium ?? null) : null;
  const price = premium?.price?.amount_cents ?? null;
  const priceYear = premium?.price_year?.amount_cents ?? null;
  const hasExamPremium = subscriptions.some(
    (s) =>
      s.status !== "past_due" &&
      (s.product.exam_body_id === null || s.product.slug === premium?.slug),
  );
  const purchases = library.filter(
    (it) => it.source !== "free" && it.source !== "subscription" && it.source !== "bundle",
  );

  return (
    <div className="mx-auto max-w-2xl space-y-6">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1 text-sm">
          {user.email} ·{" "}
          {t("memberSince", {
            date: format.dateTime(new Date(profile.created_at), { dateStyle: "long" }),
          })}
        </p>
      </div>
      {sp.saved === "1" && <Alert tone="success">{t("saved")}</Alert>}
      <CheckoutNoticeAlert notice={notice} />

      <Card id="suscripcion" className="scroll-mt-28 space-y-4" data-testid="billing-section">
        <div>
          <h2 className="text-lg font-semibold">{t("billingTitle")}</h2>
          <p className="text-muted-foreground mt-1 text-sm">{t("billingBody")}</p>
        </div>
        {subscriptions.map((subscription) => (
          <div
            key={subscription.product.slug}
            className="border-accent flex flex-wrap items-center justify-between gap-4 rounded-xl border p-4"
            data-testid="premium-active"
          >
            <div>
              <p className="font-semibold">
                {subscription.product.exam_body_id
                  ? localized(locale, subscription.product.title, subscription.product.title_ca)
                  : ts("library.premiumTitle")}
              </p>
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
          </div>
        ))}
        {!hasExamPremium && premium && price !== null && (
          <div className="bg-surface flex flex-wrap items-center justify-between gap-4 rounded-xl p-4">
            <div className="min-w-0 flex-1 basis-64">
              <p className="font-semibold">{localized(locale, premium.title, premium.title_ca)}</p>
              <p className="text-muted-foreground text-sm">
                {billing.enabled
                  ? priceYear !== null
                    ? tb("premiumBodyYear", {
                        price: formatPrice(price, locale),
                        yearPrice: formatPrice(priceYear, locale),
                      })
                    : tb("premiumBody", { price: formatPrice(price, locale) })
                  : ts("library.premiumBody", { price: formatPrice(price, locale) })}
              </p>
            </div>
            {billing.enabled ? (
              <BuyForm
                slug={premium.slug}
                back="/app/perfil"
                className="w-full sm:w-72"
                testMode={billing.testMode}
                label={tb("buyPremium")}
                intervals={
                  priceYear !== null
                    ? [
                        {
                          value: "month",
                          label: to("paid.monthly", { price: formatPrice(price, locale) }),
                        },
                        {
                          value: "year",
                          label: to("paid.yearly", {
                            price: formatPrice(priceYear, locale),
                            pct: Math.round((1 - priceYear / (price * 12)) * 100),
                          }),
                        },
                      ]
                    : undefined
                }
              />
            ) : (
              <Button variant="accent" disabled>
                {ts("library.soon")}
              </Button>
            )}
          </div>
        )}
        {purchases.length > 0 && (
          <ul className="grid gap-2 text-sm" data-testid="purchases">
            {purchases.map((it) => (
              <li
                key={it.product_id}
                className="border-border flex flex-wrap items-center justify-between gap-2 rounded-lg border px-3 py-2"
              >
                <span className="font-medium">{localized(locale, it.title, it.title_ca)}</span>
                <span className="flex flex-wrap gap-1.5">
                  {it.is_test && <Badge tone="warning">{ts("library.test")}</Badge>}
                  <Badge tone="accent">{ts(`library.sources.${it.source}` as never)}</Badge>
                  {it.attempts_left !== null && (
                    <Badge tone={it.attempts_left > 0 ? "success" : "warning"}>
                      {ts("library.attemptsLeft", { count: it.attempts_left })}
                    </Badge>
                  )}
                  {it.ends_at && (
                    <Badge>
                      {ts("library.until", {
                        date: format.dateTime(new Date(it.ends_at), { dateStyle: "medium" }),
                      })}
                    </Badge>
                  )}
                </span>
              </li>
            ))}
          </ul>
        )}
        {subscriptions.length === 0 && purchases.length === 0 && !premium && (
          <p className="text-muted-foreground text-sm">{t("billingNone")}</p>
        )}
      </Card>

      <Card>
        <h2 className="mb-4 text-lg font-semibold">{t("personal")}</h2>
        <ProfileForm
          displayName={profile.display_name ?? ""}
          locale={profile.locale}
          marketingConsent={consent?.marketing_consent ?? false}
        />
      </Card>

      {withPassword ? (
        <>
          <Card>
            <h2 className="text-lg font-semibold">{t("securityTitle")}</h2>
            <p className="text-muted-foreground mt-1 mb-4 text-sm">{t("securityBody")}</p>
            <ChangePasswordForm />
          </Card>

          <Card>
            <h2 className="text-lg font-semibold">{t("emailTitle")}</h2>
            <p className="text-muted-foreground mt-1 mb-4 text-sm">
              {t("emailBody", { email: user.email ?? "" })}
            </p>
            <ChangeEmailForm />
          </Card>
        </>
      ) : (
        <Card>
          <h2 className="text-lg font-semibold">{t("googleTitle")}</h2>
          <p className="text-muted-foreground mt-1 text-sm">
            {t("googleBody", { email: user.email ?? "" })}
          </p>
        </Card>
      )}

      <Card>
        <h2 className="text-lg font-semibold">{t("tourTitle")}</h2>
        <p className="text-muted-foreground mt-1 text-sm">{t("tourBody")}</p>
        <div className="mt-4 flex flex-wrap gap-2">
          <Button asChild variant="outline">
            <Link href="/app?tutorial=1" data-testid="replay-tour">
              {t("tourCta")}
            </Link>
          </Button>
          <Button asChild variant="ghost">
            <Link href="/#como-funciona">{t("tourVideos")}</Link>
          </Button>
        </div>
      </Card>

      <Card>
        <h2 className="text-lg font-semibold">{t("exportTitle")}</h2>
        <p className="text-muted-foreground mt-1 text-sm">{t("exportBody")}</p>
        <Button asChild variant="outline" className="mt-4">
          <a href="/api/account/export" download>
            <Download aria-hidden /> {t("exportCta")}
          </a>
        </Button>
      </Card>

      <Card className="border-danger/40">
        <h2 className="text-danger text-lg font-semibold">{t("deleteTitle")}</h2>
        <p className="text-muted-foreground mt-1 mb-4 text-sm">{t("deleteBody")}</p>
        {profile.role === "owner" ? (
          <Alert>{t("ownerCannotDelete")}</Alert>
        ) : (
          <DeleteAccountForm needsPassword={withPassword} />
        )}
      </Card>
    </div>
  );
}

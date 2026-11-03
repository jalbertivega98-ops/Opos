import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Package } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { requireUser } from "@/lib/auth/session";
import { localized } from "@/lib/catalog/queries";
import { myLibrary, premiumPrice } from "@/lib/store/queries";
import { formatPrice } from "@/lib/store/schema";
import { Alert } from "@/components/ui/form";
import { startProductPracticeAction } from "@/lib/learning/questions/actions";
import { PACK_SIZES } from "@/lib/learning/questions/schema";

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
    typeof sp.error === "string" && ["invalid", "access", "start"].includes(sp.error)
      ? sp.error
      : null;
  setRequestLocale(locale);
  await requireUser(locale, "/app/productos");
  const t = await getTranslations("store");
  const format = await getFormatter();
  const [items, price] = await Promise.all([myLibrary(), premiumPrice()]);
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">{t("library.title")}</h1>
        <p className="text-muted-foreground mt-1">{t("library.subtitle")}</p>
      </div>
      {errorKey && <Alert tone="error">{t(`library.errors.${errorKey}` as never)}</Alert>}
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
                  {it.question_count > 0 && (
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
                  )}
                </div>
              </Card>
            </li>
          ))}
        </ul>
      )}
      {price !== null && (
        <Card className="border-accent flex flex-wrap items-center justify-between gap-4">
          <div>
            <h2 className="font-semibold">{t("library.premiumTitle")}</h2>
            <p className="text-muted-foreground text-sm">
              {t("library.premiumBody", { price: formatPrice(price, locale) })}
            </p>
          </div>
          <Button variant="accent" disabled>
            {t("library.soon")}
          </Button>
        </Card>
      )}
    </div>
  );
}

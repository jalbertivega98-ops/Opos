import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { listProducts } from "@/lib/store/queries";
import { formatPrice } from "@/lib/store/schema";

export const metadata: Metadata = { title: "Admin · Productos", robots: { index: false } };

export default async function ProductsPage({ params }: PageProps<"/[locale]/admin/productos">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("store");
  const products = await listProducts();
  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold">{t("admin.title")}</h1>
          <p className="text-muted-foreground mt-1 max-w-2xl text-sm">{t("admin.subtitle")}</p>
        </div>
        <Button asChild variant="accent">
          <Link href="/admin/productos/nuevo">{t("admin.new")}</Link>
        </Button>
      </div>
      {products.length === 0 ? (
        <EmptyState title={t("admin.empty")} />
      ) : (
        <div className="grid gap-4 md:grid-cols-2" data-testid="products-list">
          {products.map((p) => {
            const prices = p.prices.filter((x) => x.active);
            return (
              <Card key={p.id} className="space-y-2">
                <div className="flex flex-wrap items-center gap-2">
                  <Link href={`/admin/productos/${p.id}`} className="font-semibold hover:underline">
                    {p.title}
                  </Link>
                  <Badge tone={p.status === "published" ? "success" : "neutral"}>
                    {t(`statuses.${p.status}` as never)}
                  </Badge>
                </div>
                <p className="text-muted-foreground text-sm">
                  {t(`types.${p.type}` as never)} · /{p.slug}
                </p>
                <p className="text-sm">
                  {prices.length
                    ? prices
                        .map(
                          (x) =>
                            `${formatPrice(x.amount_cents, locale)} ${t(`intervals.${x.billing_interval ?? "once"}` as never).toLowerCase()}`,
                        )
                        .join(" · ")
                    : p.is_free
                      ? t("admin.free")
                      : t("admin.noPrice")}
                  {p.included_in_premium && (
                    <Badge tone="accent" className="ml-2">
                      {t("admin.premium")}
                    </Badge>
                  )}
                </p>
              </Card>
            );
          })}
        </div>
      )}
    </div>
  );
}

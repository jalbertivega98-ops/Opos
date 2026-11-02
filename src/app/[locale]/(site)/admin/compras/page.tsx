import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Button } from "@/components/ui/button";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { GrantForm } from "@/components/admin/store-forms";
import { revokeAccessAction } from "@/lib/store/actions";
import { listProducts, listPurchases } from "@/lib/store/queries";
import { formatPrice } from "@/lib/store/schema";

export const metadata: Metadata = { title: "Admin · Compras", robots: { index: false } };

export default async function PurchasesPage({ params }: PageProps<"/[locale]/admin/compras">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("store.purchases");
  const format = await getFormatter();
  const [rows, products] = await Promise.all([listPurchases(), listProducts()]);
  const grantable = products.filter((p) => p.status !== "archived" && p.type !== "subscription");
  return (
    <div className="mx-auto max-w-6xl space-y-6 px-4 py-8">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1 max-w-2xl text-sm">{t("subtitle")}</p>
      </div>
      <Card className="space-y-3">
        <h2 className="text-lg font-semibold">{t("grantTitle")}</h2>
        <p className="text-muted-foreground text-sm">{t("grantHelp")}</p>
        <GrantForm products={grantable.map((p) => ({ id: p.id, title: p.title }))} />
      </Card>
      {rows.length === 0 ? (
        <EmptyState title={t("empty")} />
      ) : (
        <Card className="overflow-x-auto p-0">
          <table className="w-full min-w-[760px] text-left text-sm" data-testid="purchases-table">
            <thead className="text-muted-foreground border-border border-b">
              <tr>
                {[
                  "colKind",
                  "colUser",
                  "colProduct",
                  "colStatus",
                  "colSource",
                  "colDate",
                  "colEnds",
                ].map((c) => (
                  <th key={c} className="px-4 py-3 font-medium">
                    {t(c as never)}
                  </th>
                ))}
                <th className="px-4 py-3" />
              </tr>
            </thead>
            <tbody className="divide-border divide-y">
              {rows.map((r) => (
                <tr key={`${r.kind}-${r.id}`}>
                  <td className="px-4 py-3">{t(`kind.${r.kind}` as never)}</td>
                  <td className="px-4 py-3">{r.email ?? "—"}</td>
                  <td className="px-4 py-3">
                    {r.product_title ?? "—"}
                    {r.amount_cents !== null && (
                      <span className="text-muted-foreground">
                        {" "}
                        · {formatPrice(r.amount_cents, locale)}
                      </span>
                    )}
                  </td>
                  <td className="px-4 py-3">
                    <Badge
                      tone={r.status === "active" || r.status === "paid" ? "success" : "neutral"}
                    >
                      {t.has(`state.${r.status}` as never)
                        ? t(`state.${r.status}` as never)
                        : r.status}
                    </Badge>
                  </td>
                  <td className="px-4 py-3">
                    {t.has(`sources.${r.source}` as never)
                      ? t(`sources.${r.source}` as never)
                      : r.source}
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    {format.dateTime(new Date(r.created_at), { dateStyle: "short" })}
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    {r.ends_at ? format.dateTime(new Date(r.ends_at), { dateStyle: "short" }) : "—"}
                  </td>
                  <td className="px-4 py-3">
                    {r.kind === "grant" && r.status === "active" && (
                      <form action={revokeAccessAction}>
                        <input type="hidden" name="id" value={r.id} />
                        <Button type="submit" variant="ghost" size="sm" className="text-danger">
                          {t("revoke")}
                        </Button>
                      </form>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Card>
      )}
    </div>
  );
}

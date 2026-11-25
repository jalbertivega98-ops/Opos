import { getFormatter, getLocale, getTranslations } from "next-intl/server";
import { Card } from "@/components/ui/card";
import type { Overview } from "@/lib/admin/metrics";
import { pointsTrend, rate, trend, type Trend } from "@/lib/admin/overview";
import { formatPrice } from "@/lib/store/schema";
import { cn } from "@/lib/utils";

type Item = {
  key: string;
  value: string;
  /** Línea de contexto bajo la cifra (p. ej. «3 ventas»). */
  detail?: string;
  trend?: Trend;
  /** Texto de la comparación ya formateado («▲ 12 %», «▲ 0,4 puntos»…). */
  trendText?: string;
  /** Cifra del periodo anterior, ya formateada. */
  before?: string;
};

/**
 * Resumen del panel (ADR-072): las cifras clave del periodo elegido y si suben
 * o bajan frente al periodo anterior de la misma duración. Verde = mejor,
 * rojo = peor; la flecha y el texto lo dicen también sin color.
 */
export async function SummaryCards({ overview }: { overview: Overview }) {
  const t = await getTranslations("admin.summary");
  const format = await getFormatter();
  const locale = await getLocale();
  const { current: c, previous: p } = overview;
  const n = (v: number) => format.number(v);
  const pctText = (v: number) => format.number(v, { maximumFractionDigits: 1 });

  const trendText = (tr: Trend, points = false) => {
    if (tr.direction === "flat") return t("same");
    const arrow = tr.direction === "up" ? "▲" : "▼";
    if (tr.delta === null) return `${arrow} ${t("new")}`;
    const abs = pctText(Math.abs(tr.delta));
    return `${arrow} ${points ? t("points", { n: abs }) : `${abs} %`}`;
  };
  const withTrend = (cur: number, prev: number, fmt: (v: number) => string) => {
    const tr = trend(cur, prev);
    return { trend: tr, trendText: trendText(tr), before: fmt(prev) };
  };

  const convCur = rate(c.signups, c.visits);
  const convPrev = rate(p.signups, p.visits);
  const convTrend = pointsTrend(convCur, convPrev);
  const revCur = c.pack_revenue_cents + c.new_premium_cents;
  const revPrev = p.pack_revenue_cents + p.new_premium_cents;
  const money = (cents: number) => formatPrice(cents, locale);

  const items: Item[] = [
    { key: "visits", value: n(c.visits), ...withTrend(c.visits, p.visits, n) },
    { key: "signups", value: n(c.signups), ...withTrend(c.signups, p.signups, n) },
    {
      key: "conversion",
      value: `${pctText(convCur)} %`,
      detail: t("conversionDetail", { signups: c.signups, visits: c.visits }),
      trend: convTrend,
      trendText: trendText(convTrend, true),
      before: `${pctText(convPrev)} %`,
    },
    { key: "practicing", value: n(c.practicing), ...withTrend(c.practicing, p.practicing, n) },
    {
      key: "revenue",
      value: money(revCur),
      detail: t("revenueDetail", { packs: c.pack_sales, premium: c.new_premium }),
      ...withTrend(revCur, revPrev, money),
    },
    {
      key: "premium",
      value: n(overview.premiumPaidActive),
      detail: t("premiumDetail", {
        mrr: money(overview.mrrCents),
        gifts: overview.premiumGiftActive,
      }),
      // Aquí se comparan las altas nuevas del periodo, no el total activo.
      trend: trend(c.new_premium, p.new_premium),
      trendText: t("premiumNew", { n: c.new_premium, before: p.new_premium }),
    },
  ];

  return (
    <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3" data-testid="admin-summary">
      {items.map((it) => (
        <Card key={it.key} data-testid={`summary-${it.key}`} className="flex flex-col">
          <p className="text-muted-foreground text-sm font-medium">{t(`items.${it.key}`)}</p>
          <p className="font-display mt-1 text-4xl font-extrabold tabular-nums">{it.value}</p>
          {it.detail && <p className="text-muted-foreground mt-1 text-sm">{it.detail}</p>}
          {it.trendText && (
            <p className="mt-3 text-sm" data-testid={`summary-${it.key}-trend`}>
              <span
                className={cn(
                  "rounded-full px-2 py-0.5 font-semibold tabular-nums",
                  it.trend?.direction === "up" && "bg-success/15 text-success",
                  it.trend?.direction === "down" && "bg-danger/15 text-danger",
                  (!it.trend || it.trend.direction === "flat") &&
                    "bg-surface-2 text-muted-foreground",
                )}
              >
                {it.trendText}
              </span>
              {it.before !== undefined && (
                <span className="text-muted-foreground ml-2">
                  {t("before", { value: it.before })}
                </span>
              )}
            </p>
          )}
          <p className="text-muted-foreground mt-auto pt-3 text-xs">{t(`hints.${it.key}`)}</p>
        </Card>
      ))}
    </div>
  );
}

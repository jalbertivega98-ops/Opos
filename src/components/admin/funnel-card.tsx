import { getFormatter, getTranslations } from "next-intl/server";
import { Card } from "@/components/ui/card";
import { Link } from "@/i18n/navigation";
import type { Funnel } from "@/lib/admin/metrics";
import { biggestDrop, funnelRows } from "@/lib/admin/funnel";
import { cn } from "@/lib/utils";

export const FUNNEL_PERIODS = [7, 30] as const;

/**
 * Embudo de conversión (ADR-047): cuánta gente pasa de cada paso al siguiente y
 * dónde se pierde más. Barras sin dependencias; los números van siempre en texto.
 */
export async function FunnelCard({ funnel }: { funnel: Funnel }) {
  const t = await getTranslations("admin.funnel");
  const format = await getFormatter();
  // Crear cuenta no exige pasar por el test gratis: se compara con las visitas.
  const rows = funnelRows(funnel.steps, { signups: "visits" });
  const drop = biggestDrop(rows);

  return (
    <section aria-labelledby="funnel-title" data-testid="admin-funnel">
      <div className="flex flex-wrap items-baseline justify-between gap-2">
        <h2 id="funnel-title" className="text-lg font-semibold">
          {t("title")}
        </h2>
        <nav aria-label={t("period")} className="flex gap-1 text-sm">
          {FUNNEL_PERIODS.map((d) => (
            <Link
              key={d}
              href={{ pathname: "/admin", query: { embudo: d } }}
              aria-current={funnel.days === d ? "true" : undefined}
              data-testid={`funnel-period-${d}`}
              className={cn(
                "rounded-full border px-3 py-1 font-medium",
                funnel.days === d
                  ? "border-primary bg-primary text-primary-foreground"
                  : "border-border hover:bg-surface-2",
              )}
            >
              {t("days", { n: d })}
            </Link>
          ))}
        </nav>
      </div>
      <Card className="mt-3">
        <p className="text-muted-foreground text-sm">{t("intro")}</p>
        <ol className="mt-4 space-y-4">
          {rows.map((r, i) => (
            <li key={r.key} data-testid={`funnel-${r.key}`}>
              <div className="flex flex-wrap items-baseline justify-between gap-x-4 gap-y-1">
                <p className="font-medium">
                  <span className="text-muted-foreground mr-2 tabular-nums">{i + 1}.</span>
                  {t(`steps.${r.key}`)}
                  {drop === r.key && (
                    <span
                      className="bg-highlight-soft text-warning ml-2 rounded-full px-2 py-0.5 text-xs font-semibold"
                      data-testid="funnel-drop"
                    >
                      {t("drop")}
                    </span>
                  )}
                </p>
                <p className="tabular-nums">
                  <span className="font-display text-xl font-extrabold">
                    {format.number(r.value)}
                  </span>
                  {r.base !== null && (
                    <span className="text-muted-foreground ml-2 text-sm">
                      {r.rate === null
                        ? t("rateNone")
                        : t("rate", {
                            pct: format.number(r.rate, { maximumFractionDigits: 1 }),
                            base: t(`steps.${r.base}`),
                          })}
                    </span>
                  )}
                </p>
              </div>
              <div className="bg-surface-2 mt-1 h-2 overflow-hidden rounded-full" aria-hidden>
                <div
                  className={cn("h-full rounded-full", drop === r.key ? "bg-warning" : "bg-accent")}
                  style={{ width: `${Math.max(r.share, r.value > 0 ? 2 : 0)}%` }}
                />
              </div>
              <p className="text-muted-foreground mt-1 text-xs">{t(`hints.${r.key}`)}</p>
            </li>
          ))}
        </ol>
        {funnel.byExam.length > 0 && (
          <div className="mt-6">
            <h3 className="font-semibold">{t("byExam")}</h3>
            <ul className="mt-2 space-y-1 text-sm" data-testid="funnel-by-exam">
              {funnel.byExam.map((e) => (
                <li key={e.slug} className="flex justify-between gap-4">
                  <span>{e.name}</span>
                  <span className="tabular-nums">
                    {t("byExamValue", {
                      starts: format.number(e.starts),
                      finishes: format.number(e.finishes),
                    })}
                  </span>
                </li>
              ))}
            </ul>
          </div>
        )}
        <p className="text-muted-foreground mt-4 text-xs">{t("note")}</p>
      </Card>
    </section>
  );
}

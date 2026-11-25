import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { OVERVIEW_PERIODS, type OverviewPeriod } from "@/lib/admin/overview";
import { cn } from "@/lib/utils";

/** Selector de periodo del panel (ADR-072): cambia todas las cifras y gráficas a la vez. */
export async function PeriodPicker({ current }: { current: OverviewPeriod }) {
  const t = await getTranslations("admin.summary");
  return (
    <nav aria-label={t("period")} className="flex gap-1 text-sm" data-testid="period-picker">
      {OVERVIEW_PERIODS.map((d) => (
        <Link
          key={d}
          href={{ pathname: "/admin", query: { periodo: d } }}
          aria-current={current === d ? "true" : undefined}
          data-testid={`period-${d}`}
          className={cn(
            "rounded-full border px-3 py-1.5 font-medium",
            current === d
              ? "border-primary bg-primary text-primary-foreground"
              : "border-border hover:bg-surface-2",
          )}
        >
          {t("days", { n: d })}
        </Link>
      ))}
    </nav>
  );
}

import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Card, EmptyState } from "@/components/ui/card";
import { Link } from "@/i18n/navigation";
import { DailyChart } from "@/components/admin/daily-chart";
import { FunnelCard } from "@/components/admin/funnel-card";
import { PeriodPicker } from "@/components/admin/period-picker";
import { SummaryCards } from "@/components/admin/summary-cards";
import { UserRankingCards } from "@/components/admin/user-ranking";
import {
  getAudienceDaily,
  getAudienceMetrics,
  getFunnel,
  getOverview,
  getPracticeMetrics,
  getUserMetrics,
  getUserRanking,
} from "@/lib/admin/metrics";
import { dailyAverage, parsePeriod } from "@/lib/admin/overview";
import { pct } from "@/lib/learning/practice/format";

export const metadata: Metadata = { title: "Admin", robots: { index: false } };

export default async function AdminPage({ params, searchParams }: PageProps<"/[locale]/admin">) {
  const { locale } = await params;
  const sp = await searchParams;
  // ?periodo= (7, 30, 90); se acepta el antiguo ?embudo= de los enlaces guardados.
  const days = parsePeriod(sp.periodo ?? sp.embudo);
  setRequestLocale(locale);
  const t = await getTranslations("admin");
  const format = await getFormatter();
  const tp = await getTranslations("psycho");
  const [m, pm, am, daily, funnel, overview, ranking] = await Promise.all([
    getUserMetrics(),
    getPracticeMetrics(),
    getAudienceMetrics(),
    getAudienceDaily(days),
    getFunnel(days),
    getOverview(days),
    getUserRanking(days),
  ]);
  const formatDay = (day: string) =>
    format.dateTime(new Date(`${day}T12:00:00Z`), { day: "numeric", month: "short" });
  const formatNumber = (n: number) => format.number(n);
  const sum = (k: "visits" | "logins" | "signups") => daily.reduce((a, d) => a + d[k], 0);
  const charts = [
    { key: "visits", title: t("chartVisits"), bar: "bg-accent" },
    { key: "logins", title: t("chartLogins"), bar: "bg-primary" },
    { key: "signups", title: t("chartSignups"), bar: "bg-highlight" },
  ] as const;
  return (
    <div className="mx-auto max-w-6xl space-y-8 px-4 py-8 sm:py-10">
      <div className="flex flex-wrap items-end justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold">{t("title")}</h1>
          <p className="text-muted-foreground mt-1 text-sm" data-testid="summary-range">
            {t("summary.range", {
              from: formatDay(overview.from),
              to: formatDay(overview.to),
              prevFrom: formatDay(overview.prevFrom),
            })}
          </p>
        </div>
        <PeriodPicker current={days} />
      </div>

      <section aria-labelledby="kpi-title" className="space-y-3">
        <h2 id="kpi-title" className="text-lg font-semibold">
          {t("overview")}
        </h2>
        <SummaryCards overview={overview} />
        <p className="text-muted-foreground text-sm" data-testid="summary-today">
          {t("summary.today", {
            visits: am.visits_today,
            signups: am.signups_today,
            logins: am.logins_today,
          })}
        </p>
        <p className="text-muted-foreground text-sm">
          {t("salesHint")}{" "}
          <Link href="/admin/compras" className="text-primary font-medium underline">
            {t("salesLink")}
          </Link>
        </p>
      </section>

      <UserRankingCards ranking={ranking} />

      <section aria-labelledby="audience-title" data-testid="admin-audience">
        <div className="flex flex-wrap items-baseline justify-between gap-2">
          <h2 id="audience-title" className="text-lg font-semibold">
            {t("audienceTitle")}
          </h2>
          <Link href="/admin/trafico" className="text-primary text-sm font-medium underline">
            {t("audienceTraffic")}
          </Link>
        </div>
        <Card className="mt-4" data-testid="audience-chart">
          <h3 className="font-semibold">{t("chartTitle", { n: days })}</h3>
          <div className="mt-4 grid gap-6 lg:grid-cols-3">
            {charts.map((c) => (
              <DailyChart
                key={c.key}
                testId={`chart-${c.key}`}
                title={c.title}
                total={t("chartTotal", { n: format.number(sum(c.key)), days })}
                average={dailyAverage(daily.map((d) => d[c.key]))}
                averageLabel={t("chartAverage", {
                  n: format.number(dailyAverage(daily.map((d) => d[c.key])), {
                    maximumFractionDigits: 1,
                  }),
                })}
                points={daily.map((d) => ({ day: d.day, value: d[c.key] }))}
                formatDay={formatDay}
                formatNumber={formatNumber}
                barClassName={c.bar}
              />
            ))}
          </div>
          <p className="text-muted-foreground mt-4 text-xs">{t("chartHint")}</p>
        </Card>
        <p className="text-muted-foreground mt-3 text-sm">
          {t("audienceTotal", {
            total: format.number(am.users_total),
            confirmed: format.number(am.users_confirmed),
          })}
        </p>
        <p className="text-muted-foreground mt-1 text-xs">{t("audienceHint")}</p>
      </section>

      <FunnelCard funnel={funnel} />

      <section aria-labelledby="practice-title" data-testid="admin-practice">
        <h2 id="practice-title" className="text-lg font-semibold">
          {t("practiceTitle")}
        </h2>
        <div className="mt-3 grid gap-4 sm:grid-cols-3">
          {(
            [
              ["practiceSessions", pm.sessions_finished_7d],
              ["practiceAnswers", pm.answers_7d],
              ["practiceUsers", pm.practicing_users_7d],
            ] as const
          ).map(([key, value]) => (
            <Card key={key}>
              <p className="text-muted-foreground text-sm">{t(key)}</p>
              <p className="font-display mt-1 text-3xl font-extrabold">{format.number(value)}</p>
            </Card>
          ))}
        </div>
        {pm.by_type.length > 0 && (
          <Card className="mt-4">
            <h3 className="font-semibold">{t("practiceByType")}</h3>
            <ul className="mt-2 space-y-1 text-sm">
              {pm.by_type.map((r) => (
                <li key={r.item_type} className="flex justify-between gap-4">
                  <span>
                    {tp.has(`types.${r.item_type}.name`)
                      ? tp(`types.${r.item_type}.name`)
                      : r.item_type}
                  </span>
                  <span className="tabular-nums">
                    {pct(r.correct, r.answered)} % · {format.number(r.answered)}
                  </span>
                </li>
              ))}
            </ul>
          </Card>
        )}
      </section>

      <div className="grid gap-4 lg:grid-cols-[1fr_2fr]">
        <Card>
          <h2 className="text-lg font-semibold">{t("topExams")}</h2>
          {m.topExams.length === 0 ? (
            <p className="text-muted-foreground mt-3 text-sm">{t("noExams")}</p>
          ) : (
            <ol className="mt-3 space-y-2 text-sm">
              {m.topExams.map((e) => (
                <li key={e.slug} className="flex justify-between gap-2">
                  <span>{e.name}</span>
                  <span className="font-semibold">{e.count}</span>
                </li>
              ))}
            </ol>
          )}
        </Card>
        <Card className="overflow-x-auto">
          <h2 className="text-lg font-semibold">{t("recentUsers")}</h2>
          {m.recentUsers.length === 0 ? (
            <div className="mt-3">
              <EmptyState title={t("noUsers")} />
            </div>
          ) : (
            <table
              className="mt-3 w-full min-w-[520px] text-left text-sm"
              data-testid="recent-users"
            >
              <thead className="text-muted-foreground">
                <tr>
                  <th scope="col" className="py-2 pr-3 font-medium">
                    {t("columns.name")}
                  </th>
                  <th scope="col" className="py-2 pr-3 font-medium">
                    {t("columns.role")}
                  </th>
                  <th scope="col" className="py-2 pr-3 font-medium">
                    {t("columns.status")}
                  </th>
                  <th scope="col" className="py-2 pr-3 font-medium">
                    {t("columns.createdAt")}
                  </th>
                  <th scope="col" className="py-2 font-medium">
                    {t("columns.lastActive")}
                  </th>
                </tr>
              </thead>
              <tbody className="divide-border divide-y">
                {m.recentUsers.map((u) => (
                  <tr key={u.id}>
                    <td className="py-2 pr-3">{u.display_name ?? "—"}</td>
                    <td className="py-2 pr-3">{u.role}</td>
                    <td className="py-2 pr-3">{u.status}</td>
                    <td className="py-2 pr-3">
                      {format.dateTime(new Date(u.created_at), { dateStyle: "medium" })}
                    </td>
                    <td className="py-2">
                      {u.last_active_at
                        ? format.relativeTime(new Date(u.last_active_at))
                        : t("never")}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </Card>
      </div>
    </div>
  );
}

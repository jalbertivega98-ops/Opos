import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Card, EmptyState } from "@/components/ui/card";
import { Alert } from "@/components/ui/form";
import { getPracticeMetrics, getUserMetrics } from "@/lib/admin/metrics";
import { pct } from "@/lib/learning/practice/format";

export const metadata: Metadata = { title: "Admin", robots: { index: false } };

export default async function AdminPage({ params }: PageProps<"/[locale]/admin">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("admin");
  const format = await getFormatter();
  const tp = await getTranslations("psycho");
  const [m, pm] = await Promise.all([getUserMetrics(), getPracticeMetrics()]);

  const kpis = [
    { key: "totalUsers", value: m.totalUsers },
    { key: "newUsers7d", value: m.newUsers7d },
    { key: "active7d", value: m.active7d },
    { key: "onboarded", value: m.onboarded },
  ] as const;

  return (
    <div className="mx-auto max-w-6xl space-y-8 px-4 py-8 sm:py-10">
      <h1 className="text-3xl font-bold">{t("title")}</h1>

      <section aria-labelledby="kpi-title">
        <h2 id="kpi-title" className="sr-only">
          {t("overview")}
        </h2>
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          {kpis.map((k) => (
            <Card key={k.key} data-testid={`kpi-${k.key}`}>
              <p className="text-muted-foreground text-sm">{t(k.key)}</p>
              <p className="font-display mt-1 text-3xl font-extrabold">{format.number(k.value)}</p>
            </Card>
          ))}
        </div>
        <Alert className="mt-4">{t("pendingMetrics")}</Alert>
      </section>

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
            <table className="mt-3 w-full min-w-[520px] text-left text-sm">
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

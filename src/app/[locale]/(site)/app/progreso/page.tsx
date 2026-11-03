import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { Clock, Flame, ListChecks, Target, Trophy } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card, EmptyState } from "@/components/ui/card";
import { PracticeReview } from "@/components/psycho/review";
import { QuestionReview, type AnsweredQuestion } from "@/components/questions/review";
import { requireUser } from "@/lib/auth/session";
import { getPracticeStats, listPendingFailures } from "@/lib/learning/practice/queries";
import { pct, secondsOf } from "@/lib/learning/practice/format";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/progreso">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "progress" });
  return { title: t("title"), robots: { index: false } };
}

const DAYS = 30;

export default async function ProgressPage({ params }: PageProps<"/[locale]/app/progreso">) {
  const { locale } = await params;
  setRequestLocale(locale);
  await requireUser(locale, "/app/progreso");
  const t = await getTranslations("progress");
  const tp = await getTranslations("psycho");
  const ta = await getTranslations("app");
  const tr = await getTranslations("practice");
  const format = await getFormatter();
  const [stats, failures] = await Promise.all([getPracticeStats(DAYS), listPendingFailures(10)]);

  const header = (
    <div>
      <h1 className="text-3xl font-bold">{t("title")}</h1>
      <p className="text-muted-foreground mt-1">{t("subtitle")}</p>
    </div>
  );

  if (!stats || stats.totals.answered === 0) {
    return (
      <div className="space-y-8">
        {header}
        <EmptyState
          title={t("empty")}
          action={
            <Button asChild variant="accent">
              <Link href="/app/practica">{t("startPractice")}</Link>
            </Button>
          }
        />
      </div>
    );
  }

  const { totals } = stats;
  const kpis = [
    { icon: ListChecks, label: t("answered"), value: format.number(totals.answered) },
    {
      icon: Target,
      label: t("accuracy"),
      value: t("pct", { pct: pct(totals.correct, totals.answered) }),
    },
    {
      icon: Clock,
      label: t("avgTime"),
      value: t("seconds", { seconds: secondsOf(totals.avg_time_ms) }),
    },
    { icon: Trophy, label: t("sessions"), value: format.number(stats.sessions_finished) },
    { icon: Flame, label: t("streak"), value: ta("days", { count: stats.streak }) },
  ];
  const maxDay = Math.max(1, ...stats.daily.map((d) => d.answered));
  const dayLabel = (day: string) =>
    format.dateTime(new Date(`${day}T12:00:00`), { day: "numeric", month: "short" });

  return (
    <div className="space-y-8">
      {header}

      <dl className="grid grid-cols-2 gap-4 lg:grid-cols-5" data-testid="progress-kpis">
        {kpis.map(({ icon: Icon, label, value }) => (
          <Card key={label} className="space-y-2 p-4">
            <dt className="text-muted-foreground flex items-center gap-2 text-sm">
              <Icon className="text-accent size-4" aria-hidden /> {label}
            </dt>
            <dd className="font-display text-2xl font-bold tabular-nums">{value}</dd>
          </Card>
        ))}
      </dl>

      <Card>
        <h2 className="text-lg font-semibold">{t("dailyTitle", { days: DAYS })}</h2>
        <p className="text-muted-foreground mt-1 text-xs">{t("dailyLegend")}</p>
        <div className="mt-4 flex h-40 items-end gap-[3px]" aria-hidden>
          {stats.daily.map((d) => (
            <div
              key={d.day}
              title={t("dailyRow", {
                day: dayLabel(d.day),
                answered: d.answered,
                correct: d.correct,
              })}
              className="bg-surface-2 relative flex-1 overflow-hidden rounded-t-sm"
              style={{ height: `${d.answered ? Math.max(4, (d.answered / maxDay) * 100) : 2}%` }}
            >
              <div
                className="bg-accent absolute inset-x-0 bottom-0"
                style={{ height: `${d.answered ? (d.correct / d.answered) * 100 : 0}%` }}
              />
            </div>
          ))}
        </div>
        <div className="text-muted-foreground mt-2 flex justify-between text-xs" aria-hidden>
          <span>{dayLabel(stats.daily[0].day)}</span>
          <span>{dayLabel(stats.daily[stats.daily.length - 1].day)}</span>
        </div>
        <ul className="sr-only">
          {stats.daily
            .filter((d) => d.answered > 0)
            .map((d) => (
              <li key={d.day}>
                {t("dailyRow", { day: dayLabel(d.day), answered: d.answered, correct: d.correct })}
              </li>
            ))}
        </ul>
      </Card>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <h2 className="text-lg font-semibold">{t("byTypeTitle")}</h2>
          <table className="mt-3 w-full text-sm" data-testid="progress-by-type">
            <thead className="text-muted-foreground text-left">
              <tr>
                <th className="py-2 font-medium">{t("colType")}</th>
                <th className="py-2 text-right font-medium">{t("colAnswered")}</th>
                <th className="py-2 font-medium">{t("colAccuracy")}</th>
                <th className="py-2 text-right font-medium">{t("colTime")}</th>
              </tr>
            </thead>
            <tbody className="divide-border divide-y">
              {stats.by_type.map((r) => (
                <tr key={r.item_type}>
                  <td className="py-2">
                    {tp.has(`types.${r.item_type}.name`)
                      ? tp(`types.${r.item_type}.name`)
                      : r.item_type}
                  </td>
                  <td className="py-2 text-right tabular-nums">{r.answered}</td>
                  <td className="py-2">
                    <Meter
                      value={pct(r.correct, r.answered)}
                      label={t("pct", { pct: pct(r.correct, r.answered) })}
                    />
                  </td>
                  <td className="py-2 text-right tabular-nums">
                    {t("seconds", { seconds: secondsOf(r.avg_time_ms) })}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Card>
        <Card>
          <h2 className="text-lg font-semibold">{t("byDifficultyTitle")}</h2>
          <table className="mt-3 w-full text-sm">
            <thead className="text-muted-foreground text-left">
              <tr>
                <th className="py-2 font-medium">{t("colLevel")}</th>
                <th className="py-2 text-right font-medium">{t("colAnswered")}</th>
                <th className="py-2 font-medium">{t("colAccuracy")}</th>
              </tr>
            </thead>
            <tbody className="divide-border divide-y">
              {stats.by_difficulty.map((r) => (
                <tr key={r.difficulty}>
                  <td className="py-2">{tr("level", { level: r.difficulty })}</td>
                  <td className="py-2 text-right tabular-nums">{r.answered}</td>
                  <td className="py-2">
                    <Meter
                      value={pct(r.correct, r.answered)}
                      label={t("pct", { pct: pct(r.correct, r.answered) })}
                    />
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Card>
      </div>

      <section aria-labelledby="failed-title">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <h2 id="failed-title" className="text-lg font-semibold">
            {t("pendingReview")} ({totals.pending_review})
          </h2>
          {totals.pending_review > 0 && (
            <Button asChild variant="outline" size="sm">
              <Link href="/app/practica">{tr("reviewStart")}</Link>
            </Button>
          )}
        </div>
        {failures.length > 0 ? (
          <>
            {failures.some((f) => f.source === "question") && (
              <QuestionReview
                items={
                  failures.filter((f) => f.source === "question") as unknown as AnsweredQuestion[]
                }
              />
            )}
            <PracticeReview items={failures.filter((f) => f.source !== "question")} />
          </>
        ) : (
          <p className="text-muted-foreground mt-3 text-sm">{tr("reviewEmpty")}</p>
        )}
      </section>
    </div>
  );
}

function Meter({ value, label }: { value: number; label: string }) {
  return (
    <div className="flex items-center gap-2">
      <div className="bg-surface-2 h-2 w-full min-w-16 overflow-hidden rounded-full" aria-hidden>
        <div className="bg-accent h-2" style={{ width: `${value}%` }} />
      </div>
      <span className="w-12 text-right tabular-nums">{label}</span>
    </div>
  );
}

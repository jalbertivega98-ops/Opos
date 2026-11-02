import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import { RefreshCcw } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { Badge, Card, EmptyState } from "@/components/ui/card";
import { requireUser } from "@/lib/auth/session";
import { startPracticeAction, startReviewAction } from "@/lib/learning/practice/actions";
import { getPracticeStats, listRecentSessions } from "@/lib/learning/practice/queries";
import { SESSION_SIZES } from "@/lib/learning/practice/schema";
import { availableTypes } from "@/lib/learning/psycho/registry";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/practica">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "practice" });
  return { title: t("title"), robots: { index: false } };
}

const selectCls = "border-input bg-background h-11 w-full rounded-lg border px-3 text-base";

export default async function PracticeHub({
  params,
  searchParams,
}: PageProps<"/[locale]/app/practica">) {
  const { locale } = await params;
  setRequestLocale(locale);
  await requireUser(locale, "/app/practica");
  const sp = await searchParams;
  const t = await getTranslations("practice");
  const tp = await getTranslations("psycho");
  const format = await getFormatter();
  const [stats, recent] = await Promise.all([getPracticeStats(7), listRecentSessions(10)]);
  const pending = stats?.totals.pending_review ?? 0;
  const types = availableTypes();

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1">{t("subtitle")}</p>
      </div>

      {sp.error === "invalid" && <Alert tone="error">{t("errors.invalid")}</Alert>}
      {sp.error === "start" && <Alert tone="error">{t("errors.start")}</Alert>}
      {sp.review === "empty" && <Alert tone="info">{t("reviewEmpty")}</Alert>}

      <div className="grid gap-4 lg:grid-cols-3">
        <Card className="lg:col-span-2">
          <h2 className="text-lg font-semibold">{t("newTitle")}</h2>
          <form action={startPracticeAction} className="mt-4 grid gap-4 sm:grid-cols-3">
            <label className="space-y-1.5 text-sm font-medium sm:col-span-3">
              {t("type")}
              <select name="type" className={selectCls} defaultValue={types[0]}>
                {types.map((ty) => (
                  <option key={ty} value={ty}>
                    {tp(`types.${ty}.name`)}
                  </option>
                ))}
              </select>
            </label>
            <label className="space-y-1.5 text-sm font-medium">
              {t("count")}
              <select name="count" className={selectCls} defaultValue="10">
                {SESSION_SIZES.map((n) => (
                  <option key={n} value={n}>
                    {n}
                  </option>
                ))}
              </select>
            </label>
            <label className="space-y-1.5 text-sm font-medium">
              {t("difficulty")}
              <select name="difficulty" className={selectCls} defaultValue="auto">
                <option value="auto">{t("auto")}</option>
                {[1, 2, 3, 4, 5].map((d) => (
                  <option key={d} value={d}>
                    {t("level", { level: d })}
                  </option>
                ))}
              </select>
            </label>
            <div className="flex items-end">
              <Button type="submit" variant="accent" className="w-full">
                {t("start")}
              </Button>
            </div>
          </form>
        </Card>

        <Card>
          <h2 className="flex items-center gap-2 text-lg font-semibold">
            <RefreshCcw className="text-accent size-5" aria-hidden /> {t("reviewTitle")}
          </h2>
          <p className="mt-3 text-sm" data-testid="pending-review">
            {t("reviewBody", { count: pending })}
          </p>
          <p className="text-muted-foreground mt-2 text-xs">{t("reviewHint")}</p>
          <form action={startReviewAction} className="mt-4">
            <Button type="submit" variant="outline" disabled={pending === 0}>
              {t("reviewStart")}
            </Button>
          </form>
        </Card>
      </div>

      <section aria-labelledby="recent-title">
        <div className="flex flex-wrap items-center justify-between gap-2">
          <h2 id="recent-title" className="text-lg font-semibold">
            {t("recentTitle")}
          </h2>
          <Button asChild variant="ghost" size="sm">
            <Link href="/app/progreso">{t("toProgress")}</Link>
          </Button>
        </div>
        <div className="mt-3">
          {recent.length === 0 ? (
            <EmptyState title={t("recentEmpty")} />
          ) : (
            <ul className="divide-border border-border divide-y rounded-xl border">
              {recent.map((s) => (
                <li
                  key={s.id}
                  className="flex flex-wrap items-center justify-between gap-3 px-4 py-3 text-sm"
                >
                  <div className="flex flex-wrap items-center gap-2">
                    <span className="font-medium">
                      {s.item_type === "mixed"
                        ? t(`modes.${s.mode}`)
                        : tp.has(`types.${s.item_type}.name`)
                          ? tp(`types.${s.item_type}.name`)
                          : s.item_type}
                    </span>
                    <Badge tone={s.status === "finished" ? "success" : "warning"}>
                      {t(`status.${s.status}`)}
                    </Badge>
                    <time dateTime={s.started_at} className="text-muted-foreground">
                      {format.relativeTime(new Date(s.started_at))}
                    </time>
                  </div>
                  <div className="flex items-center gap-3">
                    <span className="font-semibold tabular-nums">
                      {t("score", { correct: s.correct_count, total: s.item_count })}
                    </span>
                    <Button asChild size="sm" variant="outline">
                      <Link href={`/app/practica/${s.id}`}>
                        {s.status === "active" ? t("continue") : t("see")}
                      </Link>
                    </Button>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </div>
      </section>
    </div>
  );
}

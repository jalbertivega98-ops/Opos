import type { Metadata } from "next";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Card, EmptyState } from "@/components/ui/card";
import { WeekPlanView } from "@/components/plan/week-plan";
import { PlanSettingsForm } from "@/components/plan/settings-form";
import { requireUser } from "@/lib/auth/session";
import { localized } from "@/lib/catalog/queries";
import { getMyPlan } from "@/lib/learning/plan-queries";
import { myLibrary, planAccess } from "@/lib/store/queries";
import { TOPIC_DONE } from "@/lib/learning/plan";
import { studyWeek } from "@/lib/learning/calendar";
import { getStudyLog } from "@/lib/learning/calendar-queries";
import { Alert } from "@/components/ui/form";
import { TopicTestButton } from "@/components/plan/topic-test-button";

export async function generateMetadata({
  params,
}: PageProps<"/[locale]/app/plan">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "plan" });
  return { title: t("title"), robots: { index: false } };
}

export default async function PlanPage({ params, searchParams }: PageProps<"/[locale]/app/plan">) {
  const { locale } = await params;
  const sp = await searchParams;
  setRequestLocale(locale);
  await requireUser(locale, "/app/plan");
  const t = await getTranslations("plan");
  const week = studyWeek(new Date());
  const [data, library, entries] = await Promise.all([
    getMyPlan(),
    myLibrary(),
    getStudyLog(week.start, week.end),
  ]);
  if (data.reason !== null) {
    return (
      <EmptyState
        title={t("emptyTitle")}
        description={t(data.reason === "noTarget" ? "empty" : "emptyNoContent")}
        action={
          data.reason === "noTarget" ? (
            <Button asChild variant="accent">
              <Link href="/app/onboarding">{t("emptyCta")}</Link>
            </Button>
          ) : undefined
        }
      />
    );
  }
  const { settings, plan, topics, openTopics, noteTopics } = data;
  const access = planAccess(library, openTopics);
  const errorKey = sp.error === "access" || sp.error === "start" ? sp.error : null;
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">{t("title")}</h1>
        <p className="text-muted-foreground mt-1">
          {t("subtitle", { exam: localized(locale, settings.examName, settings.examNameCa) })}
        </p>
      </div>
      {errorKey && <Alert tone="error">{t(`errors.${errorKey}`)}</Alert>}
      <Card className="space-y-3">
        <h2 className="text-lg font-semibold">{t("thisWeek")}</h2>
        <WeekPlanView
          plan={plan}
          access={access}
          examSlug={settings.examSlug}
          notes={noteTopics}
          entries={entries}
          back="/app/plan"
        />
        <p className="text-muted-foreground text-xs">
          {plan.minutes.psycho > 0
            ? t("split", {
                syllabus: plan.minutes.syllabus,
                psycho: plan.minutes.psycho,
                mocks: plan.minutes.mocks,
              })
            : t("splitNoPsycho", { syllabus: plan.minutes.syllabus, mocks: plan.minutes.mocks })}
        </p>
      </Card>
      <Card className="space-y-3">
        <h2 className="text-lg font-semibold">{t("topicsTitle")}</h2>
        <p className="text-muted-foreground text-xs">
          {t("doneRule", { answered: TOPIC_DONE.answered, pct: TOPIC_DONE.accuracy * 100 })}
        </p>
        <ul className="grid gap-2 sm:grid-cols-2" data-testid="plan-topics">
          {topics.map((tp) => {
            const acc = tp.answered ? Math.round((tp.correct / tp.answered) * 100) : null;
            const done =
              tp.answered >= TOPIC_DONE.answered && (acc ?? 0) >= TOPIC_DONE.accuracy * 100;
            return (
              <li
                key={tp.slug}
                className="border-border flex items-center justify-between gap-2 rounded-lg border px-3 py-2 text-sm"
              >
                <span className={done ? "text-success font-medium" : ""}>{tp.title}</span>
                <span className="flex shrink-0 items-center gap-2">
                  <span className="text-muted-foreground tabular-nums">
                    {acc === null ? t("notStarted") : t("accuracy", { pct: acc, n: tp.answered })}
                  </span>
                  {(access.topics || openTopics.includes(tp.slug)) && (
                    <TopicTestButton topic={tp.slug} back="/app/plan" variant="outline">
                      {t("test")}
                    </TopicTestButton>
                  )}
                </span>
              </li>
            );
          })}
        </ul>
      </Card>
      <Card className="space-y-3">
        <h2 className="text-lg font-semibold">{t("settings.title")}</h2>
        <PlanSettingsForm settings={settings} />
      </Card>
    </div>
  );
}

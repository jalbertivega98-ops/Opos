import type { Metadata } from "next";
import { getFormatter, getTranslations, setRequestLocale } from "next-intl/server";
import {
  Activity,
  ArrowRight,
  CalendarCheck,
  ChevronRight,
  Flame,
  Library,
  Play,
  RefreshCcw,
  Shapes,
  Target,
  TrendingUp,
  UserRound,
} from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Button } from "@/components/ui/button";
import { Alert } from "@/components/ui/form";
import { Badge } from "@/components/ui/card";
import { IconBadge } from "@/components/ui/icon-badge";
import { Eyebrow } from "@/components/ui/section";
import { DayBars, Meter, ProgressRing } from "@/components/ui/progress";
import { requireUser } from "@/lib/auth/session";
import { createClient } from "@/lib/supabase/server";
import { localized } from "@/lib/catalog/queries";
import {
  getPracticeStats,
  listRecentSessions,
  pendingBySource,
} from "@/lib/learning/practice/queries";
import { startReviewAction } from "@/lib/learning/practice/actions";
import { startQuestionReviewAction } from "@/lib/learning/questions/actions";
import { lastDays, pct } from "@/lib/learning/practice/format";
import { getMyPlan } from "@/lib/learning/plan-queries";
import type { PlanTask } from "@/lib/learning/plan";
import { taskUnlocked, WeekPlanView } from "@/components/plan/week-plan";
import { myLibrary, planAccess } from "@/lib/store/queries";
import { cn } from "@/lib/utils";

export async function generateMetadata({ params }: PageProps<"/[locale]/app">): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "nav" });
  return { title: t("dashboard"), robots: { index: false } };
}

type Target = {
  is_primary: boolean;
  follow_only: boolean;
  exam: { slug: string; name: string; name_ca: string | null; availability: string } | null;
};

const DAYS = 7;
const taskHref = (task: PlanTask) => (task.kind === "psycho" ? "/app/practica" : "/app/productos");

export default async function Dashboard({ params, searchParams }: PageProps<"/[locale]/app">) {
  const { locale } = await params;
  setRequestLocale(locale);
  const sp = await searchParams;
  const { user, profile } = await requireUser(locale);
  const t = await getTranslations();
  const format = await getFormatter();
  const supabase = await createClient();

  const [{ data: targets }, { data: activity }, practice, myPlan, recent, split, library] =
    await Promise.all([
      supabase
        .from("user_exam_targets")
        .select("is_primary, follow_only, exam:exam_bodies(slug, name, name_ca, availability)")
        .eq("user_id", user.id)
        .order("is_primary", { ascending: false })
        .returns<Target[]>(),
      supabase
        .from("activity_events")
        .select("id, kind, created_at")
        .eq("user_id", user.id)
        .order("created_at", { ascending: false })
        .limit(5),
      getPracticeStats(DAYS),
      getMyPlan(),
      listRecentSessions(5),
      pendingBySource(),
      myLibrary(),
    ]);

  const name = profile.display_name;
  const onboarded = Boolean(profile.onboarding_completed_at);
  const answered = practice?.totals.answered ?? 0;
  const accuracy = answered ? pct(practice!.totals.correct, answered) : null;
  const pending = split.psycho + split.questions;
  const active = recent.find((s) => s.status === "active");
  const access = planAccess(library, myPlan.reason === null ? myPlan.freeTopics : []);
  // Siguiente tarea que el alumno puede hacer ya (las de pago sin acceso se saltan).
  const nextTask =
    myPlan.reason === null
      ? myPlan.plan.tasks.find((task) => taskUnlocked(task, access))
      : undefined;

  const sessionName = (s: { item_type: string; mode: string }) =>
    s.item_type === "mixed"
      ? t(`practice.modes.${s.mode}`)
      : t.has(`psycho.types.${s.item_type}.name`)
        ? t(`psycho.types.${s.item_type}.name`)
        : t.has(`practice.modes.${s.mode}`)
          ? t(`practice.modes.${s.mode}`)
          : s.item_type;
  const taskLabel = (task: PlanTask) =>
    task.kind === "topic"
      ? t("plan.taskTopic", { topic: task.topic.title, count: task.questions })
      : task.kind === "psycho"
        ? t("plan.taskPsycho", { count: task.sessions })
        : t(`plan.taskMock.${task.mock}`, { count: task.count });

  // Últimos 7 días (incluido hoy), con ceros donde no hubo práctica.
  const byDay = new Map((practice?.daily ?? []).map((d) => [d.day, d]));
  const days = lastDays(DAYS).map(({ date, key }) => {
    const d = byDay.get(key);
    return {
      key,
      label: format.dateTime(date, { weekday: "narrow" }),
      answered: d?.answered ?? 0,
      correct: d?.correct ?? 0,
    };
  });

  const stats = [
    {
      icon: Flame,
      label: t("app.streak"),
      value: answered ? t("app.days", { count: practice!.streak }) : null,
    },
    { icon: Target, label: t("app.accuracy"), value: accuracy !== null ? `${accuracy} %` : null },
    {
      icon: TrendingUp,
      label: t("app.answeredStat"),
      value: answered ? format.number(answered) : null,
    },
  ];

  return (
    <div className="space-y-6 sm:space-y-8">
      <header>
        <p className="text-muted-foreground text-sm font-medium first-letter:uppercase">
          {format.dateTime(new Date(), { weekday: "long", day: "numeric", month: "long" })}
        </p>
        <h1 className="mt-1 text-3xl font-extrabold sm:text-4xl">
          {name ? t("app.greeting", { name }) : t("app.greetingAnon")}
        </h1>
        <p className="text-muted-foreground mt-1">{t("app.subtitle")}</p>
      </header>

      {sp.pw === "updated" && <Alert tone="success">{t("app.passwordUpdated")}</Alert>}
      {sp.welcome === "1" && <Alert tone="success">{t("onboarding.saved")}</Alert>}

      {/* Nivel 1: continuar practicando + progreso */}
      <div className="grid gap-4 lg:grid-cols-3 lg:gap-6">
        <section
          aria-labelledby="continue-title"
          className="bg-ink text-ink-foreground bg-grid relative flex flex-col overflow-hidden rounded-3xl p-6 sm:p-8 lg:col-span-2"
        >
          {!onboarded ? (
            <>
              <Eyebrow onInk>{t("app.onboardingEyebrow")}</Eyebrow>
              <h2 id="continue-title" className="mt-3 text-2xl font-extrabold sm:text-3xl">
                {t("app.onboardingTitle")}
              </h2>
              <p className="text-ink-muted mt-2 max-w-lg">{t("app.onboardingBody")}</p>
              <div className="mt-auto flex flex-col gap-3 pt-8 sm:flex-row sm:items-center">
                <Button asChild variant="accent" size="lg">
                  <Link href="/app/onboarding">
                    {t("app.onboardingCta")} <ArrowRight aria-hidden />
                  </Link>
                </Button>
                <Link
                  href="/app/practica"
                  className="text-ink-foreground inline-flex min-h-11 items-center gap-1 text-sm font-semibold underline-offset-4 hover:underline"
                >
                  {t("app.orPractice")}
                </Link>
              </div>
            </>
          ) : (
            <>
              <Eyebrow onInk>{t("app.continueEyebrow")}</Eyebrow>
              {active ? (
                <>
                  <h2 id="continue-title" className="mt-3 text-2xl font-extrabold sm:text-3xl">
                    {t("app.continueActiveTitle")}
                  </h2>
                  <p className="text-ink-muted mt-2">
                    {t("app.continueActiveBody", {
                      type: sessionName(active),
                      answered: active.answered_count,
                      total: active.item_count,
                    })}
                  </p>
                  <Meter
                    tone="onInk"
                    className="mt-4 max-w-md"
                    value={active.answered_count}
                    max={active.item_count}
                    label={t("app.continueActiveBody", {
                      type: sessionName(active),
                      answered: active.answered_count,
                      total: active.item_count,
                    })}
                  />
                  {nextTask && (
                    <Link
                      href={taskHref(nextTask)}
                      className="bg-ink-2 hover:bg-ink-2/80 mt-6 flex min-h-12 max-w-md items-center gap-3 rounded-xl px-4 py-3 text-sm"
                    >
                      <span className="flex-1">
                        <span className="text-ink-muted block text-xs">{t("app.nextTitle")}</span>
                        <span className="font-semibold">{taskLabel(nextTask)}</span>
                      </span>
                      <ChevronRight className="size-4" aria-hidden />
                    </Link>
                  )}
                </>
              ) : nextTask ? (
                <>
                  <h2 id="continue-title" className="mt-3 text-2xl font-extrabold sm:text-3xl">
                    {t("app.nextTitle")}
                  </h2>
                  <p className="text-ink-muted mt-2 text-lg">{taskLabel(nextTask)}</p>
                </>
              ) : (
                <>
                  <h2 id="continue-title" className="mt-3 text-2xl font-extrabold sm:text-3xl">
                    {t("app.startTitle")}
                  </h2>
                  <p className="text-ink-muted mt-2 max-w-lg">{t("app.startBody")}</p>
                </>
              )}
              <div className="mt-auto flex flex-col gap-3 pt-8 sm:flex-row sm:items-center">
                <Button asChild variant="accent" size="lg">
                  <Link
                    href={
                      active
                        ? `/app/practica/${active.id}`
                        : nextTask
                          ? taskHref(nextTask)
                          : "/app/practica"
                    }
                  >
                    <Play aria-hidden />
                    {active
                      ? t("app.continueCta")
                      : nextTask
                        ? t("app.nextCta")
                        : t("app.practiceCta")}
                  </Link>
                </Button>
                <Link
                  href="/app/practica"
                  className="text-ink-foreground inline-flex min-h-11 items-center gap-1 text-sm font-semibold underline-offset-4 hover:underline"
                >
                  {t("app.newPractice")} <ChevronRight className="size-4" aria-hidden />
                </Link>
              </div>
            </>
          )}
        </section>

        <section
          aria-labelledby="progress-title"
          className="border-border bg-background flex flex-col rounded-3xl border p-6"
        >
          <div className="flex items-center justify-between gap-2">
            <h2 id="progress-title" className="text-lg font-bold">
              {t("app.progressTitle")}
            </h2>
            <span className="text-muted-foreground text-xs">{t("app.last7")}</span>
          </div>
          <div className="mt-4 flex items-center gap-5">
            <ProgressRing
              value={accuracy}
              size={96}
              label={
                accuracy !== null ? t("app.ringLabel", { pct: accuracy }) : t("app.ringNoData")
              }
            >
              <span className="font-display text-2xl font-extrabold tabular-nums">
                {accuracy !== null ? `${accuracy}%` : "—"}
              </span>
              <span className="text-muted-foreground -mt-3 text-[11px]">{t("app.accuracy")}</span>
            </ProgressRing>
            <dl className="grid flex-1 gap-2 text-sm">
              {stats.map(({ icon: Icon, label, value }) => (
                <div key={label} className="flex items-center justify-between gap-2">
                  <dt className="text-muted-foreground flex items-center gap-1.5">
                    <Icon className="size-4" aria-hidden />
                    {label}
                  </dt>
                  <dd className="text-right font-bold tabular-nums" data-testid="dashboard-stat">
                    {value ?? (
                      <>
                        <span aria-hidden>—</span>
                        <span className="sr-only">{t("app.noData")}</span>
                      </>
                    )}
                  </dd>
                </div>
              ))}
            </dl>
          </div>
          {answered > 0 ? (
            <DayBars
              className="mt-5"
              days={days}
              caption={t("app.chartCaption")}
              answeredLabel={t("app.answeredLabel")}
              correctLabel={t("app.correctLabel")}
            />
          ) : (
            <p className="bg-surface text-muted-foreground mt-5 rounded-xl p-4 text-sm">
              {t("app.progressEmpty")}
            </p>
          )}
          <Link
            href="/app/progreso"
            className="text-accent mt-auto inline-flex min-h-11 items-center gap-1 pt-4 text-sm font-semibold hover:underline"
          >
            {t("app.progressCta")} <ArrowRight className="size-4" aria-hidden />
          </Link>
        </section>
      </div>

      {/* Nivel 1: repaso de errores + plan */}
      <div className="grid gap-4 lg:grid-cols-3 lg:gap-6">
        <section
          aria-labelledby="review-title"
          className={cn(
            "flex flex-col rounded-3xl border p-6",
            pending > 0 ? "bg-highlight-soft border-highlight/50" : "border-border bg-background",
          )}
        >
          <div className="flex items-center gap-3">
            <IconBadge icon={RefreshCcw} tone={pending > 0 ? "highlight" : "neutral"} />
            <h2 id="review-title" className="text-lg font-bold">
              {t("app.reviewTitle")}
            </h2>
          </div>
          {pending > 0 ? (
            <>
              <p className="mt-4">
                <span className="font-display text-4xl font-extrabold tabular-nums">{pending}</span>{" "}
                <span className="text-muted-foreground">
                  {t("app.pendingWord", { count: pending })}
                </span>
              </p>
              <p className="text-muted-foreground mt-1 text-sm">{t("practice.reviewHint")}</p>
              <div className="mt-auto grid gap-2 pt-5">
                <form action={startReviewAction}>
                  <Button
                    type="submit"
                    variant="primary"
                    className="w-full justify-between"
                    disabled={split.psycho === 0}
                  >
                    {t("practice.reviewPsycho")}
                    <Badge className="bg-primary-foreground/15 text-primary-foreground">
                      {split.psycho}
                    </Badge>
                  </Button>
                </form>
                <form action={startQuestionReviewAction}>
                  <Button
                    type="submit"
                    variant="outline"
                    className="w-full justify-between"
                    disabled={split.questions === 0}
                  >
                    {t("practice.reviewQuestions")}
                    <Badge>{split.questions}</Badge>
                  </Button>
                </form>
              </div>
            </>
          ) : (
            <p className="text-muted-foreground mt-4 text-sm">
              {answered > 0 ? t("practice.reviewBody", { count: 0 }) : t("app.reviewNone")}
            </p>
          )}
        </section>

        <section
          aria-labelledby="plan-title"
          className="border-border bg-background rounded-3xl border p-6 lg:col-span-2"
        >
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div className="flex items-center gap-3">
              <IconBadge icon={CalendarCheck} />
              <h2 id="plan-title" className="text-lg font-bold">
                {t("app.plan")}
              </h2>
            </div>
            {myPlan.reason === null && (
              <Link
                href="/app/plan"
                className="text-accent inline-flex min-h-11 items-center gap-1 text-sm font-semibold hover:underline"
              >
                {t("plan.open")} <ArrowRight className="size-4" aria-hidden />
              </Link>
            )}
          </div>
          {myPlan.reason === null ? (
            <div className="mt-4">
              <WeekPlanView
                plan={myPlan.plan}
                access={access}
                examSlug={myPlan.settings.examSlug}
              />
            </div>
          ) : (
            <div className="bg-surface mt-4 flex flex-col gap-3 rounded-xl p-4 sm:flex-row sm:items-center sm:justify-between">
              <p className="text-muted-foreground text-sm">
                {myPlan.reason === "noTarget" ? t("plan.empty") : t("app.planEmpty")}
              </p>
              {myPlan.reason === "noTarget" && (
                <Button asChild variant="outline" size="sm">
                  <Link href="/app/onboarding">{t("plan.emptyCta")}</Link>
                </Button>
              )}
            </div>
          )}
        </section>
      </div>

      {/* Nivel 2: opciones secundarias */}
      <section aria-labelledby="more-title" className="pt-2">
        <h2
          id="more-title"
          className="text-muted-foreground font-sans text-xs font-bold tracking-[0.14em] uppercase"
        >
          {t("app.moreTitle")}
        </h2>
        <div className="mt-3 grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          <div className="border-border bg-surface rounded-2xl border p-5">
            <h3 className="font-semibold">{t("app.myExams")}</h3>
            {targets && targets.length > 0 ? (
              <ul className="mt-3 space-y-2">
                {targets.map((tg) =>
                  tg.exam ? (
                    <li key={tg.exam.slug} className="flex flex-wrap items-center gap-2 text-sm">
                      <Link
                        href={`/oposiciones/${tg.exam.slug}`}
                        className="font-medium hover:underline"
                      >
                        {localized(locale, tg.exam.name, tg.exam.name_ca)}
                      </Link>
                      {tg.is_primary && <Badge tone="accent">{t("app.primary")}</Badge>}
                      {tg.follow_only && <Badge tone="warning">{t("app.following")}</Badge>}
                    </li>
                  ) : null,
                )}
              </ul>
            ) : (
              <p className="text-muted-foreground mt-3 text-sm">{t("app.noData")}</p>
            )}
            <Link
              href="/oposiciones"
              className="text-accent mt-2 inline-flex min-h-11 items-center gap-1 text-sm font-semibold hover:underline"
            >
              {t("app.addExam")} <ArrowRight className="size-4" aria-hidden />
            </Link>
          </div>

          <div className="border-border bg-surface rounded-2xl border p-5">
            <h3 className="flex items-center gap-2 font-semibold">
              <Activity className="text-muted-foreground size-4" aria-hidden />
              {t("app.activity")}
            </h3>
            {activity && activity.length > 0 ? (
              <ul className="mt-3 space-y-2">
                {activity.map((a) => (
                  <li key={a.id} className="flex justify-between gap-4 text-sm">
                    <span>
                      {t.has(`app.activityKinds.${a.kind.replace(".", "_")}`)
                        ? t(`app.activityKinds.${a.kind.replace(".", "_")}`)
                        : a.kind}
                    </span>
                    <time dateTime={a.created_at} className="text-muted-foreground shrink-0">
                      {format.relativeTime(new Date(a.created_at))}
                    </time>
                  </li>
                ))}
              </ul>
            ) : (
              <p className="text-muted-foreground mt-3 text-sm">{t("app.activityEmpty")}</p>
            )}
          </div>

          <ul className="grid gap-2 md:col-span-2 lg:col-span-1">
            {[
              {
                href: "/app/practica",
                icon: Shapes,
                title: t("nav.practice"),
                body: t("app.shortcuts.practice"),
              },
              {
                href: "/app/productos",
                icon: Library,
                title: t("nav.library"),
                body: t("app.shortcuts.library"),
              },
              {
                href: "/app/perfil",
                icon: UserRound,
                title: t("nav.profile"),
                body: t("app.shortcuts.profile"),
              },
            ].map(({ href, icon, title, body }) => (
              <li key={href}>
                <Link
                  href={href}
                  className="border-border bg-surface hover:border-accent group flex min-h-16 items-center gap-3 rounded-2xl border p-4 transition-colors"
                >
                  <IconBadge icon={icon} tone="neutral" size="sm" />
                  <span className="flex-1">
                    <span className="block text-sm font-semibold">{title}</span>
                    <span className="text-muted-foreground block text-xs">{body}</span>
                  </span>
                  <ChevronRight
                    className="text-muted-foreground group-hover:text-accent size-4"
                    aria-hidden
                  />
                </Link>
              </li>
            ))}
          </ul>
        </div>
      </section>
    </div>
  );
}

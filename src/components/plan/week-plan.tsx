import { getTranslations } from "next-intl/server";
import { BookOpen, Brain, Check, ChevronRight, FileText, Lock, Play, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Meter } from "@/components/ui/progress";
import type { PlanTask, WeekPlan } from "@/lib/learning/plan";
import { taskProgress, type StudyEntry } from "@/lib/learning/calendar";
import { taskUnlocked, type PlanAccess } from "@/lib/store/access";
import { TopicTestButton } from "@/components/plan/topic-test-button";
import { cn } from "@/lib/utils";

export { taskUnlocked };

/** Preguntas que quedan de la tarea esta semana (mínimo un test corto). */
export function remainingQuestions(task: PlanTask, entries: StudyEntry[]) {
  if (task.kind !== "topic") return 0;
  const p = taskProgress(task, entries);
  return p.state === "done" ? 10 : p.target - p.done;
}

/**
 * Tareas de la semana del plan. Cada tema lleva directo a su ficha y a su test;
 * los psicotécnicos, a la práctica, y los simulacros, a su pestaña. Con lo hecho
 * esta semana se ve cuánto queda de cada tarea. Lo de pago que el alumno no
 * tiene se ve con candado «Premium» y lleva a «Qué incluye» de su oposición.
 */
export async function WeekPlanView({
  plan,
  access,
  examSlug,
  notes = [],
  entries = [],
  back = "/app/plan",
}: {
  plan: WeekPlan;
  access: PlanAccess;
  examSlug: string;
  /** Temas con ficha publicada. */
  notes?: string[];
  /** Lo hecho esta semana (calendario). */
  entries?: StudyEntry[];
  back?: "/app" | "/app/plan";
}) {
  const t = await getTranslations("plan");
  const label = (task: PlanTask) =>
    task.kind === "topic"
      ? t("taskTopic", { topic: task.topic.title, count: task.questions })
      : task.kind === "psycho"
        ? t("taskPsycho", { count: task.sessions })
        : t(`taskMock.${task.mock}`, { count: task.count });
  const Icon = (task: PlanTask) =>
    task.kind === "topic" ? BookOpen : task.kind === "psycho" ? Brain : Timer;
  const anyLocked = plan.tasks.some((task) => !taskUnlocked(task, access));

  return (
    <div className="space-y-4" data-testid="week-plan">
      <div className="flex flex-wrap items-center gap-x-3 gap-y-1 text-sm">
        <span className="font-semibold">
          {t("week", { week: plan.week, total: plan.totalWeeks })}
        </span>
        <Badge>{t(`phases.${plan.phase}`)}</Badge>
      </div>
      <ul className="grid gap-2">
        {plan.tasks.map((task, i) => {
          const TaskIcon = Icon(task);
          const open = taskUnlocked(task, access);
          const progress = taskProgress(task, entries);
          const done = progress.state === "done";
          return (
            <li
              key={i}
              data-testid="plan-task"
              data-locked={open ? undefined : "true"}
              data-state={progress.state}
              className={cn(
                "border-border flex flex-wrap items-center gap-x-3 gap-y-2 rounded-xl border px-3 py-2.5 text-sm",
                !open && "bg-surface",
                done && "border-success/40",
              )}
            >
              {done ? (
                <Check className="text-success size-4 shrink-0" aria-hidden />
              ) : (
                <TaskIcon
                  className={cn("size-4 shrink-0", open ? "text-accent" : "text-muted-foreground")}
                  aria-hidden
                />
              )}
              <span className="min-w-0 flex-1 basis-48">
                <span className={cn("block", !open && "text-muted-foreground")}>{label(task)}</span>
                {open && (
                  <span className="text-muted-foreground block text-xs" data-testid="task-progress">
                    {done
                      ? t("taskDone")
                      : task.kind === "topic"
                        ? t("progressTopic", { done: progress.done, target: progress.target })
                        : t("progressCount", { done: progress.done, target: progress.target })}
                  </span>
                )}
              </span>
              {task.kind === "psycho" && !done && (
                <Badge tone="success" data-testid="task-free">
                  {t("free")}
                </Badge>
              )}
              {task.kind === "topic" && open && !done && (
                <Badge tone={task.status === "new" ? "accent" : "warning"}>
                  {t(`status.${task.status}`)}
                </Badge>
              )}
              {!open ? (
                <Link
                  href={`/oposiciones/${examSlug}`}
                  className="bg-highlight-soft text-highlight-foreground dark:text-highlight inline-flex min-h-9 items-center gap-1 rounded-full px-3 text-xs font-semibold hover:underline"
                >
                  <Lock className="size-3" aria-hidden />
                  {t("premium")}
                </Link>
              ) : task.kind === "topic" ? (
                <span className="flex items-center gap-1.5">
                  {notes.includes(task.topic.slug) && (
                    <Button asChild variant="ghost" size="sm">
                      <Link href={`/app/temario/${task.topic.slug}`} data-testid="task-note">
                        <FileText aria-hidden />
                        {t("readNote")}
                      </Link>
                    </Button>
                  )}
                  <TopicTestButton
                    topic={task.topic.slug}
                    count={remainingQuestions(task, entries)}
                    back={back}
                    variant={done ? "outline" : "accent"}
                  >
                    <Play aria-hidden />
                    {done ? t("again") : t("startTest")}
                  </TopicTestButton>
                </span>
              ) : (
                <Button asChild variant={done ? "ghost" : "outline"} size="sm">
                  <Link href={task.kind === "psycho" ? "/app/practica" : "/app/simulacros"}>
                    {task.kind === "psycho" ? t("goPsycho") : t("goMocks")}
                    <ChevronRight aria-hidden />
                  </Link>
                </Button>
              )}
            </li>
          );
        })}
      </ul>
      <p className="text-muted-foreground text-xs" data-testid="plan-legend">
        {plan.tasks.some((task) => task.kind === "psycho") ? t("legend") : t("legendNoPsycho")}
      </p>
      {anyLocked && (
        <p className="text-muted-foreground text-xs" data-testid="plan-locked-note">
          {t("lockedNote")}{" "}
          <Link
            href={`/oposiciones/${examSlug}`}
            className="text-accent font-semibold hover:underline"
          >
            {t("lockedCta")}
          </Link>
        </p>
      )}
      <div className="space-y-1.5">
        <p className="text-muted-foreground text-xs">
          {t("covered", { covered: plan.covered, total: plan.totalTopics })}
        </p>
        <Meter
          value={plan.covered}
          max={plan.totalTopics}
          label={t("covered", { covered: plan.covered, total: plan.totalTopics })}
        />
      </div>
    </div>
  );
}

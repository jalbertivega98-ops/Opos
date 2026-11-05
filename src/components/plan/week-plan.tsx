import { getTranslations } from "next-intl/server";
import { BookOpen, Brain, ChevronRight, Lock, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge } from "@/components/ui/card";
import { Meter } from "@/components/ui/progress";
import type { PlanTask, WeekPlan } from "@/lib/learning/plan";
import { taskUnlocked, type PlanAccess } from "@/lib/store/access";

export { taskUnlocked };
import { cn } from "@/lib/utils";

/**
 * Tareas de la semana del plan, con enlace a donde se hacen. Las de pago que el
 * alumno no tiene se ven igual, con candado «Premium», y llevan a «Qué incluye».
 */
export async function WeekPlanView({
  plan,
  access,
  examSlug,
}: {
  plan: WeekPlan;
  access: PlanAccess;
  examSlug: string;
}) {
  const t = await getTranslations("plan");
  const row =
    "border-border group flex min-h-12 items-center gap-3 rounded-xl border px-3 py-2 text-sm transition-colors";
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
          return (
            <li key={i} data-testid="plan-task" data-locked={open ? undefined : "true"}>
              <Link
                href={
                  open
                    ? task.kind === "psycho"
                      ? "/app/practica"
                      : "/app/productos"
                    : `/oposiciones/${examSlug}`
                }
                className={cn(
                  row,
                  open
                    ? "hover:border-accent hover:bg-accent-soft/40"
                    : "bg-surface hover:border-highlight",
                )}
              >
                <TaskIcon
                  className={cn("size-4 shrink-0", open ? "text-accent" : "text-muted-foreground")}
                  aria-hidden
                />
                <span className={cn("flex-1", !open && "text-muted-foreground")}>
                  {label(task)}
                </span>
                {task.kind === "topic" && open && (
                  <Badge tone={task.status === "new" ? "accent" : "warning"}>
                    {t(`status.${task.status}`)}
                  </Badge>
                )}
                {open ? (
                  <ChevronRight className="text-muted-foreground size-4 shrink-0" aria-hidden />
                ) : (
                  <span className="bg-highlight-soft text-highlight-foreground dark:text-highlight inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-xs font-semibold">
                    <Lock className="size-3" aria-hidden />
                    {t("premium")}
                  </span>
                )}
              </Link>
            </li>
          );
        })}
      </ul>
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

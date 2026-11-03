import { getTranslations } from "next-intl/server";
import { BookOpen, Brain, ChevronRight, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge } from "@/components/ui/card";
import { Meter } from "@/components/ui/progress";
import type { WeekPlan } from "@/lib/learning/plan";

/** Tareas de la semana del plan, con enlace a donde se hacen. */
export async function WeekPlanView({ plan }: { plan: WeekPlan }) {
  const t = await getTranslations("plan");
  const row =
    "border-border hover:border-accent hover:bg-accent-soft/40 group flex min-h-12 items-center gap-3 rounded-xl border px-3 py-2 text-sm transition-colors";
  return (
    <div className="space-y-4" data-testid="week-plan">
      <div className="flex flex-wrap items-center gap-x-3 gap-y-1 text-sm">
        <span className="font-semibold">
          {t("week", { week: plan.week, total: plan.totalWeeks })}
        </span>
        <Badge>{t(`phases.${plan.phase}`)}</Badge>
      </div>
      <ul className="grid gap-2">
        {plan.tasks.map((task, i) => (
          <li key={i} data-testid="plan-task">
            {task.kind === "topic" ? (
              <Link href="/app/productos" className={row}>
                <BookOpen className="text-accent size-4 shrink-0" aria-hidden />
                <span className="flex-1">
                  {t("taskTopic", { topic: task.topic.title, count: task.questions })}
                </span>
                <Badge tone={task.status === "new" ? "accent" : "warning"}>
                  {t(`status.${task.status}`)}
                </Badge>
                <ChevronRight className="text-muted-foreground size-4 shrink-0" aria-hidden />
              </Link>
            ) : task.kind === "psycho" ? (
              <Link href="/app/practica" className={row}>
                <Brain className="text-accent size-4 shrink-0" aria-hidden />
                <span className="flex-1">{t("taskPsycho", { count: task.sessions })}</span>
                <ChevronRight className="text-muted-foreground size-4 shrink-0" aria-hidden />
              </Link>
            ) : (
              <Link href="/app/productos" className={row}>
                <Timer className="text-accent size-4 shrink-0" aria-hidden />
                <span className="flex-1">{t(`taskMock.${task.mock}`, { count: task.count })}</span>
                <ChevronRight className="text-muted-foreground size-4 shrink-0" aria-hidden />
              </Link>
            )}
          </li>
        ))}
      </ul>
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

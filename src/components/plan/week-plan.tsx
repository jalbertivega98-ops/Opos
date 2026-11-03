import { getTranslations } from "next-intl/server";
import { BookOpen, Brain, Timer } from "lucide-react";
import { Link } from "@/i18n/navigation";
import { Badge } from "@/components/ui/card";
import type { WeekPlan } from "@/lib/learning/plan";

/** Tareas de la semana del plan, con enlace a donde se hacen. */
export async function WeekPlanView({ plan }: { plan: WeekPlan }) {
  const t = await getTranslations("plan");
  return (
    <div className="space-y-3" data-testid="week-plan">
      <p className="text-sm">
        <span className="font-semibold">
          {t("week", { week: plan.week, total: plan.totalWeeks })}
        </span>{" "}
        · {t(`phases.${plan.phase}`)}
      </p>
      <ul className="space-y-2">
        {plan.tasks.map((task, i) => (
          <li key={i} className="flex items-start gap-2 text-sm" data-testid="plan-task">
            {task.kind === "topic" ? (
              <>
                <BookOpen className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                <Link href="/app/productos" className="flex-1 hover:underline">
                  {t("taskTopic", { topic: task.topic.title, count: task.questions })}
                </Link>
                <Badge tone={task.status === "new" ? "accent" : "warning"}>
                  {t(`status.${task.status}`)}
                </Badge>
              </>
            ) : task.kind === "psycho" ? (
              <>
                <Brain className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                <Link href="/app/practica" className="flex-1 hover:underline">
                  {t("taskPsycho", { count: task.sessions })}
                </Link>
              </>
            ) : (
              <>
                <Timer className="text-accent mt-0.5 size-4 shrink-0" aria-hidden />
                <Link href="/app/productos" className="flex-1 hover:underline">
                  {t(`taskMock.${task.mock}`, { count: task.count })}
                </Link>
              </>
            )}
          </li>
        ))}
      </ul>
      <p className="text-muted-foreground text-xs">
        {t("covered", { covered: plan.covered, total: plan.totalTopics })}
      </p>
    </div>
  );
}

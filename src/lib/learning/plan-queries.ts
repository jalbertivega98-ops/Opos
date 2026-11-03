import "server-only";
import { createClient } from "@/lib/supabase/server";
import { buildWeekPlan, type PlanLevel, type TopicProgress } from "./plan";

export type PlanSettings = {
  examSlug: string;
  examName: string;
  examNameCa: string | null;
  level: PlanLevel;
  weeklyHours: number;
  targetDate: string | null;
};

/** Plan de la oposición principal del alumno actual, o null si no hay contenido. */
export async function getMyPlan() {
  const supabase = await createClient();
  const { data: target } = await supabase
    .from("user_exam_targets")
    .select(
      "level, weekly_hours, target_date, created_at, follow_only, exam:exam_bodies(slug, name, name_ca)",
    )
    .eq("is_primary", true)
    .maybeSingle<{
      level: PlanLevel | null;
      weekly_hours: number | null;
      target_date: string | null;
      created_at: string;
      follow_only: boolean;
      exam: { slug: string; name: string; name_ca: string | null } | null;
    }>();
  if (!target?.exam) return { reason: "noTarget" as const };
  const { data: rows } = await supabase.rpc("my_topic_progress", { p_exam_slug: target.exam.slug });
  const topics = (
    (rows ?? []) as {
      slug: string;
      title: string;
      answered: number;
      correct: number;
    }[]
  ).map((r) => ({ ...r, answered: Number(r.answered), correct: Number(r.correct) }));
  if (topics.length === 0) return { reason: "noContent" as const };

  const settings: PlanSettings = {
    examSlug: target.exam.slug,
    examName: target.exam.name,
    examNameCa: target.exam.name_ca,
    level: target.level ?? "beginner",
    weeklyHours: target.weekly_hours ?? 5,
    targetDate: target.target_date,
  };
  const progress: Record<string, TopicProgress> = Object.fromEntries(
    topics.map((t) => [t.slug, { answered: t.answered, correct: t.correct }]),
  );
  const plan = buildWeekPlan({
    weeklyHours: settings.weeklyHours,
    level: settings.level,
    today: new Date(),
    startedAt: new Date(target.created_at),
    examDate: settings.targetDate ? new Date(settings.targetDate) : null,
    topics: topics.map(({ slug, title }) => ({ slug, title })),
    progress,
  });
  return { reason: null, settings, plan, topics };
}

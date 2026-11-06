import "server-only";
import { createClient } from "@/lib/supabase/server";
import { buildWeekPlan, type PlanLevel, type TopicProgress } from "./plan";
import { examHasPsycho, examHasPsychoMock } from "@/lib/catalog/exam-format";
import { freeTopicSlugs } from "@/lib/store/queries";

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
  // Los temas gratis van primero: así el plan de un alumno gratis empieza por lo que puede hacer.
  const [freeTopics, openTopics, { data: notes }] = await Promise.all([
    freeTopicSlugs(settings.examSlug),
    myOpenTopics(settings.examSlug),
    supabase.rpc("exam_topic_notes", { p_exam_slug: settings.examSlug }),
  ]);
  // openTopics: temas que puede practicar ya (gratis, Premium o pack); noteTopics: con ficha publicada
  const noteTopics = ((notes ?? []) as { slug: string }[]).map((n) => n.slug);
  const rank = (slug: string) => {
    const i = freeTopics.indexOf(slug);
    return i === -1 ? freeTopics.length : i;
  };
  const ordered = [...topics].sort((a, b) => rank(a.slug) - rank(b.slug));
  const plan = buildWeekPlan({
    weeklyHours: settings.weeklyHours,
    level: settings.level,
    today: new Date(),
    startedAt: new Date(target.created_at),
    examDate: settings.targetDate ? new Date(settings.targetDate) : null,
    topics: ordered.map(({ slug, title }) => ({ slug, title })),
    progress,
    psycho: examHasPsycho(settings.examSlug),
    psychoMock: examHasPsychoMock(settings.examSlug),
  });
  return { reason: null, settings, plan, topics, freeTopics, openTopics, noteTopics };
}

/** Slug de la oposición principal del alumno actual (o null). */
export async function getPrimaryExamSlug() {
  const supabase = await createClient();
  const { data } = await supabase
    .from("user_exam_targets")
    .select("exam:exam_bodies(slug)")
    .eq("is_primary", true)
    .maybeSingle<{ exam: { slug: string } | null }>();
  return data?.exam?.slug ?? null;
}

/** Temas de la oposición que el alumno actual puede practicar ya (gratis, Premium o pack). */
export async function myOpenTopics(examSlug: string) {
  const supabase = await createClient();
  const { data } = await supabase.rpc("my_open_topics", { p_exam_slug: examSlug });
  // PostgREST devuelve un «setof text» como lista de cadenas
  return ((data ?? []) as unknown[]).map((r) =>
    typeof r === "string" ? r : String(Object.values(r as object)[0]),
  );
}

/**
 * Calendario de estudio (ADR-036). Puro: reparte lo que ha hecho el alumno por
 * días de la semana (lunes a domingo, hora peninsular) y mide cuánto lleva de
 * cada tarea del plan de esta semana.
 */
import type { PlanTask } from "./plan";

export const STUDY_TZ = "Europe/Madrid";

export type StudyEntry = {
  kind: "practice" | "mock";
  id: string;
  startedAt: string;
  finishedAt: string | null;
  status: string;
  mode: string;
  itemType: string | null;
  answered: number;
  correct: number;
  total: number;
  topicSlug: string | null;
  topicTitle: string | null;
  topicTitleCa: string | null;
  title: string | null;
  titleCa: string | null;
  mark: number | null;
  maxMark: number | null;
  passed: boolean | null;
  mockKind: "knowledge" | "psycho" | null;
};

export type CalendarDay = { key: string; date: Date; today: boolean; entries: StudyEntry[] };
export type TaskProgress = { done: number; target: number; state: "done" | "partial" | "pending" };

const DAY = 86_400_000;
const keyFmt = new Intl.DateTimeFormat("en-CA", {
  timeZone: STUDY_TZ,
  year: "numeric",
  month: "2-digit",
  day: "2-digit",
});

/** Día (AAAA-MM-DD) en hora peninsular. */
export function dayKey(d: Date) {
  return keyFmt.format(d);
}

/** Minutos que Madrid va por delante de UTC en ese instante. */
function tzOffset(at: number) {
  const p = Object.fromEntries(
    new Intl.DateTimeFormat("en-US", {
      timeZone: STUDY_TZ,
      hourCycle: "h23",
      year: "numeric",
      month: "numeric",
      day: "numeric",
      hour: "numeric",
      minute: "numeric",
    })
      .formatToParts(new Date(at))
      .map((x) => [x.type, Number(x.value)]),
  );
  return (Date.UTC(p.year, p.month - 1, p.day, p.hour, p.minute) - at) / 60_000;
}

/** Instante de las 00:00 en Madrid del día AAAA-MM-DD. */
function madridMidnight(key: string) {
  const [y, m, d] = key.split("-").map(Number);
  const guess = Date.UTC(y, m - 1, d);
  return new Date(guess - tzOffset(guess + 12 * 3_600_000) * 60_000);
}

/**
 * Semana de lunes a domingo que contiene `now`, desplazada `offset` semanas
 * (−1 = la anterior). Devuelve los instantes de inicio y fin y los 7 días.
 */
export function studyWeek(now: Date, offset = 0) {
  const todayKey = dayKey(now);
  const [y, m, d] = todayKey.split("-").map(Number);
  const noon = Date.UTC(y, m - 1, d, 12);
  const weekday = (new Date(noon).getUTCDay() + 6) % 7; // 0 = lunes
  const mondayNoon = noon - weekday * DAY + offset * 7 * DAY;
  const days = Array.from({ length: 7 }, (_, i) => {
    const date = new Date(mondayNoon + i * DAY);
    const key = date.toISOString().slice(0, 10);
    return { key, date, today: key === todayKey };
  });
  const start = madridMidnight(days[0].key);
  const end = madridMidnight(new Date(mondayNoon + 7 * DAY).toISOString().slice(0, 10));
  return { start, end, days };
}

/** Reparte las entradas por día (en orden de hora). */
export function groupByDay(
  days: { key: string; date: Date; today: boolean }[],
  entries: StudyEntry[],
): CalendarDay[] {
  const map = new Map<string, StudyEntry[]>(days.map((d) => [d.key, []]));
  for (const e of [...entries].sort((a, b) => a.startedAt.localeCompare(b.startedAt))) {
    map.get(dayKey(new Date(e.startedAt)))?.push(e);
  }
  return days.map((d) => ({ ...d, entries: map.get(d.key) ?? [] }));
}

/** Cuánto lleva el alumno de cada tarea del plan con lo hecho esta semana. */
export function taskProgress(task: PlanTask, entries: StudyEntry[]): TaskProgress {
  let done = 0;
  let target = 1;
  if (task.kind === "topic") {
    target = task.questions;
    done = entries
      .filter((e) => e.kind === "practice" && e.topicSlug === task.topic.slug)
      .reduce((n, e) => n + e.answered, 0);
  } else if (task.kind === "psycho") {
    target = task.sessions;
    done = entries.filter(
      (e) => e.kind === "practice" && e.mode === "psycho" && e.answered > 0,
    ).length;
  } else {
    target = task.count;
    done = entries.filter((e) => e.kind === "mock" && e.mockKind === task.mock).length;
  }
  done = Math.min(done, target);
  return { done, target, state: done >= target ? "done" : done > 0 ? "partial" : "pending" };
}

/** Fila de my_study_log → entrada del calendario. */
export function toStudyEntry(r: Record<string, unknown>): StudyEntry {
  const num = (v: unknown) => (v === null || v === undefined ? null : Number(v));
  const str = (v: unknown) => (typeof v === "string" ? v : null);
  return {
    kind: r.kind === "mock" ? "mock" : "practice",
    id: String(r.id),
    startedAt: String(r.started_at),
    finishedAt: str(r.finished_at),
    status: String(r.status),
    mode: String(r.mode),
    itemType: str(r.item_type),
    answered: Number(r.answered ?? 0),
    correct: Number(r.correct ?? 0),
    total: Number(r.total ?? 0),
    topicSlug: str(r.topic_slug),
    topicTitle: str(r.topic_title),
    topicTitleCa: str(r.topic_title_ca),
    title: str(r.title),
    titleCa: str(r.title_ca),
    mark: num(r.mark),
    maxMark: num(r.max_mark),
    passed: typeof r.passed === "boolean" ? r.passed : null,
    mockKind:
      r.mock_kind === "psycho" ? "psycho" : r.mock_kind === "knowledge" ? "knowledge" : null,
  };
}

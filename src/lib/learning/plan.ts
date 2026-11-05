/**
 * Plan de estudio semanal (USR-004). Puro y determinista: con las horas, el
 * nivel, la fecha objetivo y el progreso real por tema calcula en qué semana
 * está el alumno y qué toca esta semana. No inventa contenido: solo reparte
 * los temas que tienen preguntas publicadas.
 */

export type PlanLevel = "beginner" | "intermediate" | "advanced";
export type PlanTopic = { slug: string; title: string };
export type TopicProgress = { answered: number; correct: number };

export type PlanInput = {
  weeklyHours: number;
  level: PlanLevel;
  today: Date;
  startedAt: Date;
  examDate: Date | null;
  topics: PlanTopic[];
  progress: Record<string, TopicProgress>;
  /** false si la oposición no tiene prueba psicotécnica: ese tiempo pasa al temario. */
  psycho?: boolean;
};

export type PlanPhase = "syllabus" | "review" | "mocks";

export type PlanTask =
  | { kind: "topic"; topic: PlanTopic; questions: number; status: "new" | "weak" }
  | { kind: "psycho"; sessions: number }
  | { kind: "mock"; mock: "knowledge" | "psycho"; count: number };

export type WeekPlan = {
  week: number;
  totalWeeks: number;
  phase: PlanPhase;
  minutes: { syllabus: number; psycho: number; mocks: number };
  tasks: PlanTask[];
  covered: number;
  totalTopics: number;
};

const DAY = 86_400_000;
const DEFAULT_WEEKS = 16;
/** Un tema se da por trabajado con 15 respuestas y al menos un 70 % de aciertos. */
export const TOPIC_DONE = { answered: 15, accuracy: 0.7 };
const MIN_PER_QUESTION = 1.5; // practicar y leer la explicación
const MIN_PER_PSYCHO_SESSION = 15;
const MOCK_MINUTES = 45; // 35 min de examen + revisar la corrección

/** Fase de la semana: temario, repaso de puntos débiles y simulacros al final. */
export function phaseFor(week: number, totalWeeks: number, level: PlanLevel): PlanPhase {
  const syllabusShare = level === "beginner" ? 0.7 : level === "intermediate" ? 0.6 : 0.5;
  // las 2 últimas semanas (o el 15 % final si es más) son de simulacros
  const mockWeeks = Math.max(2, Math.round(totalWeeks * 0.15));
  if (week > totalWeeks - mockWeeks) return "mocks";
  if (week <= Math.max(1, Math.round(totalWeeks * syllabusShare))) return "syllabus";
  return "review";
}

const SPLIT: Record<PlanPhase, [number, number, number]> = {
  syllabus: [0.6, 0.3, 0.1],
  review: [0.5, 0.3, 0.2],
  mocks: [0.3, 0.3, 0.4],
};

const isDone = (p?: TopicProgress) =>
  !!p && p.answered >= TOPIC_DONE.answered && p.correct / p.answered >= TOPIC_DONE.accuracy;

export function buildWeekPlan(input: PlanInput): WeekPlan {
  const { topics, progress, level } = input;
  const elapsedWeeks = Math.max(
    0,
    Math.floor((input.today.getTime() - input.startedAt.getTime()) / (7 * DAY)),
  );
  const weeksLeft = input.examDate
    ? Math.max(1, Math.ceil((input.examDate.getTime() - input.today.getTime()) / (7 * DAY)))
    : null;
  const totalWeeks = Math.min(
    104,
    weeksLeft !== null ? elapsedWeeks + weeksLeft : Math.max(DEFAULT_WEEKS, elapsedWeeks + 1),
  );
  const week = Math.min(totalWeeks, elapsedWeeks + 1);
  const phase = phaseFor(week, totalWeeks, level);

  const total = Math.max(60, Math.min(80, input.weeklyHours) * 60);
  const hasPsycho = input.psycho !== false;
  const [a, b, c] = SPLIT[phase];
  const minutes = {
    syllabus: Math.round(total * (hasPsycho ? a : a + b)),
    psycho: hasPsycho ? Math.round(total * b) : 0,
    mocks: Math.round(total * c),
  };

  // sin simulacro esta semana (fase de temario corta): ese tiempo va al temario
  const mocks = Math.max(phase === "syllabus" ? 0 : 1, Math.floor(minutes.mocks / MOCK_MINUTES));
  if (mocks === 0) {
    minutes.syllabus += minutes.mocks;
    minutes.mocks = 0;
  }

  const covered = topics.filter((t) => isDone(progress[t.slug])).length;
  const pending = topics.filter((t) => !isDone(progress[t.slug]));
  // en temario primero lo no empezado; en repaso, lo más flojo primero
  const ordered =
    phase === "syllabus"
      ? pending
      : [...pending].sort((x, y) => accuracy(progress[x.slug]) - accuracy(progress[y.slug]));
  const syllabusWeeksLeft = Math.max(
    1,
    countWeeks(week, totalWeeks, level, phase === "syllabus" ? "syllabus" : "review"),
  );
  const perWeek = Math.max(1, Math.ceil(pending.length / syllabusWeeksLeft));
  const chosen = ordered.slice(0, Math.min(perWeek, 6));
  const qPerTopic = chosen.length
    ? Math.max(10, Math.round(minutes.syllabus / MIN_PER_QUESTION / chosen.length / 5) * 5)
    : 0;

  const tasks: PlanTask[] = chosen.map((topic) => ({
    kind: "topic",
    topic,
    questions: Math.min(qPerTopic, 40),
    status: progress[topic.slug]?.answered ? "weak" : "new",
  }));
  if (hasPsycho)
    tasks.push({
      kind: "psycho",
      sessions: Math.max(1, Math.round(minutes.psycho / MIN_PER_PSYCHO_SESSION)),
    });
  if (mocks > 0 && hasPsycho) {
    tasks.push({ kind: "mock", mock: "knowledge", count: Math.ceil(mocks / 2) });
    tasks.push({ kind: "mock", mock: "psycho", count: Math.floor(mocks / 2) || 1 });
  } else if (mocks > 0) {
    tasks.push({ kind: "mock", mock: "knowledge", count: mocks });
  }
  return { week, totalWeeks, phase, minutes, tasks, covered, totalTopics: topics.length };
}

/** En repaso van primero los temas flojos ya empezados y después los no empezados. */
function accuracy(p?: TopicProgress) {
  return p && p.answered ? p.correct / p.answered : 1.5;
}

function countWeeks(from: number, total: number, level: PlanLevel, phase: PlanPhase) {
  let n = 0;
  for (let w = from; w <= total; w++) if (phaseFor(w, total, level) === phase) n++;
  return n;
}

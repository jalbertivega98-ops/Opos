import type { PlanTask } from "@/lib/learning/plan";

/** Pack de intentos de simulacro (bundle con config.attempts, ADR-035). */
export function isAttemptsPack(p: { type: string; config?: unknown }) {
  const c = p.config as { attempts?: unknown } | null | undefined;
  return p.type === "bundle" && typeof c?.attempts === "number";
}

type PlanLibraryItem = {
  type: string;
  source: string;
  is_test: boolean;
  attempts_left: number | null;
};

/**
 * Qué partes del plan puede abrir el alumno con lo que tiene (packs de preguntas y
 * simulacros reales, no de prueba). Los temas gratis se abren siempre. Lo que no,
 * se muestra con candado «Premium».
 */
export function planAccess(items: PlanLibraryItem[], freeTopics: string[] = []) {
  const real = items.filter((i) => !i.is_test && i.source !== "free");
  return {
    topics: real.some(
      (i) => i.type === "question_pack" || (i.type === "bundle" && i.attempts_left === null),
    ),
    mocks: real.some(
      (i) => i.type === "mock_exam" || (i.type === "bundle" && (i.attempts_left ?? 1) > 0),
    ),
    freeTopics,
  };
}
export type PlanAccess = ReturnType<typeof planAccess>;

/** ¿Puede el alumno hacer esta tarea con lo que tiene? Los psicotécnicos y los temas gratis lo son. */
export function taskUnlocked(task: PlanTask, access: PlanAccess) {
  if (task.kind === "psycho") return true;
  if (task.kind === "topic") return access.topics || access.freeTopics.includes(task.topic.slug);
  return access.mocks;
}

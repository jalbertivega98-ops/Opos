import type { PlanTask } from "@/lib/learning/plan";

/** Pack de intentos de simulacro (bundle con config.attempts, ADR-035). */
export function isAttemptsPack(p: { type: string; config?: unknown }) {
  const c = p.config as { attempts?: unknown } | null | undefined;
  return p.type === "bundle" && typeof c?.attempts === "number";
}

type PlanLibraryItem = {
  product_id?: string;
  slug?: string;
  type: string;
  source: string;
  is_test: boolean;
  attempts_left: number | null;
};

type MockKind = "knowledge" | "psycho";

/** Los packs de 10 simulacros de psicotécnicos acaban en «-10-psicotecnicos» (ADR-035). */
const isPsychoPack = (slug?: string) => !!slug && slug.endsWith("-10-psicotecnicos");

/**
 * Qué partes del plan puede abrir el alumno con lo que tiene (packs de preguntas y
 * simulacros reales, no de prueba). Los temas gratis se abren siempre. Lo que no,
 * se muestra con candado. Los simulacros se separan por tipo: el pack de psicotécnicos
 * no abre el de conocimientos ni al revés. `mockKinds` dice el tipo (config.kind) de
 * cada simulacro de la biblioteca; sin él, un simulacro cuenta como de conocimientos.
 */
export function planAccess(
  items: PlanLibraryItem[],
  freeTopics: string[] = [],
  mockKinds: Map<string, string | undefined> = new Map(),
) {
  const real = items.filter((i) => !i.is_test && i.source !== "free");
  const mocks: Record<MockKind, boolean> = { knowledge: false, psycho: false };
  for (const i of real) {
    if (i.type === "mock_exam") {
      mocks[mockKinds.get(i.product_id ?? "") === "psycho" ? "psycho" : "knowledge"] = true;
    } else if (i.type === "bundle" && i.attempts_left === null) {
      // Premium o pack completo: todos los simulacros
      mocks.knowledge = true;
      mocks.psycho = true;
    } else if (i.type === "bundle" && (i.attempts_left ?? 0) > 0) {
      mocks[isPsychoPack(i.slug) ? "psycho" : "knowledge"] = true;
    }
  }
  return {
    topics: real.some(
      (i) => i.type === "question_pack" || (i.type === "bundle" && i.attempts_left === null),
    ),
    mocks,
    freeTopics,
  };
}
export type PlanAccess = ReturnType<typeof planAccess>;

/** ¿Puede el alumno hacer esta tarea con lo que tiene? Los psicotécnicos y los temas gratis lo son. */
export function taskUnlocked(task: PlanTask, access: PlanAccess) {
  if (task.kind === "psycho") return true;
  if (task.kind === "topic") return access.topics || access.freeTopics.includes(task.topic.slug);
  return access.mocks[task.mock];
}

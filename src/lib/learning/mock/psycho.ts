import {
  availableTypes,
  difficultyPlan,
  GENERAL_TYPES,
  generateItem,
} from "@/lib/learning/psycho/registry";
import { toPublicItem, type PsychoType } from "@/lib/learning/psycho/types";

type Slot = PsychoType;

/**
 * Orden de los tipos de un simulacro según `config.item_types` del producto:
 *  - lista ["series", "numeric", …]: reparto por igual, mezclados;
 *  - objeto {"percentages": 5, "tables": 12, …}: cuántos de cada tipo, en
 *    bloques (como el cuadernillo real de la AGE, que agrupa las preguntas por
 *    tipo y deja las tablas al final). Los bloques siguen el orden del registro
 *    de generadores, no el del objeto: jsonb no conserva el orden de las claves.
 *    Si las cantidades no suman `count`, se reparten en proporción.
 *  - cualquier otra cosa: los 7 tipos generales por igual.
 */
export function psychoSlots(count: number, itemTypes?: unknown): Slot[] {
  const all = availableTypes();
  if (itemTypes && typeof itemTypes === "object" && !Array.isArray(itemTypes)) {
    const mix = Object.entries(itemTypes as Record<string, unknown>)
      .filter(
        (e): e is [PsychoType, number] =>
          all.includes(e[0] as PsychoType) &&
          typeof e[1] === "number" &&
          Number.isInteger(e[1]) &&
          e[1] > 0,
      )
      .sort((a, b) => all.indexOf(a[0]) - all.indexOf(b[0]));
    const total = mix.reduce((a, [, n]) => a + n, 0);
    if (total > 0) {
      // reparto proporcional con el método del resto mayor
      const exact = mix.map(([t, n]) => [t, (n * count) / total] as const);
      const counts = exact.map(([t, x]) => [t, Math.floor(x)] as [PsychoType, number]);
      let left = count - counts.reduce((a, [, n]) => a + n, 0);
      const order = exact
        .map(([, x], i) => [i, x - Math.floor(x)] as const)
        .sort((a, b) => b[1] - a[1]);
      for (const [i] of order) {
        if (left <= 0) break;
        counts[i][1] += 1;
        left -= 1;
      }
      return counts.flatMap(([t, n]) => Array.from({ length: n }, () => t));
    }
  }
  const wanted = Array.isArray(itemTypes) ? all.filter((t) => itemTypes.includes(t)) : [];
  const types = wanted.length > 0 ? wanted : GENERAL_TYPES;
  return Array.from({ length: count }, (_, i) => types[i % types.length]);
}

/**
 * Ítems de un simulacro de psicotécnicos con dificultad creciente (dentro de
 * cada bloque si el producto fija cantidades por tipo). La solución va aparte
 * (answer_index) y la base de datos la guarda en una tabla que el alumno no
 * puede leer.
 */
export function buildPsychoMock(count: number, nextSeed: () => number, itemTypes?: unknown) {
  const slots = psychoSlots(count, itemTypes);
  const blocks = new Map<PsychoType, number>();
  for (const t of slots) blocks.set(t, (blocks.get(t) ?? 0) + 1);
  const grouped = itemTypes && typeof itemTypes === "object" && !Array.isArray(itemTypes);
  const seen = new Map<PsychoType, number>();
  const global = difficultyPlan(count);
  return slots.map((type, i) => {
    const k = seen.get(type) ?? 0;
    seen.set(type, k + 1);
    const difficulty = grouped ? difficultyPlan(blocks.get(type)!)[k] : global[i];
    const item = generateItem(type, nextSeed(), difficulty);
    const pub = toPublicItem(item);
    return {
      item_type: item.type,
      difficulty: item.difficulty,
      seed: item.seed,
      generator_version: item.version,
      presented: { presentation: pub.presentation, options: pub.options },
      answer_index: item.answerIndex,
      explanation: item.explanation,
    };
  });
}

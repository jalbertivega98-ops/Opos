import { availableTypes, difficultyPlan, generateItem } from "@/lib/learning/psycho/registry";
import { toPublicItem } from "@/lib/learning/psycho/types";

/**
 * Ítems de un simulacro de psicotécnicos: reparte los tipos disponibles por
 * igual (series, letras, numérico, analogías, matrices, espacial, atención)
 * con dificultad creciente mezclada. La solución va aparte (answer_index) y la
 * base de datos la guarda en una tabla que el alumno no puede leer.
 */
export function buildPsychoMock(count: number, nextSeed: () => number) {
  const types = availableTypes();
  const plan = difficultyPlan(count);
  return plan.map((difficulty, i) => {
    const item = generateItem(types[i % types.length], nextSeed(), difficulty);
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

import { describe, expect, it } from "vitest";
import {
  availableTypes,
  difficultyPlan,
  generateItem,
  getGenerator,
} from "@/lib/learning/psycho/registry";
import {
  canonical,
  samePresentation,
  toPublicItem,
  type Difficulty,
} from "@/lib/learning/psycho/types";

describe("registro de generadores", () => {
  it("todos los generadores son deterministas y verificables en todas las dificultades", () => {
    for (const type of availableTypes()) {
      const g = getGenerator(type)!;
      for (const d of [1, 2, 3, 4, 5] as Difficulty[]) {
        for (let seed = 0; seed < 300; seed++) {
          const a = g.generate(seed * 7919 + d, d);
          const b = g.generate(seed * 7919 + d, d);
          expect(canonical(a)).toBe(canonical(b));
          const v = g.verify(a);
          if (!v.ok) throw new Error(`${type} d=${d} seed=${a.seed}: ${v.reason}`);
        }
      }
    }
  });

  it("la vista pública no contiene la solución", () => {
    const pub = toPublicItem(generateItem("series", 42, 3));
    expect(pub).not.toHaveProperty("answerIndex");
    expect(pub).not.toHaveProperty("explanation");
  });

  it("samePresentation ignora el orden de claves (jsonb)", () => {
    const item = generateItem("series", 7, 2);
    const reordered = JSON.parse(
      JSON.stringify({ options: item.options, presentation: item.presentation }),
    );
    expect(samePresentation(item, reordered)).toBe(true);
    expect(samePresentation(item, { ...reordered, options: [...item.options].reverse() })).toBe(
      false,
    );
  });

  it("plan de dificultad progresivo de 1 a 5", () => {
    expect(difficultyPlan(10)).toEqual([1, 1, 2, 2, 3, 3, 4, 4, 5, 5]);
    expect(difficultyPlan(5)).toEqual([1, 2, 3, 4, 5]);
    expect(difficultyPlan(3, 4)).toEqual([4, 4, 4]);
  });
});

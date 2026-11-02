import { describe, expect, it } from "vitest";
import {
  fittingRules,
  generateSeries,
  nextTerm,
  termsOf,
  toPublic,
  verifySeries,
  type Difficulty,
} from "@/lib/learning/psycho/series";

describe("termsOf", () => {
  it("calcula las reglas básicas", () => {
    expect(termsOf({ kind: "arithmetic", start: 2, step: 3 }, 4)).toEqual([2, 5, 8, 11]);
    expect(termsOf({ kind: "geometric", start: 3, ratio: 2 }, 4)).toEqual([3, 6, 12, 24]);
    expect(termsOf({ kind: "alternating", start: 10, stepA: 5, stepB: -2 }, 5)).toEqual([
      10, 15, 13, 18, 16,
    ]);
    expect(termsOf({ kind: "second_order", start: 1, step: 1, delta: 1 }, 5)).toEqual([
      1, 2, 4, 7, 11,
    ]);
    expect(termsOf({ kind: "fibonacci", a: 1, b: 2 }, 5)).toEqual([1, 2, 3, 5, 8]);
    expect(termsOf({ kind: "interleaved", startA: 1, stepA: 2, startB: 50, stepB: -5 }, 5)).toEqual(
      [1, 50, 3, 45, 5],
    );
  });
});

describe("generateSeries", () => {
  it("es determinista", () => {
    expect(generateSeries(42, 3)).toEqual(generateSeries(42, 3));
    expect(generateSeries(42, 3)).not.toEqual(generateSeries(43, 3));
  });

  it.each([1, 2, 3, 4, 5] as Difficulty[])(
    "1.000 semillas generan ítems verificados sin ambigüedad (dificultad %i)",
    (d) => {
      for (let seed = 0; seed < 1000; seed++) {
        const item = generateSeries(seed, d);
        const v = verifySeries(item);
        expect(v, `seed ${seed}: ${v.reason}`).toEqual({ ok: true });
        expect(item.options).toHaveLength(4);
      }
    },
  );

  it("la vista pública no expone la respuesta ni la regla", () => {
    const pub = toPublic(generateSeries(7, 4)) as Record<string, unknown>;
    expect(pub).not.toHaveProperty("answerIndex");
    expect(pub).not.toHaveProperty("rule");
  });
});

describe("verifySeries", () => {
  it("detecta respuesta incorrecta, opciones duplicadas y ambigüedad", () => {
    const item = generateSeries(1, 2);
    expect(verifySeries({ ...item, answerIndex: (item.answerIndex + 1) % 4 }).ok).toBe(false);
    expect(
      verifySeries({
        ...item,
        options: [item.options[0], item.options[0], item.options[2], item.options[3]],
      }).ok,
    ).toBe(false);
    // 1,2,4 encaja con geométrica (→8) y segundo orden (→7): si ambas son opciones, es ambiguo
    const ambiguous = {
      ...item,
      terms: [1, 2, 4],
      rule: { kind: "geometric", start: 1, ratio: 2 } as const,
      options: [8, 7, 9, 10],
      answerIndex: 0,
    };
    expect(fittingRules([1, 2, 4]).length).toBeGreaterThan(1);
    expect(verifySeries(ambiguous)).toEqual({ ok: false, reason: "ambiguous" });
    expect(nextTerm({ kind: "fibonacci", a: 1, b: 1 }, 6)).toBe(13);
  });
});

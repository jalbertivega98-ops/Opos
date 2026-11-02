import { describe, expect, it } from "vitest";
import { createTranslator } from "next-intl";
import es from "../../messages/es.json";
import ca from "../../messages/ca.json";
import { ALL_WORDS, RELATIONS, verifyAnalogy } from "@/lib/learning/psycho/analogies";
import { ALPHABET, verifyLetters } from "@/lib/learning/psycho/letters";
import { predictions, verifyMatrix } from "@/lib/learning/psycho/matrices";
import { solveNumeric } from "@/lib/learning/psycho/numeric";
import { isUsable, mirror, rotations, toToken, verifySpatial } from "@/lib/learning/psycho/spatial";
import { solveAttention } from "@/lib/learning/psycho/attention";
import { availableTypes, generateItem, getGenerator } from "@/lib/learning/psycho/registry";
import type { Difficulty, PsychoItem, PsychoType } from "@/lib/learning/psycho/types";

const DIFFS = [1, 2, 3, 4, 5] as Difficulty[];
const sample = (type: PsychoType, n = 60) =>
  DIFFS.flatMap((d) => Array.from({ length: n }, (_, i) => generateItem(type, i * 104729 + d, d)));

describe("todos los generadores", () => {
  it("están registrados los 7 tipos pedidos", () => {
    expect(availableTypes()).toEqual([
      "series",
      "letters",
      "numeric",
      "analogies",
      "matrices",
      "spatial",
      "attention",
    ]);
  });

  it("detectan una solución manipulada (respuesta incorrecta)", () => {
    for (const type of availableTypes()) {
      const g = getGenerator(type)!;
      for (const item of sample(type, 20)) {
        const wrong: PsychoItem = {
          ...item,
          answerIndex: (item.answerIndex + 1) % item.options.length,
        };
        expect(g.verify(wrong).ok, `${type} seed=${item.seed}`).toBe(false);
      }
    }
  });

  it("detectan opciones duplicadas", () => {
    for (const type of availableTypes()) {
      const item = generateItem(type, 99, 3);
      const other = item.options.findIndex((_, i) => i !== item.answerIndex);
      const dup = {
        ...item,
        options: item.options.map((o, i) => (i === other ? item.options[item.answerIndex] : o)),
      };
      expect(getGenerator(type)!.verify(dup).ok, type).toBe(false);
    }
  });

  it("reparten la respuesta correcta entre las posiciones", () => {
    for (const type of availableTypes()) {
      const items = sample(type, 100);
      const counts = new Map<number, number>();
      for (const it of items) counts.set(it.answerIndex, (counts.get(it.answerIndex) ?? 0) + 1);
      for (const [pos, c] of counts) {
        if (pos > 3) continue; // posiciones 5-6 solo existen en algunos ítems
        expect(c / items.length, `${type} posición ${pos}`).toBeGreaterThan(0.1);
      }
    }
  });

  it("todos los textos existen y se formatean en castellano y catalán", () => {
    for (const [locale, messages] of [
      ["es", es],
      ["ca", ca],
    ] as const) {
      const t = createTranslator({ locale, messages, namespace: "psycho" }) as unknown as (
        key: string,
        values?: Record<string, string | number>,
      ) => string;
      for (const type of availableTypes()) {
        expect(t(`types.${type}.name`)).not.toMatch(/psycho\./);
        for (const item of sample(type, 10)) {
          const p = item.presentation;
          if (p.kind === "text" || p.kind === "grid")
            expect(t(`problems.${p.key}`, p.values)).not.toMatch(/\{/);
          if (p.kind === "figure") expect(t(`figures.${p.key}`)).toBeTruthy();
          const text = t(`rules.${item.explanation.key}`, item.explanation.values);
          expect(text, `${locale} ${item.explanation.key}`).not.toMatch(/\{|psycho\./);
        }
      }
    }
  });
});

describe("series de letras", () => {
  it("usa el alfabeto español de 27 letras con Ñ", () => {
    expect(ALPHABET).toHaveLength(27);
    expect(ALPHABET.indexOf("Ñ")).toBe(ALPHABET.indexOf("N") + 1);
  });

  it("explica la Ñ cuando la serie la atraviesa", () => {
    const items = sample("letters", 80);
    const crossing = items.filter((i) => i.explanation.key.endsWith("_n"));
    expect(crossing.length).toBeGreaterThan(0);
  });

  it("rechaza una serie con dos lecturas posibles entre las opciones", () => {
    // A C E G … admite +2; si añadimos la letra de otra regla como opción correcta, falla
    const item: PsychoItem = {
      type: "letters",
      seed: 0,
      difficulty: 1,
      version: 1,
      presentation: { kind: "sequence", terms: ["A", "C", "E", "G", "I", "K"] },
      options: ["M", "L", "N", "Ñ"],
      answerIndex: 0,
      explanation: { key: "letters_arithmetic" },
    };
    expect(verifyLetters(item).ok).toBe(true);
    expect(verifyLetters({ ...item, answerIndex: 1 }).ok).toBe(false);
  });
});

describe("razonamiento numérico", () => {
  it("todas las soluciones son enteras y se recalculan desde los parámetros", () => {
    for (const item of sample("numeric", 80)) {
      if (item.presentation.kind !== "text") throw new Error("kind");
      const template = item.presentation.key.replace("numeric_", "") as Parameters<
        typeof solveNumeric
      >[0];
      const answer = solveNumeric(template, item.presentation.values as Record<string, number>);
      expect(Number.isInteger(answer)).toBe(true);
      expect(item.options[item.answerIndex]).toBe(String(answer));
    }
  });

  it("casos conocidos", () => {
    expect(solveNumeric("percent", { p: 25, n: 80 })).toBe(20);
    expect(solveNumeric("discount", { price: 200, d: 15 })).toBe(170);
    expect(solveNumeric("inverse", { w: 6, t: 4, w2: 3 })).toBe(8);
    expect(solveNumeric("average", { k: 3, m: 10, x: 14 })).toBe(11);
    expect(solveNumeric("mixture", { q1: 1, p1: 4, q2: 3, p2: 8 })).toBe(7);
  });
});

describe("analogías", () => {
  it("cada palabra tiene traducción en castellano y catalán", () => {
    for (const w of ALL_WORDS) {
      expect(es.psycho.words, w).toHaveProperty(w);
      expect(ca.psycho.words, w).toHaveProperty(w);
    }
  });

  it("ningún par aparece en dos relaciones", () => {
    const seen = new Map<string, string>();
    for (const [rel, pairs] of Object.entries(RELATIONS))
      for (const [a, b] of pairs) {
        const k = [a, b].sort().join("|");
        expect(seen.get(k), `${k} en ${rel} y ${seen.get(k)}`).toBeUndefined();
        seen.set(k, rel);
      }
  });

  it("rechaza relación distinta, palabras repetidas o respuesta equivocada", () => {
    const base: PsychoItem = {
      type: "analogies",
      seed: 0,
      difficulty: 1,
      version: 1,
      presentation: { kind: "analogy", a: "w:vaca", b: "w:ternero", c: "w:oveja" },
      options: ["w:cordero", "w:potro", "w:cachorro", "w:pollito"],
      answerIndex: 0,
      explanation: { key: "analogy_young" },
    };
    expect(verifyAnalogy(base).ok).toBe(true);
    expect(
      verifyAnalogy({
        ...base,
        presentation: { kind: "analogy", a: "w:vaca", b: "w:cordero", c: "w:oveja" },
      }).ok,
    ).toBe(false);
    expect(
      verifyAnalogy({ ...base, options: ["w:cordero", "w:potro", "w:oveja", "w:pollito"] }).ok,
    ).toBe(false);
    expect(verifyAnalogy({ ...base, answerIndex: 1 }).ok).toBe(false);
  });
});

describe("matrices", () => {
  it("predice valores por regla y detecta ambigüedad", () => {
    // por columnas
    expect([...predictions([1, 2, 3, 1, 2, 3, 1, 2, null])]).toEqual([3]);
    // cuadrado latino
    expect([...predictions(["a", "b", "c", "b", "c", "a", "c", "a", null])]).toEqual(["b"]);
    // constante
    expect([...predictions(["x", "x", "x", "x", "x", "x", "x", "x", null])]).toEqual(["x"]);
  });

  it("rechaza una matriz cuya respuesta no sigue las reglas", () => {
    const item = generateItem("matrices", 11, 4);
    if (item.presentation.kind !== "matrix") throw new Error("kind");
    const cells = [...item.presentation.cells];
    cells[0] = cells[0]!.replace(/:(\d):/, (_, n) => `:${(Number(n) % 3) + 1}:`);
    expect(verifyMatrix({ ...item, presentation: { ...item.presentation, cells } }).ok).toBe(false);
  });
});

describe("razonamiento espacial", () => {
  const I: [number, number][] = [
    [0, 0],
    [0, 1],
    [0, 2],
    [0, 3],
  ];
  const T: [number, number][] = [
    [0, 0],
    [1, 0],
    [2, 0],
    [1, 1],
  ];
  const L: [number, number][] = [
    [0, 0],
    [0, 1],
    [0, 2],
    [1, 2],
  ];

  it("solo usa piezas quirales y sin simetría de giro", () => {
    expect(isUsable(I)).toBe(false);
    expect(isUsable(T)).toBe(false); // simétrica en espejo
    expect(isUsable(L)).toBe(true);
  });

  it("rechaza ítems con dos giros válidos o un espejo marcado como correcto", () => {
    const item = generateItem("spatial", 3, 2);
    if (item.presentation.kind !== "figure") throw new Error("kind");
    const mirrorIdx = item.options.findIndex((_, i) => i !== item.answerIndex);
    expect(verifySpatial({ ...item, answerIndex: mirrorIdx }).ok).toBe(false);
    const rots = rotations(L).map(toToken);
    const twoCorrect: PsychoItem = {
      ...item,
      presentation: { kind: "figure", key: "rotation", figure: rots[0] },
      options: [rots[1], rots[2], toToken(mirror(L)), toToken(rotations(mirror(L))[1])],
      answerIndex: 0,
    };
    expect(verifySpatial(twoCorrect).ok).toBe(false);
  });
});

describe("atención", () => {
  it("cuenta símbolos y parejas idénticas", () => {
    expect(
      solveAttention({
        kind: "grid",
        key: "attention_count",
        values: { target: "b" },
        rows: ["bdbp", "qqbb"],
      }),
    ).toBe(4);
    expect(
      solveAttention({ kind: "grid", key: "attention_pairs", rows: ["123 · 123", "123 · 132"] }),
    ).toBe(1);
  });
});

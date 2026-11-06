import { describe, expect, it } from "vitest";
import {
  BANK,
  answersFor,
  related,
  spelling,
  synonyms,
  antonyms,
  verifyRelation,
} from "@/lib/learning/psycho/verbal";
import { SPELLING_PAIRS } from "@/lib/learning/psycho/verbal-bank";
import type { Difficulty, PsychoItem } from "@/lib/learning/psycho/types";

const DIFFS = [1, 2, 3, 4, 5] as Difficulty[];
const sample = (g: typeof synonyms, n = 200) =>
  DIFFS.flatMap((d) => Array.from({ length: n }, (_, i) => g.generate(i * 7919 + d, d)));

describe("banco verbal (DLE)", () => {
  it("tiene las 171 entradas y los 70 pares comprobados", () => {
    expect(BANK).toHaveLength(171);
    expect(SPELLING_PAIRS).toHaveLength(70);
    expect(new Set(SPELLING_PAIRS.flat()).size).toBe(140);
  });

  it("no usa palabras de los exámenes reales del INAP", () => {
    const real = [
      "terso",
      "erial",
      "ventura",
      "deslavazado",
      "hereje",
      "perspicaz",
      "fútil",
      "lapso",
      "embuste",
      "nulidad",
      "exuberante",
      "lívido",
      "idiosincrasia",
      "leitmotiv",
    ];
    const heads = BANK.map((e) => e.word);
    for (const w of real) expect(heads).not.toContain(w);
    for (const w of real) expect(SPELLING_PAIRS.flat()).not.toContain(w);
  });

  it("casos conocidos del DLE", () => {
    expect(answersFor("efímero", "synonyms", 1)).toEqual(["pasajero", "fugaz"]);
    expect(answersFor("efímero", "antonyms", 1)).toContain("duradero");
    expect(related("efímero", "fugaz")).toBe(true);
    expect(related("efímero", "eterno")).toBe(true);
    expect(related("efímero", "tacaño")).toBe(false);
  });
});

describe.each([
  ["synonyms", synonyms],
  ["antonyms", antonyms],
] as const)("%s", (mode, g) => {
  const items = sample(g);

  it("la respuesta está en la lista del DLE y ninguna otra opción lo está", () => {
    for (const it of items) {
      expect(g.verify(it).ok, `seed=${it.seed}`).toBe(true);
      const word = String(it.presentation.kind === "text" && it.presentation.values?.word);
      const entry = BANK.find((e) => e.word === word)!;
      const good = mode === "synonyms" ? entry.syn : entry.ant;
      expect(good).toContain(it.options[it.answerIndex]);
      for (const [i, o] of it.options.entries())
        if (i !== it.answerIndex) expect(good).not.toContain(o);
    }
  });

  it("los distractores sin relación no son sinónimos ni antónimos de la palabra", () => {
    for (const it of items) {
      const word = String(it.presentation.kind === "text" && it.presentation.values?.word);
      const entry = BANK.find((e) => e.word === word)!;
      const opposite = mode === "synonyms" ? entry.ant : entry.syn;
      for (const [i, o] of it.options.entries()) {
        if (i === it.answerIndex || opposite.includes(o)) continue;
        expect(related(word, o), `${word} / ${o}`).toBe(false);
      }
    }
  });

  it("detecta una opción ambigua", () => {
    const it = items[0];
    const word = String(it.presentation.kind === "text" && it.presentation.values?.word);
    const entry = BANK.find((e) => e.word === word)!;
    const good = mode === "synonyms" ? entry.syn : entry.ant;
    const extra = good.find((w) => !it.options.includes(w))!;
    const other = (it.answerIndex + 1) % 4;
    const bad: PsychoItem = { ...it, options: it.options.map((o, i) => (i === other ? extra : o)) };
    expect(verifyRelation(bad).ok).toBe(false);
  });

  it("es determinista y variado", () => {
    expect(g.generate(42, 3)).toEqual(g.generate(42, 3));
    const words = new Set(
      items.map((i) => i.presentation.kind === "text" && i.presentation.values?.word),
    );
    expect(words.size).toBeGreaterThan(80);
  });
});

describe("ortografía", () => {
  const items = DIFFS.flatMap((d) =>
    Array.from({ length: 200 }, (_, i) => spelling.generate(i * 31 + d, d)),
  );
  const wrong = new Set(SPELLING_PAIRS.map(([, b]) => b));
  const ok = new Set(SPELLING_PAIRS.map(([a]) => a));

  it("una forma errónea y tres correctas", () => {
    for (const it of items) {
      expect(spelling.verify(it).ok).toBe(true);
      expect(wrong.has(it.options[it.answerIndex])).toBe(true);
      expect(it.options.filter((o) => ok.has(o))).toHaveLength(3);
    }
  });

  it("rechaza una opción correcta marcada como errónea", () => {
    const it = items[5];
    expect(spelling.verify({ ...it, answerIndex: (it.answerIndex + 1) % 4 }).ok).toBe(false);
  });
});

describe("simulacro de la AGE con el bloque verbal", () => {
  it("reparte 30 como el examen real y pone el bloque verbal antes de los numéricos", async () => {
    const { psychoSlots } = await import("@/lib/learning/mock/psycho");
    const mix = {
      tables: 12,
      codes: 1,
      probability: 1,
      equations: 2,
      series: 2,
      percentages: 3,
      antonyms: 3,
      synonyms: 3,
      spelling: 3,
    };
    const slots = psychoSlots(30, mix);
    expect(slots).toHaveLength(30);
    expect(slots.filter((t) => ["spelling", "synonyms", "antonyms"].includes(t))).toHaveLength(9);
    expect(slots.indexOf("antonyms")).toBeLessThan(slots.indexOf("percentages"));
    expect(slots.slice(-12).every((t) => t === "tables")).toBe(true);
  });
});

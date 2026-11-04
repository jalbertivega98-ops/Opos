/**
 * Porcentajes y fracciones con importes reales (formato del examen de Auxiliar
 * Administrativo del Estado): descuentos y subidas con céntimos, asistencia,
 * fracciones de un total y porcentaje del resto. La solución se recalcula
 * siempre a partir de los parámetros del enunciado.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { euros, percent } from "./format";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

export const PERCENT_TEMPLATES = ["discount", "increase", "absent", "fractions", "share"] as const;
type Template = (typeof PERCENT_TEMPLATES)[number];

const BY_DIFFICULTY: Record<Difficulty, Template[]> = {
  1: ["absent", "discount"],
  2: ["absent", "discount", "increase"],
  3: ["discount", "increase", "fractions", "share"],
  4: ["increase", "fractions", "share"],
  5: ["fractions", "share", "increase"],
};

/** Fuente de verdad: respuesta (formateada) a partir de los parámetros. */
export function solvePercentages(template: Template, v: Record<string, number>): string {
  switch (template) {
    case "discount":
      return euros((v.price * (100 - v.d)) / 100);
    case "increase":
      return euros((v.price * (100 + v.d)) / 100);
    case "absent":
      return String(v.n - (v.n * v.p) / 100);
    case "fractions":
      return String((v.n * (v.den - v.a - v.b)) / v.den);
    case "share":
      return percent(((v.n - v.k) * 100) / v.n);
  }
}

function make(rng: Rng, template: Template, d: Difficulty) {
  switch (template) {
    case "discount":
    case "increase": {
      const price = rng.int(12, d >= 4 ? 240 : 95);
      const pct = rng.pick(d <= 2 ? [5, 10, 20, 25] : [3, 4, 6, 7, 8, 12, 15, 18]);
      const values = { price, d: pct };
      const sign = template === "discount" ? -1 : 1;
      const traps = [
        euros((price * (100 - sign * pct)) / 100), // aplicar al revés
        euros((price * pct) / 100), // solo el descuento/subida
        euros(price + sign * pct), // sumar los puntos como euros
        euros((price * (100 + sign * (pct + 1))) / 100),
      ];
      return { values, traps };
    }
    case "absent": {
      const n = rng.pick([20, 25, 40, 50, 60, 75, 80, 120, 150, 200]);
      const options = [10, 20, 25, 30, 40, 45, 60, 64, 70, 75, 80, 85, 90, 95].filter((p) =>
        Number.isInteger((n * p) / 100),
      );
      const p = rng.pick(options);
      const present = (n * p) / 100;
      const values = { n, p };
      return {
        values,
        traps: [String(present), String(n - present + 2), String(n - present - 2), String(p)],
      };
    }
    case "fractions": {
      const den = rng.pick([4, 5, 6, 8, 10]);
      const a = rng.int(1, den - 3);
      const b = rng.int(1, den - a - 1);
      const n = den * rng.int(d >= 4 ? 40 : 12, d >= 4 ? 120 : 60);
      const values = { n, a, b, den };
      return {
        values,
        traps: [
          String((n * (a + b)) / den), // lo ya hecho
          String((n * (den - a)) / den), // olvidar el segundo día
          String((n * (den - b)) / den),
          String((n * (den - a - b)) / den + den),
        ],
      };
    }
    case "share": {
      const n = rng.int(d >= 4 ? 60 : 40, d >= 4 ? 180 : 99);
      const k = rng.int(5, Math.floor(n / 3));
      const values = { n, k };
      return {
        values,
        traps: [
          percent((k * 100) / n), // el porcentaje del departamento, no del resto
          percent(100 - k),
          percent(((n - k) * 100) / (n + k)),
          percent(((n - k - 1) * 100) / n),
        ],
      };
    }
  }
}

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 200; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const template = rng.pick(BY_DIFFICULTY[d]);
    const { values, traps } = make(rng, template, d);
    const answer = solvePercentages(template, values);
    const distractors = [...new Set(traps)].filter((t) => t !== answer && !t.startsWith("-"));
    if (distractors.length < 3) continue;
    const options = rng.shuffle([answer, ...rng.shuffle(distractors).slice(0, 3)]);
    const item: PsychoItem = {
      type: "percentages",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "text", key: `percentages_${template}`, values },
      options,
      answerIndex: options.indexOf(answer),
      explanation: { key: `percentages_${template}`, values: { ...values, answer } },
    };
    if (verifyPercentages(item).ok) return item;
  }
  return null;
}

export function verifyPercentages(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  if (item.presentation.kind !== "text") return { ok: false as const, reason: "presentation" };
  const template = item.presentation.key.replace(/^percentages_/, "") as Template;
  if (!(PERCENT_TEMPLATES as readonly string[]).includes(template))
    return { ok: false as const, reason: "template" };
  const answer = solvePercentages(template, item.presentation.values as Record<string, number>);
  if (item.options[item.answerIndex] !== answer) return { ok: false as const, reason: "answer" };
  return { ok: true as const };
}

export const percentages: PsychoGenerator = {
  type: "percentages",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar un problema de porcentajes (seed=${seed})`);
    return item;
  },
  verify: verifyPercentages,
};

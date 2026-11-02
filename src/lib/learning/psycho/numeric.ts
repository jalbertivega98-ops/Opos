/**
 * Razonamiento numérico: problemas breves con plantillas parametrizadas.
 * Todas las respuestas son enteras y se recalculan a partir de los parámetros.
 * Los distractores modelan errores típicos (proporción directa en vez de
 * inversa, sumar el descuento, olvidar un paso…).
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

type Template = "percent" | "discount" | "rule3" | "inverse" | "speed" | "average" | "mixture";

const BY_DIFFICULTY: Record<Difficulty, Template[]> = {
  1: ["percent", "rule3"],
  2: ["percent", "discount", "rule3"],
  3: ["discount", "speed", "inverse", "average"],
  4: ["inverse", "average", "speed", "mixture"],
  5: ["mixture", "inverse", "average"],
};

type Problem = {
  template: Template;
  values: Record<string, number>;
  answer: number;
  traps: number[];
};

/** Fuente de verdad: calcula la respuesta a partir de los parámetros. */
export function solveNumeric(template: Template, v: Record<string, number>): number {
  switch (template) {
    case "percent":
      return (v.p * v.n) / 100;
    case "discount":
      return v.price - (v.price * v.d) / 100;
    case "rule3":
      return (v.b * v.c) / v.a;
    case "inverse":
      return (v.w * v.t) / v.w2;
    case "speed":
      return (v.km / v.h) * v.h2;
    case "average":
      return (v.k * v.m + v.x) / (v.k + 1);
    case "mixture":
      return (v.q1 * v.p1 + v.q2 * v.p2) / (v.q1 + v.q2);
  }
}

function make(rng: Rng, template: Template, d: Difficulty): Problem {
  const big = d >= 4 ? 2 : 1;
  switch (template) {
    case "percent": {
      const p = rng.pick(d === 1 ? [10, 20, 25, 50] : [5, 15, 30, 35, 40, 60, 75]);
      const n = rng.int(1, 20 * big) * 20;
      const values = { p, n };
      const answer = solveNumeric(template, values);
      return { template, values, answer, traps: [n - answer, answer * 2, answer + 10] };
    }
    case "discount": {
      const d2 = rng.pick([10, 15, 20, 25, 30, 40]);
      const price = rng.int(2, 30 * big) * 20;
      const values = { price, d: d2 };
      const answer = solveNumeric(template, values);
      return {
        template,
        values,
        answer,
        traps: [price + (price * d2) / 100, (price * d2) / 100, answer - 10],
      };
    }
    case "rule3": {
      const a = rng.int(2, 6);
      const unit = rng.int(2, 9 * big);
      const c = rng.int(a + 1, a + 8);
      const values = { a, b: a * unit, c };
      const answer = solveNumeric(template, values);
      return { template, values, answer, traps: [answer + unit, a * unit + c, answer - unit] };
    }
    case "inverse": {
      const w2 = rng.pick([2, 3, 4, 5, 6]);
      const w = w2 * rng.int(2, 4);
      const t = rng.int(2, 10) * (d >= 4 ? 2 : 1);
      const values = { w, t, w2 };
      const answer = solveNumeric(template, values);
      // error típico: proporción directa
      return { template, values, answer, traps: [(t * w2) / w, t + (w - w2), answer / 2] };
    }
    case "speed": {
      const h = rng.int(2, 5);
      const v = rng.int(4, 12) * 10;
      const h2 = rng.int(1, 9);
      const values = { km: v * h, h, h2 };
      const answer = solveNumeric(template, values);
      return { template, values, answer, traps: [v * h + h2, answer + v, v * (h + h2)] };
    }
    case "average": {
      const k = rng.int(3, 7);
      const m = rng.int(4, 20);
      // x tal que la nueva media sea entera: x = m + j·(k+1)
      const x = m + rng.int(1, 4) * (k + 1);
      const values = { k, m, x };
      const answer = solveNumeric(template, values);
      return { template, values, answer, traps: [(m + x) / 2, answer + 1, m + 1] };
    }
    case "mixture": {
      const p1 = rng.int(2, 6) * 2;
      const p2 = p1 + rng.int(1, 4) * 4;
      const q = rng.int(1, 4);
      const values = { q1: q, p1, q2: q * 3, p2 };
      const answer = solveNumeric(template, values);
      return { template, values, answer, traps: [(p1 + p2) / 2, answer + 1, p2 - 1] };
    }
  }
}

const TEMPLATES = [
  "percent",
  "discount",
  "rule3",
  "inverse",
  "speed",
  "average",
  "mixture",
] as const;

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 200; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const template = rng.pick(BY_DIFFICULTY[d]);
    const pr = make(rng, template, d);
    if (!Number.isInteger(pr.answer) || pr.answer <= 0) continue;
    const pool = new Set<number>(
      [...pr.traps, pr.answer + 2, pr.answer - 2, pr.answer + 5].filter(
        (x) => Number.isInteger(x) && x > 0 && x !== pr.answer,
      ),
    );
    const distractors = [...pool].slice(0, 3);
    if (distractors.length < 3) continue;
    const options = rng.shuffle([pr.answer, ...distractors]).map(String);
    const item: PsychoItem = {
      type: "numeric",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "text", key: `numeric_${pr.template}`, values: pr.values },
      options,
      answerIndex: options.indexOf(String(pr.answer)),
      explanation: { key: `numeric_${pr.template}`, values: { ...pr.values, answer: pr.answer } },
    };
    if (verifyNumeric(item).ok) return item;
  }
  return null;
}

export function verifyNumeric(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  if (item.presentation.kind !== "text") return { ok: false as const, reason: "presentation" };
  const template = item.presentation.key.replace(/^numeric_/, "") as Template;
  if (!(TEMPLATES as readonly string[]).includes(template))
    return { ok: false as const, reason: "template" };
  const values = item.presentation.values as Record<string, number>;
  const answer = solveNumeric(template, values);
  if (!Number.isInteger(answer)) return { ok: false as const, reason: "not_integer" };
  if (item.options[item.answerIndex] !== String(answer))
    return { ok: false as const, reason: "answer" };
  if (item.options.filter((o) => o === String(answer)).length !== 1)
    return { ok: false as const, reason: "ambiguous" };
  return { ok: true as const };
}

export const numeric: PsychoGenerator = {
  type: "numeric",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar un problema numérico (seed=${seed})`);
    return item;
  },
  verify: verifyNumeric,
};

/**
 * Series de letras sobre el alfabeto español de 27 letras (con Ñ).
 * Las reglas operan sobre la posición de cada letra y reutilizan el motor de
 * series numéricas (mismas reglas, misma detección de ambigüedad).
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { fittingRules, nextTerm, termsOf, type SeriesRule } from "./series";
import {
  verifyCommon,
  type Difficulty,
  type Explanation,
  type PsychoGenerator,
  type PsychoItem,
} from "./types";

export const ALPHABET = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
const N = ALPHABET.length; // 27
const N_INDEX = ALPHABET.indexOf("Ñ");

const sign = (n: number) => (n > 0 ? `+${n}` : String(n));

const KINDS: Record<Difficulty, SeriesRule["kind"][]> = {
  1: ["arithmetic"],
  2: ["arithmetic", "alternating"],
  3: ["alternating", "interleaved", "arithmetic"],
  4: ["interleaved", "second_order", "alternating"],
  5: ["second_order", "interleaved"],
};

function randomRule(rng: Rng, d: Difficulty): SeriesRule {
  const kind = rng.pick(KINDS[d]);
  const nz = (min: number, max: number) => {
    let v = 0;
    while (v === 0) v = rng.int(min, max);
    return v;
  };
  switch (kind) {
    case "arithmetic":
      return { kind, start: rng.int(0, 10), step: d === 1 ? rng.int(1, 3) : nz(-4, 4) };
    case "alternating":
      return { kind, start: rng.int(0, 12), stepA: rng.int(2, 5), stepB: nz(-3, -1) };
    case "interleaved":
      return {
        kind,
        startA: rng.int(0, 6),
        stepA: rng.int(1, 3),
        startB: rng.int(14, 26),
        stepB: nz(-3, -1),
      };
    case "second_order":
      return { kind, start: rng.int(0, 4), step: 1, delta: 1 };
    default:
      return { kind: "arithmetic", start: 0, step: 1 };
  }
}

const toLetter = (i: number) => ALPHABET[i];

function explanation(rule: SeriesRule, crossesN: boolean): Explanation {
  const base = ((): Explanation => {
    switch (rule.kind) {
      case "arithmetic":
        return { key: "letters_arithmetic", values: { step: sign(rule.step) } };
      case "alternating":
        return {
          key: "letters_alternating",
          values: { stepA: sign(rule.stepA), stepB: sign(rule.stepB) },
        };
      case "interleaved":
        return {
          key: "letters_interleaved",
          values: {
            startA: toLetter(rule.startA),
            stepA: sign(rule.stepA),
            startB: toLetter(rule.startB),
            stepB: sign(rule.stepB),
          },
        };
      case "second_order":
        return { key: "letters_second_order", values: { step: rule.step, delta: rule.delta } };
      default:
        return { key: "letters_arithmetic", values: { step: "+1" } };
    }
  })();
  return crossesN ? { key: `${base.key}_n`, values: base.values } : base;
}

function build(seed: number, d: Difficulty): { item: PsychoItem } | null {
  for (let attempt = 0; attempt < 300; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const rule = randomRule(rng, d);
    const shown = rule.kind === "second_order" ? 5 : d >= 4 ? 7 : 6;
    const all = termsOf(rule, shown + 1);
    if (all.some((v) => v < 0 || v >= N)) continue; // sin dar la vuelta al alfabeto
    const indices = all.slice(0, shown);
    const answer = all[shown];
    const correct = toLetter(answer);
    const crossesN = Math.min(...all) < N_INDEX && Math.max(...all) > N_INDEX - 1;
    // distractores: letras vecinas (incluye el error típico de olvidar la Ñ)
    const pool = new Set<string>();
    for (const delta of rng.shuffle([1, -1, 2, -2, 3])) {
      const j = answer + delta;
      if (j >= 0 && j < N) pool.add(toLetter(j));
    }
    pool.delete(correct);
    const distractors = [...pool].slice(0, 3);
    if (distractors.length < 3) continue;
    const options = rng.shuffle([correct, ...distractors]);
    const item: PsychoItem = {
      type: "letters",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "sequence", terms: indices.map(toLetter) },
      options,
      answerIndex: options.indexOf(correct),
      explanation: explanation(rule, crossesN),
    };
    if (verifyLetters(item).ok) return { item };
  }
  return null;
}

export function verifyLetters(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  if (item.presentation.kind !== "sequence") return { ok: false as const, reason: "presentation" };
  const idx = item.presentation.terms.map((l) => ALPHABET.indexOf(l));
  if (idx.some((i) => i < 0) || item.options.some((o) => !ALPHABET.includes(o) || o.length !== 1))
    return { ok: false as const, reason: "alphabet" };
  const fits = fittingRules(idx).filter((r) => r.kind !== "geometric" && r.kind !== "fibonacci");
  if (fits.length === 0) return { ok: false as const, reason: "no_rule" };
  const predictions = new Set(fits.map((r) => nextTerm(r, idx.length)));
  const expected = ALPHABET.indexOf(item.options[item.answerIndex]);
  if (!predictions.has(expected)) return { ok: false as const, reason: "answer" };
  // ninguna otra regla razonable puede apuntar a otra opción
  for (const p of predictions) {
    if (p !== expected && p >= 0 && p < N && item.options.includes(toLetter(p)))
      return { ok: false as const, reason: "ambiguous" };
  }
  return { ok: true as const };
}

export const letters: PsychoGenerator = {
  type: "letters",
  version: 1,
  generate(seed, difficulty) {
    const b = build(seed, difficulty);
    if (!b) throw new Error(`No se pudo generar una serie de letras (seed=${seed})`);
    return b.item;
  },
  verify: verifyLetters,
};

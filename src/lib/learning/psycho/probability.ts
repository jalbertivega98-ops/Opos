/**
 * Probabilidad simple (casos favorables / casos posibles), como en el examen de
 * la AGE: bolas de colores en una bolsa o un sorteo de objetos entre personas.
 * Resultado en porcentaje con dos decimales.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { percent } from "./format";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

const KEYS = [
  "probability_balls_red",
  "probability_balls_green",
  "probability_balls_blue",
  "probability_raffle_laptop",
  "probability_raffle_tablet",
] as const;
type Key = (typeof KEYS)[number];

/** Casos favorables y posibles a partir de los parámetros. */
function cases(key: Key, v: Record<string, number>): [number, number] {
  switch (key) {
    case "probability_balls_red":
      return [v.r, v.r + v.g + v.b];
    case "probability_balls_green":
      return [v.g, v.r + v.g + v.b];
    case "probability_balls_blue":
      return [v.b, v.r + v.g + v.b];
    case "probability_raffle_laptop":
      return [v.l, v.m + v.t + v.l];
    case "probability_raffle_tablet":
      return [v.t, v.m + v.t + v.l];
  }
}

export function solveProbability(key: Key, v: Record<string, number>): string {
  const [fav, total] = cases(key, v);
  return percent((fav * 100) / total);
}

function make(rng: Rng, d: Difficulty): { key: Key; values: Record<string, number> } {
  const hi = d >= 4 ? 25 : 9;
  if (rng.next() < 0.6) {
    const values = { r: rng.int(2, hi), g: rng.int(2, hi), b: rng.int(2, hi) };
    const key = rng.pick(KEYS.slice(0, 3));
    return { key, values };
  }
  const values = { m: rng.int(2, hi), t: rng.int(2, hi), l: rng.int(1, d >= 3 ? 3 : 1) };
  return { key: rng.pick(KEYS.slice(3)), values };
}

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 200; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const { key, values } = make(rng, d);
    const [fav, total] = cases(key, values);
    const answer = solveProbability(key, values);
    const traps = [
      percent((fav * 100) / (total - fav)), // favorables entre desfavorables
      percent(100 / total),
      percent(((fav + 1) * 100) / total),
      percent(((total - fav) * 100) / total), // la contraria
      percent((fav * 100) / (total + 1)),
    ];
    const distractors = [...new Set(traps)].filter((t) => t !== answer);
    if (distractors.length < 3) continue;
    const options = rng.shuffle([answer, ...rng.shuffle(distractors).slice(0, 3)]);
    const item: PsychoItem = {
      type: "probability",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "text", key, values },
      options,
      answerIndex: options.indexOf(answer),
      explanation: { key: "probability", values: { fav, total, answer } },
    };
    if (verifyProbability(item).ok) return item;
  }
  return null;
}

export function verifyProbability(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  const p = item.presentation;
  if (p.kind !== "text" || !(KEYS as readonly string[]).includes(p.key))
    return { ok: false as const, reason: "presentation" };
  const answer = solveProbability(p.key as Key, p.values as Record<string, number>);
  if (item.options[item.answerIndex] !== answer) return { ok: false as const, reason: "answer" };
  return { ok: true as const };
}

export const probability: PsychoGenerator = {
  type: "probability",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar un problema de probabilidad (seed=${seed})`);
    return item;
  },
  verify: verifyProbability,
};

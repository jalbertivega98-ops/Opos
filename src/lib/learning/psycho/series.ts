/**
 * Psicotécnicos de series numéricas con solución verificable.
 *
 * - `generateSeries(seed, difficulty)` es puro y determinista: el servidor puede
 *   regenerar el ítem a partir de la semilla para corregir sin almacenar nada
 *   y sin enviar la respuesta al cliente.
 * - `verifySeries(item)` recalcula la solución y comprueba que el ítem no es
 *   ambiguo: ninguna otra regla del catálogo encaja con los términos mostrados
 *   prediciendo otra de las opciones.
 */
import { createRng, mixSeed, type Rng } from "../prng";

export type Difficulty = 1 | 2 | 3 | 4 | 5;

export type SeriesRule =
  | { kind: "arithmetic"; start: number; step: number }
  | { kind: "geometric"; start: number; ratio: number }
  | { kind: "alternating"; start: number; stepA: number; stepB: number }
  | { kind: "second_order"; start: number; step: number; delta: number }
  | { kind: "fibonacci"; a: number; b: number }
  | { kind: "interleaved"; startA: number; stepA: number; startB: number; stepB: number };

export type SeriesItem = {
  type: "series";
  seed: number;
  difficulty: Difficulty;
  terms: number[]; // términos visibles
  options: number[]; // 4 opciones barajadas
  answerIndex: number; // índice de la correcta (NUNCA se envía al cliente)
  rule: SeriesRule; // explicación estructurada (i18n en la UI)
};

/** Vista pública: sin respuesta ni regla. */
export type PublicSeriesItem = Pick<
  SeriesItem,
  "type" | "seed" | "difficulty" | "terms" | "options"
>;

const MAX = 100_000;

export function termsOf(rule: SeriesRule, n: number): number[] {
  const out: number[] = [];
  switch (rule.kind) {
    case "arithmetic":
      for (let i = 0; i < n; i++) out.push(rule.start + i * rule.step);
      break;
    case "geometric":
      for (let i = 0, v = rule.start; i < n; i++, v *= rule.ratio) out.push(v);
      break;
    case "alternating":
      for (let i = 0, v = rule.start; i < n; i++) {
        out.push(v);
        v += i % 2 === 0 ? rule.stepA : rule.stepB;
      }
      break;
    case "second_order":
      for (let i = 0, v = rule.start, s = rule.step; i < n; i++) {
        out.push(v);
        v += s;
        s += rule.delta;
      }
      break;
    case "fibonacci":
      for (let i = 0, x = rule.a, y = rule.b; i < n; i++) {
        out.push(x);
        [x, y] = [y, x + y];
      }
      break;
    case "interleaved":
      for (let i = 0; i < n; i++)
        out.push(
          i % 2 === 0
            ? rule.startA + (i / 2) * rule.stepA
            : rule.startB + ((i - 1) / 2) * rule.stepB,
        );
      break;
  }
  return out;
}

const KINDS_BY_DIFFICULTY: Record<Difficulty, SeriesRule["kind"][]> = {
  1: ["arithmetic"],
  2: ["arithmetic", "geometric"],
  3: ["alternating", "second_order", "geometric"],
  4: ["second_order", "fibonacci", "interleaved", "alternating"],
  5: ["interleaved", "fibonacci", "second_order"],
};

function randomRule(rng: Rng, difficulty: Difficulty): SeriesRule {
  const kind = rng.pick(KINDS_BY_DIFFICULTY[difficulty]);
  const big = difficulty >= 4 ? 2 : 1;
  const nz = (min: number, max: number) => {
    let v = 0;
    while (v === 0) v = rng.int(min, max);
    return v;
  };
  switch (kind) {
    case "arithmetic":
      return { kind, start: rng.int(1, 30 * big), step: nz(-9 * big, 12 * big) };
    case "geometric":
      return { kind, start: rng.int(1, 6), ratio: rng.pick([2, 3, -2] as const) };
    case "alternating":
      return { kind, start: rng.int(1, 40), stepA: nz(2, 9 * big), stepB: nz(-8 * big, -1) };
    case "second_order":
      return { kind, start: rng.int(1, 20), step: rng.int(1, 6), delta: nz(1, 3 * big) };
    case "fibonacci":
      return { kind, a: rng.int(1, 5), b: rng.int(2, 8) };
    case "interleaved":
      return {
        kind,
        startA: rng.int(1, 20),
        stepA: nz(2, 7 * big),
        startB: rng.int(30, 60),
        stepB: nz(-6 * big, -1),
      };
  }
}

/** Reglas candidatas que encajan con los términos dados (para detectar ambigüedad). */
export function fittingRules(terms: number[]): SeriesRule[] {
  const fits: SeriesRule[] = [];
  const eq = (rule: SeriesRule) => termsOf(rule, terms.length).every((v, i) => v === terms[i]);
  const [t0, t1, t2, t3] = terms;
  const candidates: SeriesRule[] = [
    { kind: "arithmetic", start: t0, step: t1 - t0 },
    { kind: "alternating", start: t0, stepA: t1 - t0, stepB: t2 - t1 },
    { kind: "second_order", start: t0, step: t1 - t0, delta: t2 - t1 - (t1 - t0) },
    { kind: "fibonacci", a: t0, b: t1 },
    { kind: "interleaved", startA: t0, stepA: t2 - t0, startB: t1, stepB: t3 - t1 },
  ];
  if (t0 !== 0 && Number.isInteger(t1 / t0))
    candidates.push({ kind: "geometric", start: t0, ratio: t1 / t0 });
  for (const c of candidates) if (eq(c)) fits.push(c);
  return fits;
}

export const nextTerm = (rule: SeriesRule, shown: number) => termsOf(rule, shown + 1)[shown];

function distractors(rng: Rng, correct: number, terms: number[], rule: SeriesRule): number[] {
  const last = terms[terms.length - 1];
  const diff = last - terms[terms.length - 2];
  const pool = new Set<number>([
    last + diff,
    correct + 1,
    correct - 1,
    correct + 2,
    correct - 2,
    correct + Math.abs(diff) || correct + 3,
    correct - Math.abs(diff) || correct - 3,
    rule.kind === "geometric" ? last + diff : correct * 2,
    correct + 10,
    correct - 10,
  ]);
  pool.delete(correct);
  return rng.shuffle([...pool]).slice(0, 3);
}

/** Comprueba corrección y no ambigüedad del ítem. */
export function verifySeries(item: SeriesItem): { ok: boolean; reason?: string } {
  const shown = item.terms.length;
  const expected = nextTerm(item.rule, shown);
  if (!termsOf(item.rule, shown).every((v, i) => v === item.terms[i]))
    return { ok: false, reason: "terms" };
  if (item.options[item.answerIndex] !== expected) return { ok: false, reason: "answer" };
  if (new Set(item.options).size !== item.options.length)
    return { ok: false, reason: "duplicate_options" };
  if (item.options.some((o) => !Number.isSafeInteger(o) || Math.abs(o) > MAX))
    return { ok: false, reason: "range" };
  for (const alt of fittingRules(item.terms)) {
    const other = nextTerm(alt, shown);
    if (other !== expected && item.options.includes(other))
      return { ok: false, reason: "ambiguous" };
  }
  return { ok: true };
}

export function generateSeries(seed: number, difficulty: Difficulty): SeriesItem {
  for (let attempt = 0; attempt < 200; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const rule = randomRule(rng, difficulty);
    const shown = difficulty >= 4 ? 7 : 6;
    const terms = termsOf(rule, shown);
    const correct = nextTerm(rule, shown);
    if ([...terms, correct].some((v) => Math.abs(v) > MAX)) continue;
    const options = rng.shuffle([correct, ...distractors(rng, correct, terms, rule)]);
    const item: SeriesItem = {
      type: "series",
      seed,
      difficulty,
      terms,
      options,
      answerIndex: options.indexOf(correct),
      rule,
    };
    if (verifySeries(item).ok) return item;
  }
  throw new Error(`No se pudo generar una serie válida (seed=${seed}, difficulty=${difficulty})`);
}

export const toPublic = ({
  type,
  seed,
  difficulty,
  terms,
  options,
}: SeriesItem): PublicSeriesItem => ({
  type,
  seed,
  difficulty,
  terms,
  options,
});

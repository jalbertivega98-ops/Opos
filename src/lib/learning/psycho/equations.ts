/**
 * Ecuaciones de primer grado como las del examen de la AGE:
 * «Halla el valor de x: 5(5x − 3) = x», «10 − 9x = 4(x − 4)».
 * Cada lado es m·(a·x + c); el enunciado se reconstruye desde los parámetros
 * y la solución x = (m2·c2 − m1·c1) / (m1·a1 − m2·a2) se recalcula al corregir.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { dec } from "./format";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

type Side = { m: number; a: number; c: number; constFirst: boolean };

const term = (a: number) => (a === 1 ? "x" : a === -1 ? "-x" : `${a}x`);

function inner(a: number, c: number, constFirst: boolean): string {
  if (c === 0) return term(a);
  if (constFirst) return `${c} ${a < 0 ? "-" : "+"} ${term(Math.abs(a))}`;
  return `${term(a)} ${c < 0 ? "-" : "+"} ${Math.abs(c)}`;
}

export function sideText(s: Side): string {
  const body = inner(s.a, s.c, s.constFirst && s.m === 1);
  return s.m === 1 ? body : `${s.m}(${body})`;
}

export const solveLinear = (l: Side, r: Side) => (r.m * r.c - l.m * l.c) / (l.m * l.a - r.m * r.a);

/** Decimales de la respuesta: enteros sin decimales; 3 si es exacta con 3; si no, 2. */
function decimalsFor(x: number): number {
  if (Number.isInteger(Math.round(x * 1e6) / 1e6)) return 0;
  const k = Math.round(x * 1000);
  return Math.abs(x * 1000 - k) < 1e-6 && k % 10 !== 0 ? 3 : 2;
}
const fmt = (x: number, decimals: number) =>
  decimals === 0 ? String(Math.round(x)) : dec(x, decimals);

const sides = (v: Record<string, number>): [Side, Side] => [
  { m: v.m1, a: v.a1, c: v.c1, constFirst: v.f1 === 1 },
  { m: v.m2, a: v.a2, c: v.c2, constFirst: v.f2 === 1 },
];

export function solveEquation(v: Record<string, number>): string | null {
  const [l, r] = sides(v);
  if (l.m * l.a - r.m * r.a === 0) return null;
  const x = solveLinear(l, r);
  return fmt(x, decimalsFor(x));
}

function make(rng: Rng, d: Difficulty): Record<string, number> {
  const nz = (lo: number, hi: number) => {
    let x = 0;
    while (x === 0) x = rng.int(lo, hi);
    return x;
  };
  if (d <= 2) {
    // solución entera: se elige x y se ajusta la constante del lado derecho
    const m1 = rng.int(2, d === 1 ? 4 : 6);
    const a1 = nz(1, 6);
    const c1 = nz(-9, 9);
    const a2 = nz(-5, 5);
    const x = nz(-4, 6);
    const m2 = 1;
    const c2 = (m1 * a1 - a2) * x + m1 * c1;
    const swap = rng.next() < 0.4;
    return swap
      ? { m1: 1, a1: a2, c1: c2, f1: 1, m2: m1, a2: a1, c2: c1, f2: 0 }
      : { m1, a1, c1, f1: 0, m2, a2, c2, f2: 0 };
  }
  const m1 = rng.int(2, d >= 4 ? 25 : 9);
  const a1 = nz(2, 9);
  const c1 = nz(-15, 15);
  const a2 = nz(-6, 6);
  const c2 = rng.int(-10, 10);
  const swap = rng.next() < 0.35;
  return swap
    ? { m1: 1, a1: a2, c1: c2, f1: c2 === 0 ? 0 : 1, m2: m1, a2: a1, c2: c1, f2: 0 }
    : { m1, a1, c1, f1: 0, m2: 1, a2, c2, f2: 0 };
}

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 300; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const v = make(rng, d);
    const [l, r] = sides(v);
    const den = l.m * l.a - r.m * r.a;
    if (den === 0) continue;
    const x = solveLinear(l, r);
    if (Math.abs(x) > 50) continue;
    const decimals = decimalsFor(x);
    if (d >= 3 && decimals === 0 && rng.next() < 0.7) continue;
    const answer = fmt(x, decimals);
    const raw = [
      (r.m * r.c + l.m * l.c) / den, // signo al pasar la constante
      (r.m * r.c - l.m * l.c) / (l.m * l.a + r.m * r.a), // signo al pasar la x
      (r.m * r.c - l.c) / den, // no multiplicar la constante del paréntesis
      (r.c - l.m * l.c) / (l.m * l.a - r.a),
      -x,
      x + 1,
      x - 1,
    ].filter((t) => Number.isFinite(t));
    const distractors = [...new Set(raw.map((t) => fmt(t, decimals)))].filter(
      (t) => t !== answer && Number(t.replace(",", ".")) !== 0,
    );
    if (distractors.length < 3) continue;
    const options = rng.shuffle([answer, ...distractors.slice(0, 3)]);
    const expr = `${sideText(l)} = ${sideText(r)}`;
    const item: PsychoItem = {
      type: "equations",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "text", key: "equations", values: { ...v, expr } },
      options,
      answerIndex: options.indexOf(answer),
      explanation: { key: "equations", values: { expr, answer } },
    };
    if (verifyEquation(item).ok) return item;
  }
  return null;
}

export function verifyEquation(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  const p = item.presentation;
  if (p.kind !== "text" || p.key !== "equations")
    return { ok: false as const, reason: "presentation" };
  const v = p.values as Record<string, number>;
  const [l, r] = sides(v);
  if (p.values?.expr !== `${sideText(l)} = ${sideText(r)}`)
    return { ok: false as const, reason: "expr" };
  const answer = solveEquation(v);
  if (answer === null || item.options[item.answerIndex] !== answer)
    return { ok: false as const, reason: "answer" };
  return { ok: true as const };
}

export const equations: PsychoGenerator = {
  type: "equations",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar una ecuación (seed=${seed})`);
    return item;
  },
  verify: verifyEquation,
};

/**
 * Atención y concentración:
 *  - «count»: contar cuántas veces aparece un símbolo entre otros parecidos.
 *  - «pairs»: contar cuántas parejas de códigos son idénticas.
 * La solución se recalcula contando directamente sobre lo que se muestra.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

const CONFUSABLE: Record<Difficulty, string[]> = {
  1: ["A", "X", "O", "T"],
  2: ["E", "F", "P", "B"],
  3: ["b", "d", "p", "q"],
  4: ["6", "9", "8", "0", "3"],
  5: ["b", "d", "p", "q", "g"],
};
const ROWS: Record<Difficulty, number> = { 1: 3, 2: 4, 3: 4, 4: 5, 5: 6 };
const COLS = 10;
const SEP = " · ";

function countItem(rng: Rng, d: Difficulty) {
  const set = CONFUSABLE[d];
  const target = rng.pick(set);
  const rows = Array.from({ length: ROWS[d] }, () =>
    Array.from({ length: COLS }, () => rng.pick(set)).join(""),
  );
  const answer = rows
    .join("")
    .split("")
    .filter((c) => c === target).length;
  return {
    presentation: { kind: "grid" as const, key: "attention_count", values: { target }, rows },
    answer,
    explanation: { key: "attention_count", values: { target, answer } },
  };
}

function pairsItem(rng: Rng, d: Difficulty) {
  const len = d >= 4 ? 6 : 5;
  const digits = () => Array.from({ length: len }, () => rng.int(0, 9)).join("");
  const rows: string[] = [];
  for (let i = 0; i < ROWS[d] + 2; i++) {
    const a = digits();
    let b = a;
    if (rng.next() < 0.5) {
      // diferencia sutil: intercambiar dos cifras vecinas distintas o cambiar una
      const arr = a.split("");
      const j = rng.int(0, len - 2);
      if (arr[j] !== arr[j + 1] && d >= 3) [arr[j], arr[j + 1]] = [arr[j + 1], arr[j]];
      else arr[j] = String((Number(arr[j]) + rng.int(1, 8)) % 10);
      b = arr.join("");
    }
    rows.push(`${a}${SEP}${b}`);
  }
  const answer = rows.filter((r) => {
    const [x, y] = r.split(SEP);
    return x === y;
  }).length;
  return {
    presentation: { kind: "grid" as const, key: "attention_pairs", rows },
    answer,
    explanation: { key: "attention_pairs", values: { answer } },
  };
}

export function solveAttention(p: PsychoItem["presentation"]): number | null {
  if (p.kind !== "grid") return null;
  if (p.key === "attention_count") {
    const target = String(p.values?.target ?? "");
    if (target.length !== 1) return null;
    return p.rows
      .join("")
      .split("")
      .filter((c) => c === target).length;
  }
  if (p.key === "attention_pairs")
    return p.rows.filter((r) => {
      const [x, y] = r.split(SEP);
      return x === y;
    }).length;
  return null;
}

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 200; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const kind = rng.next() < 0.5 ? countItem(rng, d) : pairsItem(rng, d);
    if (kind.answer < 1) continue;
    const pool = [
      kind.answer + 1,
      kind.answer - 1,
      kind.answer + 2,
      kind.answer - 2,
      kind.answer + 3,
    ].filter((x) => x >= 0);
    const options = rng.shuffle([kind.answer, ...rng.shuffle(pool).slice(0, 3)]).map(String);
    const item: PsychoItem = {
      type: "attention",
      seed,
      difficulty: d,
      version: 1,
      presentation: kind.presentation,
      options,
      answerIndex: options.indexOf(String(kind.answer)),
      explanation: kind.explanation,
    };
    if (verifyAttention(item).ok) return item;
  }
  return null;
}

export function verifyAttention(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  const answer = solveAttention(item.presentation);
  if (answer === null) return { ok: false as const, reason: "presentation" };
  if (item.options[item.answerIndex] !== String(answer))
    return { ok: false as const, reason: "answer" };
  return { ok: true as const };
}

export const attention: PsychoGenerator = {
  type: "attention",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar un ejercicio de atención (seed=${seed})`);
    return item;
  },
  verify: verifyAttention,
};

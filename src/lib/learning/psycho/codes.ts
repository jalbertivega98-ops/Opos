/**
 * Codificación (aptitud administrativa del examen de la AGE): con una tabla de
 * equivalencias letra = código binario de 4 cifras, traducir una serie de
 * números a letras. La solución se recalcula decodificando el mensaje.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

const LETTERS = "abcdefghijklmnoprstuvxz".split("");
const CODES = Array.from({ length: 15 }, (_, i) => (i + 1).toString(2).padStart(4, "0"));
const SEP = ", ";

export function parseMap(map: string): Map<string, string> | null {
  const out = new Map<string, string>();
  for (const pair of map.split(SEP)) {
    const m = /^([a-zñ])=([01]{4})$/.exec(pair);
    if (!m || out.has(m[2])) return null;
    out.set(m[2], m[1]);
  }
  return out.size >= 4 ? out : null;
}

export function decode(map: string, code: string): string | null {
  const m = parseMap(map);
  if (!m || code.length % 4 !== 0) return null;
  let out = "";
  for (let i = 0; i < code.length; i += 4) {
    const l = m.get(code.slice(i, i + 4));
    if (!l) return null;
    out += l;
  }
  return out;
}

const bitDistance = (a: string, b: string) => [...a].filter((c, i) => c !== b[i]).length;

function make(rng: Rng, d: Difficulty) {
  const letters = rng.shuffle(LETTERS).slice(0, 6);
  // en los niveles altos, códigos más parecidos entre sí
  const pool = d >= 3 ? CODES.filter((c) => c.split("1").length - 1 <= 2) : CODES;
  const codes = rng.shuffle(pool).slice(0, 6);
  const entries = letters.map((l, i) => [l, codes[i]] as const);
  const len = d >= 4 ? 5 : 4;
  const word = Array.from({ length: len }, () => rng.pick(entries));
  const answer = word.map(([l]) => l).join("");
  const code = word.map(([, c]) => c).join("");
  const map = entries.map(([l, c]) => `${l}=${c}`).join(SEP);

  const swaps: string[] = [];
  for (let i = 0; i < len - 1; i++) {
    if (answer[i] !== answer[i + 1])
      swaps.push(answer.slice(0, i) + answer[i + 1] + answer[i] + answer.slice(i + 2));
  }
  const near: string[] = [];
  for (let i = 0; i < len; i++) {
    const [, c] = word[i];
    for (const [l2, c2] of entries) {
      if (l2 !== answer[i] && bitDistance(c, c2) === 1)
        near.push(answer.slice(0, i) + l2 + answer.slice(i + 1));
    }
  }
  const random = Array.from({ length: 4 }, () =>
    Array.from({ length: len }, () => rng.pick(entries)[0]).join(""),
  );
  return { map, code, answer, traps: [...rng.shuffle(near), ...rng.shuffle(swaps), ...random] };
}

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 200; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const { map, code, answer, traps } = make(rng, d);
    const distractors = [...new Set(traps)].filter((t) => t !== answer);
    if (distractors.length < 3) continue;
    const options = rng.shuffle([answer, ...distractors.slice(0, 3)]);
    const item: PsychoItem = {
      type: "codes",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "text", key: "codes", values: { map, code } },
      options,
      answerIndex: options.indexOf(answer),
      explanation: { key: "codes", values: { answer } },
    };
    if (verifyCodes(item).ok) return item;
  }
  return null;
}

export function verifyCodes(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  const p = item.presentation;
  if (p.kind !== "text" || p.key !== "codes") return { ok: false as const, reason: "presentation" };
  const answer = decode(String(p.values?.map ?? ""), String(p.values?.code ?? ""));
  if (answer === null || item.options[item.answerIndex] !== answer)
    return { ok: false as const, reason: "answer" };
  return { ok: true as const };
}

export const codes: PsychoGenerator = {
  type: "codes",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar un ejercicio de códigos (seed=${seed})`);
    return item;
  },
  verify: verifyCodes,
};

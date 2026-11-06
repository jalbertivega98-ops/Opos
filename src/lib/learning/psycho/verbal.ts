/**
 * Psicotécnicos verbales del examen de Auxiliar Administrativo del Estado:
 * sinónimos, antónimos y ortografía («señale la palabra con error»).
 *
 * Todo sale del banco comprobado en el DLE (`verbal-bank.ts`). La respuesta de
 * un ítem de sinónimos es un sinónimo que el DLE da para la palabra; los
 * distractores son palabras sin relación en el DLE con ella (ni sinónimo ni
 * antónimo, en ningún sentido) y, como en el examen real, un antónimo. Al
 * corregir se recalcula todo desde el banco.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { DLE_SYNONYMS, SPELLING_PAIRS } from "./verbal-bank";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

type Entry = { word: string; syn: string[]; ant: string[] };
type Pos = "verb" | "noun" | "adj";

/** Entradas cuyo primer sentido en el DLE no es el habitual: no se preguntan. */
const SKIP_HEADWORDS = new Set([
  "gentil",
  "diestro",
  "manso",
  "brusco",
  "fuerte",
  "claro",
  "tibio",
]);

/** Respuestas válidas en el DLE pero raras, regionales o de otra acepción. */
const NOT_AS_ANSWER = new Set([
  "abuelo",
  "abuhado",
  "achantado",
  "acostadote",
  "ameno",
  "anfibológico",
  "bienmandado",
  "borracho",
  "breve",
  "ceporro",
  "chamicado",
  "chirle",
  "chupado",
  "comprensivo",
  "desaborido",
  "divertido",
  "dudoso",
  "escuchimizado",
  "eternal",
  "fario",
  "improductivo",
  "malaventura",
  "matusalén",
  "palurdo",
  "pelado",
  "plebeyo",
  "rapidez",
  "rendido",
  "sombra",
  "zote",
]);

const VERBS = new Set(["acabar", "afligir", "ascender", "empezar", "expandir"]);
const NOUNS = new Set([
  "adversidad",
  "bondad",
  "calma",
  "caos",
  "codicia",
  "compasión",
  "decadencia",
  "desidia",
  "entusiasmo",
  "euforia",
  "fortuna",
  "gozo",
  "júbilo",
  "orgullo",
  "sosiego",
]);
const posOf = (w: string): Pos => (VERBS.has(w) ? "verb" : NOUNS.has(w) ? "noun" : "adj");

export const BANK: Entry[] = DLE_SYNONYMS.trim()
  .split("\n")
  .map((line) => {
    const [word, rest] = line.split(":");
    const [syn, ant] = rest.split(";");
    const list = (s: string) => (s ? s.split(",") : []);
    return { word, syn: list(syn), ant: list(ant) };
  });
const BY_WORD = new Map(BANK.map((e) => [e.word, e]));

/** ¿Están relacionadas `a` y `b` en el DLE (sinónimo o antónimo, en cualquier sentido)? */
export function related(a: string, b: string): boolean {
  if (a === b) return true;
  const ea = BY_WORD.get(a);
  const eb = BY_WORD.get(b);
  if (ea && (ea.syn.includes(b) || ea.ant.includes(b))) return true;
  if (eb && (eb.syn.includes(a) || eb.ant.includes(a))) return true;
  return false;
}

export type VerbalMode = "synonyms" | "antonyms";

/** Respuestas candidatas: las primeras del DLE (sentido principal), más hondas si sube la dificultad. */
export function answersFor(word: string, mode: VerbalMode, d: Difficulty): string[] {
  const e = BY_WORD.get(word);
  if (!e || SKIP_HEADWORDS.has(word)) return [];
  const list = (mode === "synonyms" ? e.syn : e.ant).filter((w) => !NOT_AS_ANSWER.has(w));
  const depth = mode === "antonyms" ? 3 : d <= 2 ? 2 : d === 3 ? 3 : 4;
  return list.slice(0, depth);
}

/** Palabra «limpia» para distractor: ni ella ni su entrada tocan a `word` en el DLE. */
function unrelatedTo(word: string, candidate: string): boolean {
  const e = BY_WORD.get(word)!;
  if (related(word, candidate)) return false;
  // tampoco puede ser sinónimo/antónimo de ningún sinónimo o antónimo de la palabra
  for (const w of [...e.syn, ...e.ant]) if (related(w, candidate)) return false;
  return true;
}

const poolCache = new Map<string, string[]>();

function distractorPool(word: string): string[] {
  const cached = poolCache.get(word);
  if (cached) return cached;
  const pos = posOf(word);
  const pool: string[] = [];
  for (const e of BANK) {
    if (e.word === word || SKIP_HEADWORDS.has(e.word) || posOf(e.word) !== pos) continue;
    for (const w of [e.word, ...e.syn.slice(0, 2).filter((s) => !NOT_AS_ANSWER.has(s))])
      if (!pool.includes(w)) pool.push(w);
  }
  const clean = pool.filter((c) => unrelatedTo(word, c));
  poolCache.set(word, clean);
  return clean;
}

const WORDS = BANK.map((e) => e.word).filter((w) => !SKIP_HEADWORDS.has(w));

function buildRelation(mode: VerbalMode, seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 100; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const word = rng.pick(WORDS);
    const answers = answersFor(word, mode, d);
    if (answers.length === 0) continue;
    const answer = rng.pick(answers);
    const e = BY_WORD.get(word)!;
    // como en el examen real: entre los distractores, uno del sentido contrario
    const opposite = (mode === "synonyms" ? e.ant : e.syn)
      .filter((w) => !NOT_AS_ANSWER.has(w))
      .slice(0, 3)
      .filter((w) => w !== answer && !(mode === "synonyms" ? e.syn : e.ant).includes(w));
    const pool = rng.shuffle(distractorPool(word)).filter((w) => !related(answer, w));
    const distractors = [...(opposite.length ? [rng.pick(opposite)] : []), ...pool].slice(0, 3);
    if (distractors.length < 3 || new Set(distractors).size < 3) continue;
    const options = rng.shuffle([answer, ...distractors]);
    const item: PsychoItem = {
      type: mode,
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "text", key: mode, values: { word } },
      options,
      answerIndex: options.indexOf(answer),
      explanation: { key: mode, values: { word, answer } },
    };
    if (verifyRelation(item).ok) return item;
  }
  return null;
}

export function verifyRelation(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  const p = item.presentation;
  const mode = item.type as VerbalMode;
  if (p.kind !== "text" || p.key !== mode) return { ok: false as const, reason: "presentation" };
  const word = String(p.values?.word ?? "");
  const e = BY_WORD.get(word);
  if (!e) return { ok: false as const, reason: "word" };
  const good = mode === "synonyms" ? e.syn : e.ant;
  const answer = item.options[item.answerIndex];
  if (!good.includes(answer)) return { ok: false as const, reason: "answer" };
  // ninguna otra opción puede ser también válida
  for (const [i, o] of item.options.entries())
    if (i !== item.answerIndex && good.includes(o))
      return { ok: false as const, reason: "ambiguous" };
  return { ok: true as const };
}

const CORRECT = new Set(SPELLING_PAIRS.map(([ok]) => ok));
const WRONG = new Map(SPELLING_PAIRS.map(([ok, bad]) => [bad, ok]));

function buildSpelling(seed: number, d: Difficulty): PsychoItem {
  const rng: Rng = createRng(mixSeed(seed, 0));
  const [target, ...others] = rng.shuffle([...SPELLING_PAIRS]);
  const wrong = target[1];
  // con más dificultad, las correctas se parecen más a la errónea (misma inicial)
  const near = others.filter(([ok]) => ok[0] === target[0][0] && ok !== target[0]);
  const fill = others.filter(([ok]) => !near.some(([n]) => n === ok));
  const pickFrom = d >= 4 ? [...rng.shuffle(near), ...fill] : fill;
  const options = rng.shuffle([wrong, ...pickFrom.slice(0, 3).map(([ok]) => ok)]);
  return {
    type: "spelling",
    seed,
    difficulty: d,
    version: 1,
    presentation: { kind: "text", key: "spelling" },
    options,
    answerIndex: options.indexOf(wrong),
    explanation: { key: "spelling", values: { answer: wrong, correct: target[0] } },
  };
}

export function verifySpelling(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  if (item.presentation.kind !== "text" || item.presentation.key !== "spelling")
    return { ok: false as const, reason: "presentation" };
  for (const [i, o] of item.options.entries()) {
    const ok = i === item.answerIndex ? WRONG.has(o) : CORRECT.has(o);
    if (!ok) return { ok: false as const, reason: "answer" };
  }
  return { ok: true as const };
}

const relationGenerator = (mode: VerbalMode): PsychoGenerator => ({
  type: mode,
  version: 1,
  generate(seed, difficulty) {
    const item = buildRelation(mode, seed, difficulty);
    if (!item) throw new Error(`No se pudo generar un ítem de ${mode} (seed=${seed})`);
    return item;
  },
  verify: verifyRelation,
});

export const synonyms = relationGenerator("synonyms");
export const antonyms = relationGenerator("antonyms");

export const spelling: PsychoGenerator = {
  type: "spelling",
  version: 1,
  generate: buildSpelling,
  verify: verifySpelling,
};

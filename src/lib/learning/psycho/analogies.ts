/**
 * Analogías verbales con un vocabulario curado y bilingüe (es/ca).
 * Las palabras se guardan como identificadores ("w:<id>") y se traducen en la
 * interfaz (messages/*.json → psycho.words). Los distractores salen del mismo
 * tipo de relación (palabras plausibles) y nunca forman un par conocido con la
 * palabra de la pregunta, en ninguna relación del vocabulario.
 */
import { createRng, mixSeed } from "../prng";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

export type Relation = "opposite" | "young" | "category" | "part_whole" | "tool";

/** Pares [a, b]: «a es a b». Revisados a mano para evitar dobles lecturas. */
export const RELATIONS: Record<Relation, [string, string][]> = {
  opposite: [
    ["alto", "bajo"],
    ["frio", "caliente"],
    ["rapido", "lento"],
    ["abrir", "cerrar"],
    ["ganar", "perder"],
    ["subir", "bajar"],
    ["lleno", "vacio"],
    ["dia", "noche"],
    ["encender", "apagar"],
  ],
  young: [
    ["perro", "cachorro"],
    ["vaca", "ternero"],
    ["caballo", "potro"],
    ["oveja", "cordero"],
    ["gallina", "pollito"],
    ["cerdo", "lechon"],
    ["cabra", "cabrito"],
  ],
  category: [
    ["manzana", "fruta"],
    ["zanahoria", "verdura"],
    ["sardina", "pez"],
    ["aguila", "ave"],
    ["piano", "instrumento"],
    ["rojo", "color"],
    ["silla", "mueble"],
    ["hierro", "metal"],
  ],
  part_whole: [
    ["pagina", "libro"],
    ["rueda", "coche"],
    ["tecla", "teclado"],
    ["dedo", "mano"],
    ["ladrillo", "muro"],
    ["petalo", "flor"],
    ["eslabon", "cadena"],
    ["vagon", "tren"],
  ],
  tool: [
    ["tijeras", "cortar"],
    ["lapiz", "escribir"],
    ["escoba", "barrer"],
    ["aguja", "coser"],
    ["pala", "cavar"],
    ["bascula", "pesar"],
    ["regadera", "regar"],
    ["peine", "peinar"],
  ],
};

const BY_DIFFICULTY: Record<Difficulty, Relation[]> = {
  1: ["opposite", "young"],
  2: ["opposite", "young", "category"],
  3: ["category", "part_whole", "tool"],
  4: ["part_whole", "tool", "category"],
  5: ["part_whole", "tool", "category", "young"],
};

const ALL_PAIRS = new Set(
  Object.values(RELATIONS).flatMap((pairs) =>
    pairs.flatMap(([a, b]) => [`${a}|${b}`, `${b}|${a}`]),
  ),
);
/** ¿Existe alguna relación conocida entre x e y (en cualquier sentido)? */
export const related = (x: string, y: string) => ALL_PAIRS.has(`${x}|${y}`);

export const ALL_WORDS = [...new Set(Object.values(RELATIONS).flat(2))];

const w = (id: string) => `w:${id}`;
const unw = (t: string) => t.replace(/^w:/, "");

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 200; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const relation = rng.pick(BY_DIFFICULTY[d]);
    const pairs = RELATIONS[relation];
    const [p1, p2] = rng.shuffle(pairs);
    const [a, b] = p1;
    const [c, dWord] = p2;
    const nOptions = d >= 4 ? 5 : 4;
    const pool = rng
      .shuffle(pairs.map(([, y]) => y))
      .filter((x) => x !== dWord && x !== a && x !== b && x !== c && !related(c, x));
    if (pool.length < nOptions - 1) continue;
    const options = rng.shuffle([dWord, ...pool.slice(0, nOptions - 1)]).map(w);
    const item: PsychoItem = {
      type: "analogies",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "analogy", a: w(a), b: w(b), c: w(c) },
      options,
      answerIndex: options.indexOf(w(dWord)),
      explanation: {
        key: `analogy_${relation}`,
        values: { a: w(a), b: w(b), c: w(c), d: w(dWord) },
      },
    };
    if (verifyAnalogy(item).ok) return item;
  }
  return null;
}

export function verifyAnalogy(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  if (item.presentation.kind !== "analogy") return { ok: false as const, reason: "presentation" };
  const a = unw(item.presentation.a);
  const b = unw(item.presentation.b);
  const c = unw(item.presentation.c);
  const answer = unw(item.options[item.answerIndex]);
  // la relación a→b debe ser la misma que c→respuesta
  const rel = (Object.keys(RELATIONS) as Relation[]).filter((r) =>
    RELATIONS[r].some(([x, y]) => x === a && y === b),
  );
  if (rel.length !== 1) return { ok: false as const, reason: "relation" };
  if (!RELATIONS[rel[0]].some(([x, y]) => x === c && y === answer))
    return { ok: false as const, reason: "answer" };
  for (const [i, o] of item.options.entries()) {
    if (i === item.answerIndex) continue;
    const x = unw(o);
    if (related(c, x)) return { ok: false as const, reason: "ambiguous" };
    if ([a, b, c].includes(x)) return { ok: false as const, reason: "repeated_word" };
  }
  return { ok: true as const };
}

export const analogies: PsychoGenerator = {
  type: "analogies",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar una analogía (seed=${seed})`);
    return item;
  },
  verify: verifyAnalogy,
};

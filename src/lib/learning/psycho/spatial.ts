/**
 * Razonamiento espacial: piezas (poliominós) en una cuadrícula 4×4.
 * Pregunta: qué opción es la misma pieza GIRADA en el plano (sin voltearla).
 *
 * Solo se usan piezas quirales y sin simetría de giro, de modo que:
 *  - las imágenes en espejo nunca coinciden con ningún giro (distractores
 *    válidos), y
 *  - el giro correcto es visualmente distinto del original.
 * La verificación normaliza cada opción y comprueba que exactamente una es un
 * giro del original.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

const G = 4;
type Pt = [number, number];

const key = (pts: Pt[]) =>
  normalize(pts)
    .map(([x, y]) => `${x},${y}`)
    .join(";");

export function normalize(pts: Pt[]): Pt[] {
  const minX = Math.min(...pts.map((p) => p[0]));
  const minY = Math.min(...pts.map((p) => p[1]));
  return pts.map(([x, y]) => [x - minX, y - minY] as Pt).sort((a, b) => a[1] - b[1] || a[0] - b[0]);
}

export const rotate = (pts: Pt[]): Pt[] => normalize(pts.map(([x, y]) => [-y, x] as Pt));
export const mirror = (pts: Pt[]): Pt[] => normalize(pts.map(([x, y]) => [-x, y] as Pt));

export function rotations(pts: Pt[]): Pt[][] {
  const out = [normalize(pts)];
  for (let i = 0; i < 3; i++) out.push(rotate(out[out.length - 1]));
  return out;
}

export function toToken(pts: Pt[]): string {
  const n = normalize(pts);
  const bits = Array.from({ length: G * G }, () => "0");
  for (const [x, y] of n) bits[y * G + x] = "1";
  return `p:${G}:${bits.join("")}`;
}

export function fromToken(t: string): Pt[] {
  const [, , bits] = t.split(":");
  const pts: Pt[] = [];
  for (let i = 0; i < bits.length; i++) if (bits[i] === "1") pts.push([i % G, Math.floor(i / G)]);
  return pts;
}

/** Pieza conexa aleatoria dentro de la cuadrícula 4×4. */
function randomPiece(rng: Rng, size: number): Pt[] {
  const pts: Pt[] = [[rng.int(0, G - 1), rng.int(0, G - 1)]];
  const has = (x: number, y: number) => pts.some(([a, b]) => a === x && b === y);
  let guard = 0;
  while (pts.length < size && guard++ < 200) {
    const [x, y] = rng.pick(pts);
    const [dx, dy] = rng.pick([
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1],
    ] as const);
    const nx = x + dx;
    const ny = y + dy;
    if (nx >= 0 && ny >= 0 && nx < G && ny < G && !has(nx, ny)) pts.push([nx, ny]);
  }
  return normalize(pts);
}

const fits = (pts: Pt[]) => pts.every(([x, y]) => x < G && y < G);

/** Quiral y sin simetría de giro: 4 giros distintos y el espejo no es ninguno. */
export function isUsable(pts: Pt[]) {
  const rots = rotations(pts).map(key);
  if (new Set(rots).size !== 4) return false;
  const mirrors = rotations(mirror(pts)).map(key);
  return mirrors.every((m) => !rots.includes(m)) && rotations(pts).every(fits);
}

const SIZE: Record<Difficulty, number> = { 1: 4, 2: 4, 3: 5, 4: 5, 5: 6 };

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 400; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const piece = randomPiece(rng, SIZE[d]);
    if (piece.length !== SIZE[d] || !isUsable(piece)) continue;
    const rots = rotations(piece);
    const turns = rng.int(1, 3);
    const answer = toToken(rots[turns]);
    const mirrors = rotations(mirror(piece)).map(toToken);
    const pool = new Set<string>(rng.shuffle(mirrors));
    // dificultad alta: añade piezas «casi iguales» (una celda movida)
    if (d >= 4) {
      for (let k = 0; k < 6; k++) {
        const alt = randomPiece(rng, SIZE[d]);
        const altKey = rotations(alt).map(key);
        if (alt.length === SIZE[d] && !altKey.includes(key(piece)) && rotations(alt).every(fits))
          pool.add(toToken(alt));
      }
    }
    pool.delete(answer);
    const distractors = rng.shuffle([...pool]).slice(0, 3);
    if (distractors.length < 3) continue;
    const options = rng.shuffle([answer, ...distractors]);
    const item: PsychoItem = {
      type: "spatial",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "figure", key: "rotation", figure: toToken(piece) },
      options,
      answerIndex: options.indexOf(answer),
      explanation: { key: "spatial_rotation", values: { deg: turns * 90 } },
    };
    if (verifySpatial(item).ok) return item;
  }
  return null;
}

export function verifySpatial(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  if (item.presentation.kind !== "figure") return { ok: false as const, reason: "presentation" };
  const piece = fromToken(item.presentation.figure);
  if (!isUsable(piece)) return { ok: false as const, reason: "symmetric_piece" };
  const rotKeys = rotations(piece).map(key);
  const original = key(piece);
  const correct = item.options.filter((o) => {
    const k = key(fromToken(o));
    return rotKeys.includes(k);
  });
  if (correct.length !== 1) return { ok: false as const, reason: "ambiguous" };
  if (correct[0] !== item.options[item.answerIndex])
    return { ok: false as const, reason: "answer" };
  if (key(fromToken(correct[0])) === original) return { ok: false as const, reason: "not_rotated" };
  return { ok: true as const };
}

export const spatial: PsychoGenerator = {
  type: "spatial",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar una pieza (seed=${seed})`);
    return item;
  },
  verify: verifySpatial,
};

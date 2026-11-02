/**
 * Matrices visuales 3×3 (tipo Raven simplificado). Cada atributo de la figura
 * (forma, número, relleno, giro) sigue una regla: constante, por filas, por
 * columnas o «cuadrado latino» (cada fila y columna contiene los tres valores).
 *
 * Verificación: para cada atributo se calculan TODAS las reglas que encajan
 * con las 8 celdas visibles; si predicen valores distintos, el ítem es
 * ambiguo y se descarta. Los distractores difieren de la solución en al menos
 * un atributo visible.
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

export type Cell = { shape: string; count: number; fill: string; rot: number };
type Attr = keyof Cell;
type RuleKind = "const" | "row" | "col" | "latin";

const SHAPES = ["circle", "square", "triangle", "diamond"] as const;
const ROTATING = ["triangle", "arrow"] as const;
const FILLS = ["f", "e", "h"] as const;
const SYMMETRIC = new Set(["circle", "square", "diamond"]);

/** Token canónico: las formas simétricas no muestran giro. */
export const cellToken = (c: Cell) =>
  `g:${c.shape}:${c.count}:${c.fill}:${SYMMETRIC.has(c.shape) ? 0 : c.rot}`;

export function parseToken(t: string): Cell {
  const [, shape, count, fill, rot] = t.split(":");
  return { shape, count: Number(count), fill, rot: Number(rot) };
}

const valueAt = (
  kind: RuleKind,
  vals: (string | number)[],
  r: number,
  c: number,
  shift: number,
) => {
  switch (kind) {
    case "const":
      return vals[0];
    case "row":
      return vals[r];
    case "col":
      return vals[c];
    case "latin":
      return vals[(c + shift * r) % 3];
  }
};

/** Predicciones de todas las reglas que encajan con las celdas visibles (índice 8 = oculta). */
export function predictions(cells: (string | number | null)[]): Set<string | number> {
  const vis = (r: number, c: number) => cells[r * 3 + c];
  const out = new Set<string | number>();
  const visible = cells.filter((x) => x !== null);
  // constante
  if (new Set(visible).size === 1) out.add(visible[0]!);
  // por filas: cada fila constante
  const rowsConst = [0, 1, 2].every((r) => {
    const v = [0, 1, 2].map((c) => vis(r, c)).filter((x) => x !== null);
    return new Set(v).size === 1;
  });
  if (rowsConst) out.add(vis(2, 0)!);
  // por columnas
  const colsConst = [0, 1, 2].every((c) => {
    const v = [0, 1, 2].map((r) => vis(r, c)).filter((x) => x !== null);
    return new Set(v).size === 1;
  });
  if (colsConst) out.add(vis(0, 2)!);
  // cuadrado latino: 3 valores; cada fila y columna sin repetir
  const values = [...new Set(visible)];
  if (values.length === 3) {
    const okLines = [0, 1, 2].every((i) => {
      const row = [0, 1, 2].map((c) => vis(i, c)).filter((x) => x !== null);
      const col = [0, 1, 2].map((r) => vis(r, i)).filter((x) => x !== null);
      return new Set(row).size === row.length && new Set(col).size === col.length;
    });
    if (okLines) {
      const row2 = [vis(2, 0), vis(2, 1)];
      const missing = values.filter((v) => !row2.includes(v));
      if (missing.length === 1) out.add(missing[0]);
    }
  }
  return out;
}

const ATTRS: Attr[] = ["shape", "count", "fill", "rot"];

function pickVals(rng: Rng, attr: Attr, n: number, shape?: string): (string | number)[] {
  switch (attr) {
    case "shape":
      return rng.shuffle(SHAPES).slice(0, n);
    case "count":
      return rng.shuffle([1, 2, 3]).slice(0, n);
    case "fill":
      return rng.shuffle(FILLS).slice(0, n);
    case "rot":
      void shape;
      return rng.shuffle([0, 90, 180, 270]).slice(0, n);
  }
}

const VARYING: Record<Difficulty, number> = { 1: 1, 2: 2, 3: 2, 4: 3, 5: 3 };

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 300; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const useRot = d === 5 || (d >= 3 && rng.next() < 0.3);
    // atributos que varían (el giro solo con forma constante y asimétrica)
    const candidates: Attr[] = useRot ? ["rot", "count", "fill"] : ["shape", "count", "fill"];
    const varying = rng.shuffle(candidates).slice(0, VARYING[d]);
    const kinds: Partial<Record<Attr, RuleKind>> = {};
    const vals: Partial<Record<Attr, (string | number)[]>> = {};
    const shifts: Partial<Record<Attr, number>> = {};
    for (const attr of ATTRS) {
      if (varying.includes(attr)) {
        const allowed: RuleKind[] =
          d === 1 ? ["col"] : d === 2 ? ["row", "col"] : ["row", "col", "latin"];
        kinds[attr] = rng.pick(allowed);
        vals[attr] = pickVals(rng, attr, 3);
        shifts[attr] = rng.pick([1, 2]);
      } else {
        kinds[attr] = "const";
        if (attr === "shape") vals[attr] = [useRot ? rng.pick(ROTATING) : rng.pick(SHAPES)];
        else if (attr === "rot") vals[attr] = [0];
        else vals[attr] = pickVals(rng, attr, 1);
      }
    }
    // al menos una regla latina en dificultad 3+ para que no baste con mirar una línea
    if (d >= 3 && !varying.some((a) => kinds[a] === "latin")) continue;

    const grid: Cell[] = [];
    for (let r = 0; r < 3; r++)
      for (let c = 0; c < 3; c++) {
        const cell = {} as Record<Attr, string | number>;
        for (const attr of ATTRS)
          cell[attr] = valueAt(kinds[attr]!, vals[attr]!, r, c, shifts[attr]!)!;
        grid.push(cell as Cell);
      }
    const answer = grid[8];
    const answerToken = cellToken(answer);

    // distractores: cambiar un atributo (o dos) de la solución
    const pool = new Set<string>();
    for (const attr of rng.shuffle(ATTRS)) {
      const alts: (string | number)[] =
        attr === "shape"
          ? useRot
            ? []
            : [...SHAPES]
          : attr === "count"
            ? [1, 2, 3]
            : attr === "fill"
              ? [...FILLS]
              : useRot
                ? [0, 90, 180, 270]
                : [];
      for (const v of rng.shuffle(alts)) {
        const t = cellToken({ ...answer, [attr]: v });
        if (t !== answerToken) pool.add(t);
      }
    }
    const nOptions = d >= 4 ? 6 : 4;
    const distractors = rng.shuffle([...pool]).slice(0, nOptions - 1);
    if (distractors.length < nOptions - 1) continue;
    const options = rng.shuffle([answerToken, ...distractors]);
    const item: PsychoItem = {
      type: "matrices",
      seed,
      difficulty: d,
      version: 1,
      presentation: { kind: "matrix", size: 3, cells: [...grid.slice(0, 8).map(cellToken), null] },
      options,
      answerIndex: options.indexOf(answerToken),
      explanation: {
        key: "matrix",
        values: {
          shape: kinds.shape!,
          count: kinds.count!,
          fill: kinds.fill!,
          rot: kinds.rot!,
        },
      },
    };
    if (verifyMatrix(item).ok) return item;
  }
  return null;
}

export function verifyMatrix(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  const p = item.presentation;
  if (p.kind !== "matrix" || p.size !== 3 || p.cells.length !== 9 || p.cells[8] !== null)
    return { ok: false as const, reason: "presentation" };
  if (p.cells.slice(0, 8).some((c) => c === null)) return { ok: false as const, reason: "cells" };
  const parsed = p.cells.map((c) => (c ? parseToken(c) : null));
  // el giro solo se juzga en formas asimétricas
  const expected: Partial<Cell> = {};
  for (const attr of ATTRS) {
    const column = parsed.map((c) =>
      c === null ? null : attr === "rot" && SYMMETRIC.has(c.shape) ? 0 : c[attr],
    );
    const preds = predictions(column);
    if (preds.size !== 1) return { ok: false as const, reason: `ambiguous_${attr}` };
    (expected as Record<string, unknown>)[attr] = [...preds][0];
  }
  const expectedToken = cellToken(expected as Cell);
  if (item.options[item.answerIndex] !== expectedToken)
    return { ok: false as const, reason: "answer" };
  if (item.options.filter((o) => o === expectedToken).length !== 1)
    return { ok: false as const, reason: "duplicate_options" };
  return { ok: true as const };
}

export const matrices: PsychoGenerator = {
  type: "matrices",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar una matriz (seed=${seed})`);
    return item;
  },
  verify: verifyMatrix,
};

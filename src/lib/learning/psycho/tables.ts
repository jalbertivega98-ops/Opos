/**
 * Interpretación de tablas (aptitud administrativa del examen de la AGE: dos
 * tablas con 6 preguntas cada una). Se genera una tabla de datos y una
 * pregunta sobre ella: qué grupo suma o promedia más, qué porcentaje
 * representa un grupo, qué fila cumple varias condiciones…
 * La solución se recalcula leyendo la tabla tal y como se muestra, y solo se
 * aceptan preguntas con una única respuesta (sin empates entre opciones).
 */
import { createRng, mixSeed, type Rng } from "../prng";
import { dec, parseDec, percent } from "./format";
import { verifyCommon, type Difficulty, type PsychoGenerator, type PsychoItem } from "./types";

type Col =
  | { id: string; kind: "label"; values: string[] }
  | { id: string; kind: "cat"; values: string[] }
  | { id: string; kind: "num"; min: number; max: number; decimals: number; pick?: number[] };

type Theme = {
  id: string;
  cols: Col[];
  /** Preguntas de grupo: [columna categórica, columna numérica]. */
  groups: [string, string][];
  /** Cociente por grupo: [cat, numerador, denominador]. */
  ratios: [string, string, string][];
  /** Cociente por fila (porcentaje), opciones = etiquetas. */
  rowRatios: [string, string][];
  filter?: { cat: string; year: string; num: string };
};

const THEMES: Theme[] = [
  {
    id: "trips",
    cols: [
      { id: "project", kind: "cat", values: ["A-115", "C-491", "M-254", "C-510"] },
      {
        id: "department",
        kind: "cat",
        values: ["w:dep_admin", "w:dep_marketing", "w:dep_tech", "w:dep_sales"],
      },
      {
        id: "office",
        kind: "cat",
        values: ["Zaragoza", "Valencia", "Bilbao", "Málaga", "Tarragona"],
      },
      { id: "days", kind: "num", min: 0, max: 0, decimals: 1, pick: [0.5, 1, 2, 3] },
      { id: "km", kind: "num", min: 300, max: 1600, decimals: 0 },
      { id: "tolls", kind: "num", min: 5, max: 45, decimals: 2 },
    ],
    groups: [
      ["office", "km"],
      ["department", "days"],
      ["department", "tolls"],
      ["project", "km"],
      ["office", "tolls"],
    ],
    ratios: [["project", "tolls", "km"]],
    rowRatios: [],
  },
  {
    id: "loans",
    cols: [
      {
        id: "title",
        kind: "label",
        values: [
          "El faro del norte",
          "Cielo de agosto",
          "La casa vacía",
          "Mareas",
          "Tiempo de lluvia",
          "El último tren",
          "Voces lejanas",
          "La orilla",
          "Noches de abril",
          "El jardín escondido",
          "Camino al sur",
          "La carta perdida",
        ],
      },
      { id: "publisher", kind: "cat", values: ["Atalaya", "Brisa", "Cauce", "Dintel"] },
      { id: "city", kind: "cat", values: ["Madrid", "Barcelona", "Sevilla"] },
      { id: "year", kind: "num", min: 1995, max: 2004, decimals: 0 },
      { id: "available", kind: "num", min: 4, max: 16, decimals: 0 },
      { id: "lent", kind: "num", min: 1, max: 9, decimals: 0 },
      { id: "loans", kind: "num", min: 100, max: 330, decimals: 0 },
    ],
    groups: [
      ["publisher", "available"],
      ["publisher", "loans"],
      ["publisher", "lent"],
      ["city", "loans"],
    ],
    ratios: [["publisher", "lent", "available"]],
    rowRatios: [
      ["lent", "available"],
      ["lent", "loans"],
    ],
    filter: { cat: "city", year: "year", num: "available" },
  },
];

const ROWS: Record<Difficulty, number> = { 1: 6, 2: 7, 3: 8, 4: 10, 5: 10 };

export const QUESTION_KINDS = [
  "sum_max",
  "avg_max",
  "share",
  "ratio_group",
  "ratio_row",
  "filter",
] as const;
type Kind = (typeof QUESTION_KINDS)[number];

/** Importes con 2 decimales fijos; el resto sin ceros sobrantes ("1", "0,5"). */
const cell = (n: number, decimals: number) =>
  decimals === 0 || (decimals === 1 && Number.isInteger(n)) ? String(n) : dec(n, decimals);

function makeTable(rng: Rng, theme: Theme, n: number): string[][] {
  const labels = theme.cols.find((c) => c.kind === "label");
  const names = labels ? rng.shuffle(labels.values).slice(0, n) : [];
  return Array.from({ length: n }, (_, i) =>
    theme.cols.map((c) => {
      if (c.kind === "label") return names[i];
      if (c.kind === "cat") return rng.pick(c.values);
      if (c.pick) return cell(rng.pick(c.pick), c.decimals);
      const f = 10 ** c.decimals;
      return cell(rng.int(c.min * f, c.max * f) / f, c.decimals);
    }),
  );
}

type Spec = Record<string, string | number>;

const colIndex = (theme: Theme, id: string) => theme.cols.findIndex((c) => c.id === id);

/** Valor de cada opción según la pregunta; null si la pregunta no es válida. */
function scores(theme: Theme, rows: string[][], spec: Spec, options: string[]): number[] | null {
  const kind = spec.q as Kind;
  const col = (key: string) => colIndex(theme, String(spec[key]));
  const num = (r: string[], key: string) => parseDec(r[col(key)]);
  switch (kind) {
    case "sum_max":
    case "avg_max": {
      return options.map((o) => {
        const sel = rows.filter((r) => r[col("cat")] === o);
        if (sel.length === 0) return Number.NaN;
        const s = sel.reduce((a, r) => a + num(r, "num"), 0);
        return kind === "sum_max" ? s : s / sel.length;
      });
    }
    case "ratio_group":
      return options.map((o) => {
        const sel = rows.filter((r) => r[col("cat")] === o);
        const den = sel.reduce((a, r) => a + num(r, "den"), 0);
        return den === 0 ? Number.NaN : sel.reduce((a, r) => a + num(r, "num"), 0) / den;
      });
    case "ratio_row":
      return options.map((o) => {
        const r = rows.find((x) => x[col("label")] === o);
        return r ? num(r, "num") / num(r, "den") : Number.NaN;
      });
    case "filter":
      return options.map((o) => {
        const r = rows.find((x) => x[col("label")] === o);
        if (!r) return Number.NaN;
        const ok =
          r[col("cat")] === spec.value &&
          num(r, "year") > Number(spec.y) &&
          num(r, "num") > Number(spec.k);
        return ok ? 1 : 0;
      });
    case "share":
      return null;
  }
}

/** Respuesta correcta recalculada desde la tabla y la pregunta. */
export function solveTable(themeId: string, rows: string[][], spec: Spec, options: string[]) {
  const theme = THEMES.find((t) => t.id === themeId);
  if (!theme) return null;
  if (spec.q === "share") {
    const c = colIndex(theme, String(spec.cat));
    const n = colIndex(theme, String(spec.num));
    const total = rows.reduce((a, r) => a + parseDec(r[n]), 0);
    const part = rows.filter((r) => r[c] === spec.value).reduce((a, r) => a + parseDec(r[n]), 0);
    return total > 0 ? percent((part * 100) / total) : null;
  }
  const s = scores(theme, rows, spec, options);
  if (!s || s.some((x) => !Number.isFinite(x))) return null;
  const max = Math.max(...s);
  const best = s.filter((x) => Math.abs(x - max) < 1e-9);
  if (best.length !== 1) return null;
  // sin casi-empates que dependan del redondeo
  const second = Math.max(...s.filter((x) => x !== max));
  if (spec.q !== "filter" && max - second < Math.abs(max) * 0.01) return null;
  return options[s.indexOf(max)];
}

function question(rng: Rng, theme: Theme, rows: string[][], d: Difficulty) {
  const kinds: Kind[] = ["sum_max", "share"];
  if (d >= 2) kinds.push("avg_max");
  if (d >= 3 && theme.ratios.length) kinds.push("ratio_group");
  if (d >= 3 && theme.rowRatios.length) kinds.push("ratio_row");
  if (theme.filter) kinds.push("filter");
  const q = rng.pick(kinds);
  const present = (id: string) => [...new Set(rows.map((r) => r[colIndex(theme, id)]))];
  const label = theme.cols.find((c) => c.kind === "label");

  if (q === "sum_max" || q === "avg_max" || q === "share") {
    const [cat, num] = rng.pick(theme.groups);
    const values = present(cat);
    if (values.length < 4) return null;
    if (q === "share") {
      const value = rng.pick(values);
      const spec: Spec = { q, cat, num, value };
      const answer = solveTable(theme.id, rows, spec, []);
      if (!answer) return null;
      const others = values
        .filter((v) => v !== value)
        .map((v) => solveTable(theme.id, rows, { ...spec, value: v }, []));
      const a = parseDec(answer);
      const traps = [...others, percent(a + 1.5), percent(a - 2.25), percent(a * 1.1)];
      return { spec, answer, traps: traps.filter((t): t is string => !!t && !t.startsWith("-")) };
    }
    const options = rng.shuffle(values).slice(0, 4);
    const spec: Spec = { q, cat, num };
    const answer = solveTable(theme.id, rows, spec, options);
    return answer ? { spec, answer, options } : null;
  }
  if (q === "ratio_group") {
    const [cat, num, den] = rng.pick(theme.ratios);
    const values = present(cat);
    if (values.length < 4) return null;
    const options = rng.shuffle(values).slice(0, 4);
    const spec: Spec = { q, cat, num, den };
    const answer = solveTable(theme.id, rows, spec, options);
    return answer ? { spec, answer, options } : null;
  }
  if (!label) return null;
  if (q === "ratio_row") {
    const [num, den] = rng.pick(theme.rowRatios);
    const options = rng.shuffle(present(label.id)).slice(0, 4);
    const spec: Spec = { q, label: label.id, num, den };
    const answer = solveTable(theme.id, rows, spec, options);
    return answer ? { spec, answer, options } : null;
  }
  // filter: una fila cumple las tres condiciones y otras tres fallan alguna
  const f = theme.filter!;
  const target = rng.pick(rows);
  const yIdx = colIndex(theme, f.year);
  const nIdx = colIndex(theme, f.num);
  const spec: Spec = {
    q,
    label: label.id,
    cat: f.cat,
    year: f.year,
    num: f.num,
    value: target[colIndex(theme, f.cat)],
    y: parseDec(target[yIdx]) - rng.int(1, 3),
    k: Math.max(0, parseDec(target[nIdx]) - rng.int(1, 3)),
  };
  const labels = present(label.id).filter((l) => l !== target[colIndex(theme, label.id)]);
  const failing = labels.filter((l) => {
    const r = rows.find((x) => x[colIndex(theme, label.id)] === l)!;
    return !(
      r[colIndex(theme, f.cat)] === spec.value &&
      parseDec(r[yIdx]) > Number(spec.y) &&
      parseDec(r[nIdx]) > Number(spec.k)
    );
  });
  // preferir distractores que cumplen alguna condición (más plausibles)
  const plausible = failing.filter((l) => {
    const r = rows.find((x) => x[colIndex(theme, label.id)] === l)!;
    return r[colIndex(theme, f.cat)] === spec.value || parseDec(r[yIdx]) > Number(spec.y);
  });
  const pool = [...rng.shuffle(plausible), ...rng.shuffle(failing)];
  const picked = [...new Set(pool)].slice(0, 3);
  if (picked.length < 3) return null;
  const options = rng.shuffle([target[colIndex(theme, label.id)], ...picked]);
  const answer = solveTable(theme.id, rows, spec, options);
  return answer ? { spec, answer, options } : null;
}

/** Textos (tokens traducibles) de la pregunta. */
function display(theme: Theme, spec: Spec): Record<string, string | number> {
  const w = (prefix: string, id: unknown) => `w:${prefix}_${String(id)}`;
  const out: Record<string, string | number> = { table: w("tbl", theme.id) };
  if (spec.cat) out.catName = w("cat", spec.cat);
  if (spec.num) out.numName = w("num", spec.num);
  if (spec.den) out.denName = w("num", spec.den);
  if (spec.den) out.denUnit = w("unit", spec.den);
  if (spec.label) out.labelName = w("cat", spec.label);
  if (spec.value !== undefined) out.value = spec.value;
  if (spec.y !== undefined) out.y = spec.y;
  if (spec.k !== undefined) out.k = spec.k;
  return out;
}

function build(seed: number, d: Difficulty): PsychoItem | null {
  for (let attempt = 0; attempt < 300; attempt++) {
    const rng = createRng(mixSeed(seed, attempt));
    const theme = rng.pick(THEMES);
    const rows = makeTable(rng, theme, ROWS[d]);
    const qn = question(rng, theme, rows, d);
    if (!qn) continue;
    let options: string[];
    if ("options" in qn && qn.options) {
      options = qn.options;
    } else {
      const traps = [...new Set(qn.traps)].filter((t) => t !== qn.answer);
      if (traps.length < 3) continue;
      options = rng.shuffle([qn.answer, ...rng.shuffle(traps).slice(0, 3)]);
    }
    if (options.length !== 4) continue;
    const spec = { theme: theme.id, ...qn.spec };
    const item: PsychoItem = {
      type: "tables",
      seed,
      difficulty: d,
      version: 1,
      presentation: {
        kind: "table",
        key: `tables_${qn.spec.q}`,
        values: { ...spec, ...display(theme, qn.spec) },
        header: theme.cols.map((c) => `w:col_${c.id}`),
        rows,
      },
      options,
      answerIndex: options.indexOf(qn.answer),
      explanation: { key: `tables_${qn.spec.q}`, values: { answer: qn.answer } },
    };
    if (verifyTable(item).ok) return item;
  }
  return null;
}

export function verifyTable(item: PsychoItem) {
  const common = verifyCommon(item);
  if (!common.ok) return common;
  const p = item.presentation;
  if (p.kind !== "table") return { ok: false as const, reason: "presentation" };
  const spec = (p.values ?? {}) as Spec;
  const theme = THEMES.find((t) => t.id === spec.theme);
  if (!theme || p.header.length !== theme.cols.length)
    return { ok: false as const, reason: "theme" };
  if (p.rows.some((r) => r.length !== theme.cols.length))
    return { ok: false as const, reason: "rows" };
  const answer = solveTable(theme.id, p.rows, spec, item.options);
  if (answer === null || item.options[item.answerIndex] !== answer)
    return { ok: false as const, reason: "answer" };
  if (item.options.filter((o) => o === answer).length !== 1)
    return { ok: false as const, reason: "ambiguous" };
  return { ok: true as const };
}

export const tables: PsychoGenerator = {
  type: "tables",
  version: 1,
  generate(seed, difficulty) {
    const item = build(seed, difficulty);
    if (!item) throw new Error(`No se pudo generar un ejercicio de tablas (seed=${seed})`);
    return item;
  },
  verify: verifyTable,
};

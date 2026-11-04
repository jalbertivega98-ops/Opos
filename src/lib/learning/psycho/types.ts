/**
 * Contrato común de los generadores de psicotécnicos (ADR-012, ADR-014).
 *
 * Cada generador es puro y determinista: `generate(seed, difficulty)` devuelve
 * siempre el mismo ítem, de modo que el servidor puede regenerarlo para
 * corregir sin enviar nunca la solución al cliente antes de responder.
 */
export type Difficulty = 1 | 2 | 3 | 4 | 5;

export const PSYCHO_TYPES = [
  "series",
  "letters",
  "numeric",
  "analogies",
  "matrices",
  "spatial",
  "attention",
  "percentages",
  "equations",
  "probability",
  "codes",
  "tables",
] as const;
export type PsychoType = (typeof PSYCHO_TYPES)[number];

/**
 * Cómo se muestra el enunciado. La UI decide el renderizado según `kind`.
 * Los textos de celdas y opciones son tokens: "w:<id>" palabra traducible,
 * "g:<forma>:<n>:<relleno>:<giro>" figura, "p:<n>:<bits>" pieza en cuadrícula;
 * cualquier otro valor se muestra literalmente.
 */
export type Presentation =
  | { kind: "sequence"; terms: string[] }
  | { kind: "text"; key: string; values?: Record<string, string | number> }
  | { kind: "analogy"; a: string; b: string; c: string }
  | { kind: "matrix"; size: number; cells: (string | null)[] }
  | { kind: "figure"; key: string; figure: string }
  | { kind: "grid"; key: string; values?: Record<string, string | number>; rows: string[] }
  | {
      kind: "table";
      key: string;
      values?: Record<string, string | number>;
      header: string[];
      rows: string[][];
    };

/** Explicación estructurada: clave i18n bajo `psycho.rules` + valores. */
export type Explanation = { key: string; values?: Record<string, string | number> };

export type PsychoItem = {
  type: PsychoType;
  seed: number;
  difficulty: Difficulty;
  /** Versión del generador: si cambia la lógica, se incrementa. */
  version: number;
  presentation: Presentation;
  options: string[];
  answerIndex: number; // NUNCA se envía al cliente antes de responder
  explanation: Explanation; // tampoco
};

export type PublicPsychoItem = Omit<PsychoItem, "answerIndex" | "explanation">;

export type Verification = { ok: true } | { ok: false; reason: string };

export interface PsychoGenerator {
  type: PsychoType;
  version: number;
  generate(seed: number, difficulty: Difficulty): PsychoItem;
  /** Recalcula la solución y comprueba no ambigüedad y opciones únicas. */
  verify(item: PsychoItem): Verification;
}

export const toPublicItem = (item: PsychoItem): PublicPsychoItem => ({
  type: item.type,
  seed: item.seed,
  difficulty: item.difficulty,
  version: item.version,
  presentation: item.presentation,
  options: item.options,
});

/** Comprobaciones comunes a todos los generadores. */
export function verifyCommon(item: PsychoItem): Verification {
  if (item.options.length < 3 || item.options.length > 6) return { ok: false, reason: "options" };
  if (new Set(item.options).size !== item.options.length)
    return { ok: false, reason: "duplicate_options" };
  if (item.answerIndex < 0 || item.answerIndex >= item.options.length)
    return { ok: false, reason: "answer_index" };
  if (item.options.some((o) => o.trim() === "")) return { ok: false, reason: "empty_option" };
  return { ok: true };
}

/** JSON con claves ordenadas (jsonb de Postgres reordena las claves). */
export function canonical(v: unknown): string {
  if (Array.isArray(v)) return `[${v.map(canonical).join(",")}]`;
  if (v && typeof v === "object")
    return `{${Object.keys(v)
      .sort()
      .map((k) => `${JSON.stringify(k)}:${canonical((v as Record<string, unknown>)[k])}`)
      .join(",")}}`;
  return JSON.stringify(v);
}

type Shown = Pick<PublicPsychoItem, "presentation" | "options">;

/** ¿Se mostró exactamente este ítem? (detecta cambios de generador entre versiones). */
export const samePresentation = (a: Shown, b: Shown) =>
  canonical([a.presentation, a.options]) === canonical([b.presentation, b.options]);

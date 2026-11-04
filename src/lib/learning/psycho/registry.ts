import { analogies } from "./analogies";
import { attention } from "./attention";
import { codes } from "./codes";
import { equations } from "./equations";
import { percentages } from "./percentages";
import { probability } from "./probability";
import { tables } from "./tables";
import { letters } from "./letters";
import { matrices } from "./matrices";
import { numeric } from "./numeric";
import { generateSeries, verifySeries, type SeriesItem, type SeriesRule } from "./series";
import { spatial } from "./spatial";
import {
  verifyCommon,
  type Difficulty,
  type Explanation,
  type PsychoGenerator,
  type PsychoItem,
  type PsychoType,
} from "./types";

const sign = (n: number) => (n > 0 ? `+${n}` : String(n));

export function explainSeries(rule: SeriesRule): Explanation {
  switch (rule.kind) {
    case "arithmetic":
      return { key: "arithmetic", values: { step: sign(rule.step) } };
    case "geometric":
      return { key: "geometric", values: { ratio: rule.ratio } };
    case "alternating":
      return { key: "alternating", values: { stepA: sign(rule.stepA), stepB: sign(rule.stepB) } };
    case "second_order":
      return { key: "second_order", values: { step: rule.step, delta: rule.delta } };
    case "fibonacci":
      return { key: "fibonacci" };
    case "interleaved":
      return {
        key: "interleaved",
        values: {
          startA: rule.startA,
          stepA: sign(rule.stepA),
          startB: rule.startB,
          stepB: sign(rule.stepB),
        },
      };
  }
}

const seriesCache = new WeakMap<PsychoItem, SeriesItem>();

const series: PsychoGenerator = {
  type: "series",
  version: 1,
  generate(seed, difficulty) {
    const s = generateSeries(seed, difficulty);
    const item: PsychoItem = {
      type: "series",
      seed,
      difficulty,
      version: 1,
      presentation: { kind: "sequence", terms: s.terms.map(String) },
      options: s.options.map(String),
      answerIndex: s.answerIndex,
      explanation: explainSeries(s.rule),
    };
    seriesCache.set(item, s);
    return item;
  },
  verify(item) {
    const common = verifyCommon(item);
    if (!common.ok) return common;
    const s = seriesCache.get(item) ?? generateSeries(item.seed, item.difficulty);
    const v = verifySeries(s);
    if (!v.ok) return { ok: false, reason: v.reason ?? "series" };
    if (item.options[item.answerIndex] !== String(s.options[s.answerIndex]))
      return { ok: false, reason: "answer" };
    return { ok: true };
  },
};

/** Orden = orden de presentación en la interfaz. */
const GENERATORS: Partial<Record<PsychoType, PsychoGenerator>> = {
  series,
  letters,
  numeric,
  analogies,
  matrices,
  spatial,
  attention,
  percentages,
  equations,
  probability,
  codes,
  tables,
};

export function getGenerator(type: PsychoType): PsychoGenerator | undefined {
  return GENERATORS[type];
}

export const availableTypes = (): PsychoType[] => Object.keys(GENERATORS) as PsychoType[];

/**
 * Tipos de un simulacro de psicotécnicos que no fija los suyos (formato Mossos
 * 46/26): los 7 generales. Los del formato AGE (porcentajes, ecuaciones,
 * probabilidad, códigos y tablas) solo entran si el producto los pide.
 */
export const GENERAL_TYPES: PsychoType[] = [
  "series",
  "letters",
  "numeric",
  "analogies",
  "matrices",
  "spatial",
  "attention",
];

export function generateItem(type: PsychoType, seed: number, difficulty: Difficulty): PsychoItem {
  const g = getGenerator(type);
  if (!g) throw new Error(`Generador no disponible: ${type}`);
  return g.generate(seed, difficulty);
}

/** Plan de dificultad creciente para una sesión de `count` ítems. */
export function difficultyPlan(count: number, fixed?: Difficulty): Difficulty[] {
  if (fixed) return Array.from({ length: count }, () => fixed);
  return Array.from(
    { length: count },
    (_, i) => Math.min(5, 1 + Math.floor((i * 5) / count)) as Difficulty,
  );
}

import { examHasPsycho } from "@/lib/catalog/exam-format";
import { examGuides, getExamGuide, type ExamGuide, type ExamPart } from "./exam-guides";

/**
 * Páginas «Psicotécnicos de <oposición> gratis» (ADR-063). Solo para oposiciones cuya
 * convocatoria incluye psicotécnico (`examHasPsycho`) y cuya guía ya enlaza tipos de
 * OPOSAPRUEBA. El formato oficial sale de la parte de la guía indicada aquí (datos de
 * las bases ya verificados en exam-guides.ts); no se añade ninguna cifra nueva.
 */
const PSYCHO_PART: Record<string, number> = {
  "mossos-esquadra": 1,
  "auxiliar-administrativo-estado": 0,
  "guardia-urbana-barcelona": 1,
  "policia-local": 1,
};

export type ExamPsycho = { guide: ExamGuide; part: ExamPart | undefined };

export function getExamPsycho(slug: string): ExamPsycho | undefined {
  const guide = getExamGuide(slug);
  if (!guide || !examHasPsycho(slug) || guide.psychoTypes.length === 0) return undefined;
  const i = PSYCHO_PART[slug];
  return { guide, part: i === undefined ? undefined : guide.parts[i] };
}

export const examPsychoSlugs = (): string[] =>
  examGuides()
    .map((g) => g.slug)
    .filter((slug) => !!getExamPsycho(slug));

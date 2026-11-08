import "server-only";
import { createPublicClient } from "@/lib/supabase/public";
import type { SampleQuestion } from "./schema";

/** Preguntas en el test gratis: menos de esto no merece página propia. */
export const SAMPLE_SIZE = 10;
export const SAMPLE_MIN = 5;

type Row = {
  id: string;
  stem: string;
  options: string[] | null;
  ref: string | null;
  locale: string;
  topic_title: string | null;
  topic_title_ca: string | null;
};

/**
 * Muestra del día de los temas gratis de una oposición (cambia cada día).
 * Si la base de datos no responde, devuelve lista vacía.
 */
export async function examSampleQuestions(
  examSlug: string,
  locale: string,
): Promise<SampleQuestion[]> {
  try {
    const { data, error } = await createPublicClient().rpc("exam_sample_questions", {
      p_exam_slug: examSlug,
      p_limit: SAMPLE_SIZE,
    });
    if (error || !Array.isArray(data)) return [];
    return (data as Row[])
      .filter((r) => Array.isArray(r.options) && r.options.length >= 2)
      .map((r) => ({
        id: r.id,
        stem: r.stem,
        options: r.options ?? [],
        ref: r.ref,
        locale: r.locale,
        topic: (locale === "ca" ? r.topic_title_ca : null) ?? r.topic_title,
      }));
  } catch {
    return [];
  }
}

import "server-only";
import { createPublicClient } from "@/lib/supabase/public";
import { getExamGuide } from "./exam-guides";

export type PublicExam = {
  slug: string;
  name: string;
  name_ca: string | null;
  short_description: string | null;
  availability: "available" | "partial" | "coming_soon";
  updated_at: string | null;
};

/**
 * Oposiciones publicadas. Si la BD no responde (p. ej. en el build), devuelve
 * lista vacía para que sitemap y llms.txt sigan funcionando.
 */
export async function listPublicExams(): Promise<PublicExam[]> {
  try {
    const { data, error } = await createPublicClient()
      .from("exam_bodies")
      .select("slug, name, name_ca, short_description, availability, updated_at")
      .eq("is_published", true)
      .order("sort_order")
      .returns<PublicExam[]>();
    if (error) return [];
    return data ?? [];
  } catch {
    return [];
  }
}

/**
 * Una ficha merece indexarse si tiene contenido propio: preparación disponible
 * o guía del examen con datos oficiales. Las «próximamente» sin guía son finas.
 */
export const isExamIndexable = (exam: { slug: string; availability: string }) =>
  exam.availability !== "coming_soon" || !!getExamGuide(exam.slug);

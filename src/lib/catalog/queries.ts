import "server-only";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { sanitizeSearch } from "./search";

export const CATEGORIES = [
  "seguridad",
  "emergencias",
  "penitenciaria",
  "administracion",
  "justicia",
  "correos",
  "sanidad",
  "educacion",
  "otros",
] as const;
export type Category = (typeof CATEGORIES)[number];
export type Availability = "available" | "partial" | "coming_soon";

export type ExamBodyCard = {
  id: string;
  slug: string;
  name: string;
  name_ca: string | null;
  short_description: string | null;
  short_description_ca: string | null;
  category: Category;
  availability: Availability;
  organization: { name: string; scope: "estatal" | "autonomico" | "local" } | null;
};

export const catalogFilterSchema = z.object({
  q: z.string().trim().max(80).optional().catch(undefined),
  category: z.enum(CATEGORIES).optional().catch(undefined),
});

const CARD_SELECT =
  "id, slug, name, name_ca, short_description, short_description_ca, category, availability, organization:organizations(name, scope)";

export async function listExamBodies(
  filter: z.infer<typeof catalogFilterSchema> = {},
  limit = 100,
) {
  const supabase = await createClient();
  let query = supabase
    .from("exam_bodies")
    .select(CARD_SELECT)
    .eq("is_published", true)
    .order("sort_order")
    .limit(limit);
  if (filter.category) query = query.eq("category", filter.category);
  const q = filter.q ? sanitizeSearch(filter.q) : "";
  if (q) {
    query = query.or(`name.ilike.%${q}%,name_ca.ilike.%${q}%,short_description.ilike.%${q}%`);
  }
  const { data, error } = await query.returns<ExamBodyCard[]>();
  if (error) throw new Error(`catalog: ${error.message}`);
  return data ?? [];
}

export async function getExamBody(slug: string) {
  if (!/^[a-z0-9-]{2,80}$/.test(slug)) return null;
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("exam_bodies")
    .select(
      `${CARD_SELECT},
       calls(id, year, title, status, vacancies, application_end, exam_date, is_published),
       exam_tests(id, name, kind, order_index, question_count, duration_minutes, call_id),
       exam_body_sources(source:sources(id, title, url, kind, verified_at))`,
    )
    .eq("slug", slug)
    .eq("is_published", true)
    .maybeSingle();
  if (error) throw new Error(`catalog: ${error.message}`);
  return data as
    | (ExamBodyCard & {
        calls: {
          id: string;
          year: number;
          title: string;
          status: string;
          vacancies: number | null;
          is_published: boolean;
        }[];
        exam_tests: {
          id: string;
          name: string;
          kind: string;
          order_index: number;
          question_count: number | null;
          duration_minutes: number | null;
        }[];
        exam_body_sources: {
          source: { id: string; title: string; url: string; verified_at: string | null } | null;
        }[];
      })
    | null;
}

export const localized = (locale: string, es: string | null, ca: string | null) =>
  (locale === "ca" && ca) || es || "";

/** Temas públicos de una oposición (tabla de lectura libre), en orden de temario. */
export async function listExamTopics(examBodyId: string) {
  const supabase = await createClient();
  const { data, error } = await supabase
    .from("exam_body_topics")
    .select("order_index, topic:topics(slug, title, title_ca)")
    .eq("exam_body_id", examBodyId)
    .returns<
      {
        order_index: number;
        topic: { slug: string; title: string; title_ca: string | null } | null;
      }[]
    >();
  if (error) throw new Error(`catalog: ${error.message}`);
  return (
    (data ?? [])
      // Los exámenes réplica y el banco de psicotécnicos verbales no son temas del programa
      .flatMap((r) =>
        r.topic && !/-examen-|psicotecnicos/.test(r.topic.slug)
          ? [{ ...r.topic, order: r.order_index }]
          : [],
      )
      .sort((a, b) => a.order - b.order || a.slug.localeCompare(b.slug))
  );
}

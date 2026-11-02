import "server-only";
import { createClient } from "@/lib/supabase/server";
import { sanitizeSearch } from "@/lib/catalog/search";
import type { ContentStatus } from "./schema";

export type QuestionRow = {
  id: string;
  stem: string;
  category: string;
  difficulty: number;
  locale: "es" | "ca";
  status: ContentStatus;
  version: number;
  is_free: boolean;
  ai_generated: boolean;
  updated_at: string;
};

const PAGE = 25;

export async function listQuestions(f: {
  status?: string;
  category?: string;
  q?: string;
  page?: number;
}) {
  const supabase = await createClient();
  const page = Math.max(1, f.page ?? 1);
  let query = supabase
    .from("questions")
    .select(
      "id, stem, category, difficulty, locale, status, version, is_free, ai_generated, updated_at",
      {
        count: "exact",
      },
    )
    .order("updated_at", { ascending: false })
    .range((page - 1) * PAGE, page * PAGE - 1);
  if (f.status) query = query.eq("status", f.status);
  if (f.category) query = query.eq("category", f.category);
  const q = sanitizeSearch(f.q ?? "");
  if (q) query = query.ilike("stem", `%${q}%`);
  const { data, count, error } = await query.returns<QuestionRow[]>();
  if (error) throw new Error(`questions: ${error.message}`);
  return { rows: data ?? [], total: count ?? 0, page, pageSize: PAGE };
}

export async function statusCounts() {
  const supabase = await createClient();
  const { data } = await supabase.rpc("question_status_counts");
  const out: Record<string, number> = {};
  for (const r of (data ?? []) as { status: string; total: number }[])
    out[r.status] = Number(r.total);
  return out;
}

export type QuestionDetail = QuestionRow & {
  explanation: string | null;
  reviewed_at: string | null;
  options: { label: string; body: string; is_correct: boolean }[];
  exam_body_ids: string[];
  reviews: { from_status: string; to_status: string; comment: string | null; created_at: string }[];
};

export async function getQuestion(id: string): Promise<QuestionDetail | null> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("questions")
    .select(
      "id, stem, explanation, category, difficulty, locale, status, version, is_free, ai_generated, updated_at, reviewed_at, options:question_options(label, body, is_correct), exams:question_exam_bodies(exam_body_id), reviews:question_reviews(from_status, to_status, comment, created_at)",
    )
    .eq("id", id)
    .maybeSingle();
  if (!data) return null;
  const d = data as unknown as QuestionDetail & { exams: { exam_body_id: string }[] };
  return {
    ...d,
    options: [...d.options].sort((a, b) => a.label.localeCompare(b.label)),
    exam_body_ids: d.exams.map((e) => e.exam_body_id),
    reviews: [...d.reviews].sort((a, b) => b.created_at.localeCompare(a.created_at)),
  };
}

/** Cola de revisión: preguntas pendientes con su contenido completo. */
export async function reviewQueue(limit = 20) {
  const supabase = await createClient();
  const { data } = await supabase
    .from("questions")
    .select(
      "id, stem, explanation, category, difficulty, locale, status, version, ai_generated, updated_at, options:question_options(label, body, is_correct)",
    )
    .eq("status", "needs_review")
    .order("updated_at", { ascending: true })
    .limit(limit);
  return ((data ?? []) as unknown as QuestionDetail[]).map((q) => ({
    ...q,
    options: [...q.options].sort((a, b) => a.label.localeCompare(b.label)),
  }));
}

export async function examBodyOptions() {
  const supabase = await createClient();
  const { data } = await supabase.from("exam_bodies").select("id, slug, name").order("name");
  return (data ?? []) as { id: string; slug: string; name: string }[];
}

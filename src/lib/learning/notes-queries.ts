import "server-only";
import { createClient } from "@/lib/supabase/server";
import type { ContentStatus } from "@/lib/admin/content/schema";

/** Ficha de estudio de un tema: texto literal de la fuente oficial (CNT-011). */
export type TopicNote = {
  id: string;
  slug: string;
  title: string;
  titleCa: string | null;
  locale: "es" | "ca";
  status: ContentStatus;
  outline: { n: string; title: string }[];
  keyIdeas: string[];
  glossary: string[];
  amendments: { text: string; url?: string }[];
  sourceTitle: string | null;
  sourceUrl: string | null;
  pageFrom: number | null;
  pageTo: number | null;
  keyIdeasPage: number | null;
  reviewNote: string | null;
  updatedAt: string;
};

type Row = {
  id: string;
  locale: "es" | "ca";
  status: ContentStatus;
  outline: unknown;
  key_ideas: unknown;
  glossary: unknown;
  amendments: unknown;
  source_url: string | null;
  page_from: number | null;
  page_to: number | null;
  key_ideas_page: number | null;
  review_note: string | null;
  updated_at: string;
  topic: { slug: string; title: string; title_ca: string | null } | null;
  source: { title: string } | null;
};

const SELECT =
  "id, locale, status, outline, key_ideas, glossary, amendments, source_url, page_from, page_to, key_ideas_page, review_note, updated_at, topic:topics!inner(slug, title, title_ca), source:sources(title)";

const strings = (v: unknown) => (Array.isArray(v) ? v.filter((x) => typeof x === "string") : []);

function toNote(r: Row): TopicNote | null {
  if (!r.topic) return null;
  return {
    id: r.id,
    slug: r.topic.slug,
    title: r.topic.title,
    titleCa: r.topic.title_ca,
    locale: r.locale,
    status: r.status,
    outline: (Array.isArray(r.outline) ? r.outline : []).filter(
      (o): o is { n: string; title: string } =>
        typeof o?.n === "string" && typeof o?.title === "string",
    ),
    keyIdeas: strings(r.key_ideas),
    glossary: strings(r.glossary),
    amendments: (Array.isArray(r.amendments) ? r.amendments : []).filter(
      (a): a is { text: string; url?: string } => typeof a?.text === "string",
    ),
    sourceTitle: r.source?.title ?? null,
    sourceUrl: r.source_url,
    pageFrom: r.page_from,
    pageTo: r.page_to,
    keyIdeasPage: r.key_ideas_page,
    reviewNote: r.review_note,
    updatedAt: r.updated_at,
  };
}

/** Una ficha por slug de tema. La RLS decide: el alumnado solo ve las publicadas. */
export async function getTopicNote(slug: string): Promise<TopicNote | null> {
  const supabase = await createClient();
  const { data } = await supabase
    .from("topic_notes")
    .select(SELECT)
    .eq("topic.slug", slug)
    .limit(1)
    .maybeSingle<Row>();
  return data ? toNote(data) : null;
}

/** Todas las fichas visibles para la persona actual (en admin, también borradores). */
export async function listTopicNotes(): Promise<TopicNote[]> {
  const supabase = await createClient();
  const { data, error } = await supabase.from("topic_notes").select(SELECT).returns<Row[]>();
  if (error) throw new Error(`topic_notes: ${error.message}`);
  return (data ?? [])
    .map(toNote)
    .filter((n): n is TopicNote => n !== null)
    .sort((a, b) => a.slug.localeCompare(b.slug));
}

export type ExamNoteSummary = {
  slug: string;
  title: string;
  titleCa: string | null;
  pageFrom: number | null;
  pageTo: number | null;
  keyIdeas: number;
};

/** Fichas publicadas de la oposición principal del alumno, en orden de temario. */
export async function myExamNotes() {
  const supabase = await createClient();
  const { data: target } = await supabase
    .from("user_exam_targets")
    .select("exam:exam_bodies(slug, name, name_ca)")
    .eq("is_primary", true)
    .maybeSingle<{ exam: { slug: string; name: string; name_ca: string | null } | null }>();
  if (!target?.exam) return { exam: null, notes: [] as ExamNoteSummary[] };
  const { data } = await supabase.rpc("exam_topic_notes", { p_exam_slug: target.exam.slug });
  const notes = (
    (data ?? []) as {
      slug: string;
      title: string;
      title_ca: string | null;
      page_from: number | null;
      page_to: number | null;
      key_ideas: number;
    }[]
  ).map((r) => ({
    slug: r.slug,
    title: r.title,
    titleCa: r.title_ca,
    pageFrom: r.page_from,
    pageTo: r.page_to,
    keyIdeas: Number(r.key_ideas),
  }));
  return { exam: target.exam, notes };
}

/** Apuntes de un tema: párrafos propios con su cita literal de la norma (ADR-046). */
export type LessonRef = { ref: string; law: string; url: string | null; quote: string };
export type LessonSection = {
  n: string;
  title: string;
  blocks: { text: string; refs: LessonRef[] }[];
};

const str = (v: unknown) => (typeof v === "string" ? v : null);

/** Solo devuelve algo a quien puede practicar el tema (o al personal): lo decide topic_lessons(). */
export async function getTopicLessons(slug: string): Promise<LessonSection[]> {
  const supabase = await createClient();
  const { data, error } = await supabase.rpc("topic_lessons", { p_topic_slug: slug });
  if (error || !Array.isArray(data)) return [];
  return (data as unknown[]).flatMap((raw) => {
    const s = raw as { n?: unknown; title?: unknown; blocks?: unknown };
    const n = str(s.n);
    const title = str(s.title);
    if (!n || !title || !Array.isArray(s.blocks)) return [];
    const blocks = s.blocks.flatMap((b) => {
      const text = str((b as { text?: unknown }).text);
      const refs = (b as { refs?: unknown }).refs;
      if (!text) return [];
      return [
        {
          text,
          refs: (Array.isArray(refs) ? refs : []).flatMap((r) => {
            const ref = str((r as LessonRef).ref);
            const quote = str((r as LessonRef).quote);
            if (!ref || !quote) return [];
            const url = str((r as LessonRef).url);
            return [
              {
                ref,
                quote,
                law: str((r as LessonRef).law) ?? "",
                url: url && url.startsWith("https://") ? url : null,
              },
            ];
          }),
        },
      ];
    });
    return blocks.length ? [{ n, title, blocks }] : [];
  });
}

/** Tema de una práctica de un solo tema y progreso del alumno en él (resultado del test). */
export async function getSessionTopic(sessionId: string) {
  const supabase = await createClient();
  const { data } = await supabase.rpc("my_session_topic", { p_session: sessionId });
  const r = (Array.isArray(data) ? data[0] : null) as {
    slug: string;
    title: string;
    title_ca: string | null;
    published: number;
    answered: number;
    correct: number;
  } | null;
  if (!r) return null;
  return {
    slug: r.slug,
    title: r.title,
    titleCa: r.title_ca,
    published: Number(r.published),
    answered: Number(r.answered),
    correct: Number(r.correct),
  };
}

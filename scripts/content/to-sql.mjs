// Genera SQL idempotente para cargar un lote de preguntas en una BD Supabase
// (p. ej. pegándolo en el editor SQL). Mismas reglas que load-questions.mjs:
// las preguntas reales quedan en BORRADOR; el contenido de prueba se marca is_test
// y también queda en borrador (se publica aparte con supabase/preview/2-cuentas.sql).
// Uso: node scripts/content/to-sql.mjs <lote.json>
import { readFileSync } from "node:fs";
import { createHash } from "node:crypto";

const file = process.argv[2];
const data = JSON.parse(readFileSync(file, "utf8"));
const meta = data.meta ?? {};
const lit = (v) => (v === null || v === undefined ? "null" : `'${String(v).replace(/'/g, "''")}'`);
const normalize = (s) =>
  s.normalize("NFKD").replace(/\p{M}/gu, "").toLowerCase().replace(/\s+/g, " ").trim();
const hash = (q) =>
  createHash("sha256")
    .update([normalize(q.stem), ...q.options.map(normalize).sort()].join("␟"))
    .digest("hex");

const out = [`-- Lote ${meta.set ?? file} (${data.questions.length} preguntas)`];
if (meta.source) {
  const s = meta.source;
  out.push(
    `insert into public.sources (title, url, kind, publisher, published_on) values (${lit(s.title)}, ${lit(s.url)}, ${lit(s.kind ?? "web_oficial")}::public.source_kind, ${lit(s.publisher)}, ${lit(s.published_on)}) on conflict (url) do nothing;`,
  );
}
if (meta.topic_slug) {
  out.push(
    `insert into public.topics (slug, title) values (${lit(meta.topic_slug)}, ${lit(meta.topic)}) on conflict (slug) do nothing;`,
  );
  if (meta.exam)
    out.push(
      `insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = ${lit(meta.exam)} and t.slug = ${lit(meta.topic_slug)} on conflict do nothing;`,
    );
}
for (const q of data.questions) {
  const h = hash(q);
  const locale = q.locale ?? meta.locale ?? "es";
  const note =
    [q.excerpt_status === "parcial" ? "EXTRACTO PARCIAL." : null, q.review_note ?? null]
      .filter(Boolean)
      .join(" ") || null;
  out.push(`with q as (
  insert into public.questions (stem, explanation, category, topic_id, difficulty, locale, ai_generated, source_id, source_ref, source_excerpt, review_note, content_hash, is_test)
  select ${lit(q.stem)}, ${lit(q.explanation)}, ${lit(q.category ?? meta.category)}, ${meta.topic_slug ? `(select id from public.topics where slug = ${lit(meta.topic_slug)})` : "null"}, ${q.difficulty ?? 2}, '${locale}', ${!meta.is_test}, ${meta.source ? `(select id from public.sources where url = ${lit(meta.source.url)})` : "null"}, ${lit(q.ref)}, ${lit(q.excerpt)}, ${lit(note)}, '${h}', ${Boolean(meta.is_test)}
  where not exists (select 1 from public.questions where locale = '${locale}' and content_hash = '${h}')
  returning id
), o as (
  insert into public.question_options (question_id, label, body, is_correct)
  select q.id, v.label, v.body, v.ok from q, (values ${q.options.map((b, i) => `('${String.fromCharCode(65 + i)}', ${lit(b)}, ${i === q.correct})`).join(", ")}) as v(label, body, ok)
)
insert into public.question_exam_bodies (question_id, exam_body_id)
select q.id, b.id from q, public.exam_bodies b where b.slug = ${lit(meta.exam)};`);
}
console.log(out.join("\n"));

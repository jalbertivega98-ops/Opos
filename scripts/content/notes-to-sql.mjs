// Genera SQL idempotente para cargar fichas de estudio (content/<oposición>/fichas/*.json)
// en una BD Supabase (local con psql o la preview). Las fichas nuevas entran en
// BORRADOR (DEC-002): solo la titular las aprueba y publica desde el panel.
// Si una ficha ya existe y su contenido cambia, se actualiza y el guardián la
// devuelve a revisión; si no cambia, no se toca.
//
//   node scripts/content/notes-to-sql.mjs content/mossos/fichas/*.json > fichas.sql
import { readFileSync } from "node:fs";

const files = process.argv.slice(2);
if (!files.length) {
  console.error("Uso: node scripts/content/notes-to-sql.mjs <ficha.json>...");
  process.exit(1);
}
const lit = (v) => (v === null || v === undefined ? "null" : `'${String(v).replace(/'/g, "''")}'`);
const json = (v) => `${lit(JSON.stringify(v))}::jsonb`;

const out = [
  `-- Fichas de estudio (${files.length}) · generado por scripts/content/notes-to-sql.mjs`,
];
for (const f of files) {
  const d = JSON.parse(readFileSync(f, "utf8"));
  const m = d.meta;
  if (!m?.topic_slug || !Array.isArray(d.key_ideas) || !d.key_ideas.length) {
    console.error(`${f}: ficha sin topic_slug o sin idees força`);
    process.exit(1);
  }
  const s = m.source;
  out.push(
    `insert into public.sources (title, url, kind, publisher, published_on) values (${lit(s.title)}, ${lit(s.url)}, ${lit(s.kind ?? "web_oficial")}::public.source_kind, ${lit(s.publisher)}, ${lit(s.published_on)}) on conflict (url) do nothing;`,
    `insert into public.topics (slug, title) values (${lit(m.topic_slug)}, ${lit(m.topic)}) on conflict (slug) do nothing;`,
    `insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from public.exam_bodies b, public.topics t where b.slug = ${lit(m.exam)} and t.slug = ${lit(m.topic_slug)} on conflict do nothing;`,
    `insert into public.topic_notes as n (topic_id, locale, outline, key_ideas, glossary, amendments, source_id, source_url, page_from, page_to, key_ideas_page, review_note)
select t.id, '${m.locale ?? "ca"}', ${json(d.outline ?? [])}, ${json(d.key_ideas)}, ${json(d.glossary ?? [])}, ${json(d.amendments ?? [])}, (select id from public.sources where url = ${lit(s.url)}), ${lit(s.url)}, ${d.page_from ?? "null"}, ${d.page_to ?? "null"}, ${d.key_ideas_page ?? "null"}, ${lit(d.review_note ?? null)}
  from public.topics t where t.slug = ${lit(m.topic_slug)}
on conflict (topic_id, locale) do update
   set outline = excluded.outline, key_ideas = excluded.key_ideas, glossary = excluded.glossary,
       amendments = excluded.amendments, source_id = excluded.source_id, source_url = excluded.source_url,
       page_from = excluded.page_from, page_to = excluded.page_to, key_ideas_page = excluded.key_ideas_page
 where (n.outline, n.key_ideas, n.glossary, n.amendments)
       is distinct from (excluded.outline, excluded.key_ideas, excluded.glossary, excluded.amendments);`,
  );
}
console.log(out.join("\n"));

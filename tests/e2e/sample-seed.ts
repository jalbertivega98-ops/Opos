import pg from "pg";
import { randomUUID } from "node:crypto";

export const DB_URL = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";

/** Crea una oposición de prueba con un tema gratis y 6 preguntas publicadas (B es la buena). */
export async function seedExam() {
  const id = randomUUID().slice(0, 8);
  const slug = `e2e-test-gratis-${id}`;
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    await db.query("begin");
    // Datos de prueba ya «publicados»: se saltan los disparadores del flujo de revisión.
    await db.query("set local session_replication_role = replica");
    await db.query(
      `with o as (select id from public.organizations limit 1),
            b as (insert into public.exam_bodies (slug, organization_id, name, category, availability, is_published)
                  select $1, o.id, 'Oposición E2E ' || $2, 'otros', 'available', true from o returning id),
            t as (insert into public.topics (slug, title) values ($1 || '-t1', 'Tema E2E') returning id),
            et as (insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from b, t),
            p as (insert into public.products (slug, type, status, title, exam_body_id, is_free, config)
                  select $1 || '-gratis', 'question_pack', 'published', 'Gratis', b.id, true,
                         jsonb_build_object('topic_slugs', jsonb_build_array($1 || '-t1')) from b)
       select 1`,
      [slug, id],
    );
    for (let i = 0; i < 6; i++) {
      const { rows } = await db.query(
        `insert into public.questions (stem, explanation, category, content_hash, topic_id, source_ref, status, published_at)
         select $1, 'Explicación de prueba.', 'prueba', md5($1), t.id, 'art. 1', 'published', now()
           from public.topics t where t.slug = $2 || '-t1' returning id`,
        [`Pregunta E2E ${id} número ${i}`, slug],
      );
      await db.query(
        `insert into public.question_options (question_id, label, body, is_correct)
         values ($1,'A','Opción uno',false), ($1,'B','Opción buena',true), ($1,'C','Opción tres',false), ($1,'D','Opción cuatro',false)`,
        [rows[0].id],
      );
    }
    await db.query("commit");
  } finally {
    await db.end();
  }
  return slug;
}

export async function dropExam(slug: string) {
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    await db.query("begin");
    await db.query("set local session_replication_role = replica");
    const topic = `(select id from public.topics where slug = $1 || '-t1')`;
    await db.query(`delete from public.questions where topic_id = ${topic}`, [slug]);
    await db.query(`delete from public.exam_body_topics where topic_id = ${topic}`, [slug]);
    await db.query("delete from public.products where slug = $1 || '-gratis'", [slug]);
    await db.query("delete from public.topics where slug = $1 || '-t1'", [slug]);
    await db.query("delete from public.exam_bodies where slug = $1", [slug]);
    await db.query("delete from public.funnel_daily where exam = $1", [slug]);
    await db.query("commit");
  } finally {
    await db.end();
  }
}

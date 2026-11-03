import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

let client: pg.Client;
let editor: { id: string }, owner: { id: string };

type Q = (s: string, p?: unknown[]) => Promise<pg.QueryResult>;

/** Crea un tema con tres preguntas en borrador; la tercera lleva nota de revisión (dudosa). */
async function seedTopic(q: Q) {
  await q("reset role");
  const slug = `test-lote-${Math.random().toString(36).slice(2, 8)}`;
  const { rows: t } = await q(
    "insert into public.topics (slug, title) values ($1, 'Tema de prueba') returning id",
    [slug],
  );
  const ids: string[] = [];
  for (const [i, note] of [null, null, "Dato a contrastar"].entries()) {
    const { rows } = await q(
      `insert into public.questions (stem, explanation, category, content_hash, topic_id, review_note)
       values ($1, 'Explicación suficiente.', 'numerico', md5(random()::text), $2, $3) returning id`,
      [`Pregunta de lote ${i}`, t[0].id, note],
    );
    await q(
      `insert into public.question_options (question_id, label, body, is_correct)
       values ($1,'A','Sí',true), ($1,'B','No',false)`,
      [rows[0].id],
    );
    ids.push(rows[0].id);
  }
  await q("set local role authenticated");
  return { slug, ids };
}
const claims = (q: Q, uid: string) =>
  q("select set_config('request.jwt.claims', $1, true)", [
    JSON.stringify({ sub: uid, role: "authenticated" }),
  ]);
const statuses = async (q: Q, ids: string[]) =>
  (
    await q("select id, status from public.questions where id = any($1::uuid[])", [ids])
  ).rows.reduce<Record<string, string>>((m, r) => ({ ...m, [r.id]: r.status }), {});

beforeAll(async () => {
  client = await connect();
  editor = await createUser(client, { role: "editor" });
  owner = await createUser(client, { role: "owner" });
});
afterAll(async () => {
  await cleanup(client, [editor.id, owner.id]);
  await client.end();
});

describe("aprobación por lotes (DEC-006)", () => {
  it("solo la persona titular puede aprobar un lote", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      const { slug } = await seedTopic(q);
      await expect(q("select public.review_topic_batch($1, 'approved')", [slug])).rejects.toThrow(
        /titular/,
      );
    });
  });

  it("aprueba y publica el lote dejando fuera las dudosas, con auditoría", async () => {
    await as(client, { uid: owner.id }, async (q) => {
      await claims(q, owner.id);
      const { slug, ids } = await seedTopic(q);
      const approved = await q("select public.review_topic_batch($1, 'approved') as n", [slug]);
      expect(approved.rows[0].n).toBe(2);
      let st = await statuses(q, ids);
      expect([st[ids[0]], st[ids[1]], st[ids[2]]]).toEqual(["approved", "approved", "draft"]);

      const counts = await q("select * from public.topic_status_counts($1) order by status", [
        slug,
      ]);
      expect(counts.rows.map((r) => [r.status, r.flagged, Number(r.total)])).toEqual([
        ["draft", true, 1],
        ["approved", false, 2],
      ]);

      await q("reset role");
      const { rows: pack } = await q(
        `insert into public.products (slug, type, title, config)
         values ($1, 'question_pack', 'Pack de lote', jsonb_build_object('topic_prefix', $2::text)) returning id`,
        [`${slug}-pack`, slug],
      );
      await q("set local role authenticated");
      const published = await q("select public.review_topic_batch($1, 'published') as n", [slug]);
      expect(published.rows[0].n).toBe(2);
      st = await statuses(q, ids);
      expect(st[ids[0]]).toBe("published");
      expect(st[ids[2]]).toBe("draft");
      // las publicadas entran solas en el pack del tema; la dudosa no
      await q("reset role");
      const items = await q(
        "select question_id from public.product_items where product_id = $1 order by position",
        [pack[0].id],
      );
      await q("set local role authenticated");
      expect(items.rows.map((r) => r.question_id)).toEqual([ids[0], ids[1]]);

      const reviews = await q(
        "select to_status, comment, reviewer_id from public.question_reviews where question_id = $1 order by id",
        [ids[0]],
      );
      expect(reviews.rows.map((r) => r.to_status)).toEqual([
        "needs_review",
        "approved",
        "published",
      ]);
      expect(reviews.rows[1]).toMatchObject({ comment: `Lote: ${slug}`, reviewer_id: owner.id });
    });
  });

  it("las dudosas solo entran si se piden expresamente", async () => {
    await as(client, { uid: owner.id }, async (q) => {
      await claims(q, owner.id);
      const { slug, ids } = await seedTopic(q);
      const r = await q("select public.review_topic_batch($1, 'approved', true) as n", [slug]);
      expect(r.rows[0].n).toBe(3);
      expect((await statuses(q, ids))[ids[2]]).toBe("approved");
    });
  });

  it("no permite usar el lote para archivar ni devolver a borrador", async () => {
    await as(client, { uid: owner.id }, async (q) => {
      await claims(q, owner.id);
      const { slug } = await seedTopic(q);
      await expect(q("select public.review_topic_batch($1, 'archived')", [slug])).rejects.toThrow(
        /no permitido/,
      );
    });
  });
});

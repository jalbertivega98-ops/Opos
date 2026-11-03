import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

let client: pg.Client;
let student: { id: string }, editor: { id: string }, owner: { id: string };

type Q = (s: string, p?: unknown[]) => Promise<pg.QueryResult>;

/** Crea un tema con una ficha en borrador (como superusuario) y vuelve al rol del test. */
async function seedNote(q: Q) {
  await q("reset role");
  const slug = `test-ficha-${Math.random().toString(36).slice(2, 8)}`;
  const { rows } = await q(
    `with t as (insert into public.topics (slug, title) values ($1, 'Tema de prova') returning id)
     insert into public.topic_notes (topic_id, outline, key_ideas, glossary, page_from, page_to)
     select id, '[{"n":"1","title":"Apartat"}]', '["Idea literal"]', '["Terme"]', 1, 2 from t
     returning id`,
    [slug],
  );
  await q("set local role authenticated");
  return { slug, id: rows[0].id as string };
}
const status = async (q: Q, id: string) => {
  await q("reset role");
  const { rows } = await q("select status from public.topic_notes where id = $1", [id]);
  await q("set local role authenticated");
  return rows[0].status as string;
};

beforeAll(async () => {
  client = await connect();
  student = await createUser(client);
  editor = await createUser(client, { role: "editor" });
  owner = await createUser(client, { role: "owner" });
});
afterAll(async () => {
  await cleanup(client, [student.id, editor.id, owner.id]);
  await client.end();
});

describe("fichas de estudio (CNT-011)", () => {
  it("el alumnado no ve fichas en borrador ni puede escribirlas", async () => {
    await as(client, { uid: student.id }, async (q) => {
      const { id } = await seedNote(q);
      const { rows } = await q("select id from public.topic_notes where id = $1", [id]);
      expect(rows).toHaveLength(0);
      await q("savepoint s");
      await expect(
        q("update public.topic_notes set status = 'published' where id = $1", [id]),
      ).rejects.toThrow(/permission denied/);
      await q("rollback to savepoint s");
    });
  });

  it("anon no lee fichas", async () => {
    await as(client, "anon", async (q) => {
      await expect(q("select id from public.topic_notes limit 1")).rejects.toThrow(
        /permission denied/,
      );
    });
  });

  it("solo la titular aprueba y publica; el staff lee los borradores", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      const { slug, id } = await seedNote(q);
      const { rows } = await q("select id from public.topic_notes where id = $1", [id]);
      expect(rows).toHaveLength(1);
      await expect(q("select public.review_topic_notes($1, 'approved')", [slug])).rejects.toThrow(
        /titular/,
      );
    });
  });

  it("aprobar → publicar deja auditoría y la ficha se ve; un cambio la devuelve a revisión", async () => {
    let slug = "";
    await as(client, { uid: owner.id }, async (q) => {
      const seeded = await seedNote(q);
      slug = seeded.slug;
      await expect(
        q("select public.review_topic_notes($1, 'published') as n", [slug]),
      ).resolves.toMatchObject({ rows: [{ n: 0 }] }); // no se publica sin aprobar antes
      const a = await q("select public.review_topic_notes($1, 'approved') as n", [slug]);
      expect(a.rows[0].n).toBe(1);
      expect(await status(q, seeded.id)).toBe("approved");
      const p = await q("select public.review_topic_notes($1, 'published') as n", [slug]);
      expect(p.rows[0].n).toBe(1);
      expect(await status(q, seeded.id)).toBe("published");

      await q("reset role");
      const audit = await q(
        "select action from public.audit_log where target_id = $1 order by created_at",
        [seeded.id],
      );
      expect(audit.rows.map((r) => r.action)).toEqual([
        "topic_notes.approved",
        "topic_notes.published",
      ]);
      // Corregir el contenido de una ficha publicada la saca de publicación
      await q("update public.topic_notes set key_ideas = '[\"Idea corregida\"]' where id = $1", [
        seeded.id,
      ]);
      const { rows } = await q(
        "select status, reviewed_by, published_at from public.topic_notes where id = $1",
        [seeded.id],
      );
      expect(rows[0]).toMatchObject({
        status: "needs_review",
        reviewed_by: null,
        published_at: null,
      });
    });
  });

  it("una ficha sin idees força no se puede aprobar", async () => {
    await as(client, { uid: owner.id }, async (q) => {
      const { slug, id } = await seedNote(q);
      await q("reset role");
      await q("update public.topic_notes set key_ideas = '[]' where id = $1", [id]);
      await q("set local role authenticated");
      await expect(q("select public.review_topic_notes($1, 'approved')", [slug])).rejects.toThrow(
        /contenido/,
      );
    });
  });

  it("el alumnado ve las fichas publicadas de su oposición", async () => {
    await as(client, { uid: student.id }, async (q) => {
      await q("reset role");
      const slug = `test-ficha-${Math.random().toString(36).slice(2, 8)}`;
      const exam = await q("select id, slug from public.exam_bodies limit 1");
      const { rows: t } = await q(
        "insert into public.topics (slug, title) values ($1, 'Tema publicat') returning id",
        [slug],
      );
      await q(
        "insert into public.exam_body_topics (exam_body_id, topic_id, order_index) values ($1, $2, 999)",
        [exam.rows[0].id, t[0].id],
      );
      await q(
        `insert into public.topic_notes (topic_id, key_ideas, status, reviewed_by, published_at)
         values ($1, '["Idea"]', 'published', $2, now())`,
        [t[0].id, owner.id],
      );
      await q("set local role authenticated");
      const { rows } = await q("select * from public.exam_topic_notes($1)", [exam.rows[0].slug]);
      expect(rows.find((r) => r.slug === slug)).toMatchObject({ key_ideas: 1 });
    });
  });
});

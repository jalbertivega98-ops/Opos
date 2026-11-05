import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { cleanup, connect, createUser } from "./helpers";

// ADR-036: test por tema desde el plan y calendario de estudio.
let client: pg.Client;
let student: { id: string }, other: { id: string }, owner: { id: string };

type Q = (s: string, p?: unknown[]) => Promise<pg.QueryResult>;

/** Ejecuta como superusuario dentro de una transacción que se deshace. */
async function tx<T>(fn: (q: Q) => Promise<T>) {
  await client.query("begin");
  try {
    return await fn((s, p) => client.query(s, p as unknown[]));
  } finally {
    await client.query("rollback");
  }
}

/** Cambia, dentro de la transacción, al rol `authenticated` con ese uid (o vuelve a superusuario). */
async function actAs(q: Q, uid: string | null) {
  if (uid === null) {
    await q("reset role");
    await q("select set_config('request.jwt.claims', '', true)");
    return;
  }
  await q("set local role authenticated");
  await q("select set_config('request.jwt.claims', $1, true)", [
    JSON.stringify({ sub: uid, role: "authenticated" }),
  ]);
}

/** Oposición con dos temas, 3 preguntas publicadas en cada uno. */
async function setup(q: Q) {
  const { rows: org } = await q(
    `insert into public.organizations (slug, name, scope) values ('org-test-tp', 'Org', 'estatal') returning id`,
  );
  const { rows: ex } = await q(
    `insert into public.exam_bodies (slug, organization_id, name, category, availability, is_published)
     values ('test-opo-tp', $1, 'Oposición de prueba', 'otros', 'available', true) returning id`,
    [org[0].id],
  );
  const exam = ex[0].id as string;
  const { rows: topics } = await q(
    `insert into public.topics (slug, title) values ('test-tp-t1', 'Tema 1'), ('test-tp-t2', 'Tema 2')
     returning id, slug`,
  );
  const t1 = topics.find((t) => t.slug === "test-tp-t1").id as string;
  const t2 = topics.find((t) => t.slug === "test-tp-t2").id as string;
  await q(
    `insert into public.exam_body_topics (exam_body_id, topic_id) values ($1, $2), ($1, $3)`,
    [exam, t1, t2],
  );
  await q("select set_config('request.jwt.claims', $1, true)", [
    JSON.stringify({ sub: owner.id, role: "authenticated" }),
  ]);
  const byTopic: Record<string, string[]> = { [t1]: [], [t2]: [] };
  for (const [i, topic] of [t1, t1, t1, t2, t2, t2].entries()) {
    const { rows } = await q(
      `insert into public.questions (stem, explanation, category, content_hash, topic_id, source_ref)
       values ($1, 'Explicación suficiente.', 'prueba', md5($1), $2, 'art. 1') returning id`,
      [`Pregunta por tema ${i}`, topic],
    );
    const id = rows[0].id as string;
    await q(
      `insert into public.question_options (question_id, label, body, is_correct)
       values ($1,'A','uno',false), ($1,'B','dos',true), ($1,'C','tres',false), ($1,'D','cuatro',false)`,
      [id],
    );
    for (const to of ["needs_review", "approved", "published"])
      await q("update public.questions set status = $2::public.content_status where id = $1", [
        id,
        to,
      ]);
    byTopic[topic].push(id);
  }
  await actAs(q, null);
  // 3 temas gratis → aquí solo el tema 1; el tema 2 va en un pack incluido en Premium
  await q(
    `insert into public.products (slug, type, status, title, exam_body_id, is_free, included_in_premium, config)
     values ('test-tp-gratis', 'question_pack', 'published', 'Gratis', $1, true, false, '{"topic_slugs":["test-tp-t1"]}')`,
    [exam],
  );
  const { rows: pk } = await q(
    `insert into public.products (slug, type, status, title, exam_body_id, included_in_premium)
     values ('test-tp-pack', 'question_pack', 'published', 'Pack', $1, true) returning id`,
    [exam],
  );
  for (const [i, id] of byTopic[t2].entries())
    await q(`insert into public.product_items (product_id, position, question_id) values ($1, $2, $3)`, [
      pk[0].id,
      i + 1,
      id,
    ]);
  const { rows: prem } = await q(
    `insert into public.products (slug, type, status, title, exam_body_id, included_in_premium)
     values ('test-tp-premium', 'subscription', 'published', 'Premium', $1, false) returning id`,
    [exam],
  );
  await q(
    `insert into public.user_exam_targets (user_id, exam_body_id, is_primary) values ($1, $2, true)`,
    [student.id, exam],
  );
  return { exam, t1, t2, byTopic, premium: prem[0].id as string };
}

const start = (q: Q, user: string, slug: string, n = 10) =>
  q("select public.practice_start_topic($1, $2, $3) as id", [user, slug, n]);

beforeAll(async () => {
  client = await connect();
  student = await createUser(client);
  other = await createUser(client);
  owner = await createUser(client, { role: "owner" });
});
afterAll(async () => {
  await cleanup(client, [student.id, other.id, owner.id]);
  await client.end();
});

describe("test por tema", () => {
  it("un tema gratis se practica; uno de pago pide Premium", async () => {
    await tx(async (q) => {
      const { t1, exam, premium } = await setup(q);
      const { rows } = await start(q, student.id, "test-tp-t1");
      const session = rows[0].id as string;
      const { rows: s } = await q(
        "select mode, item_count, exam_body_id from public.practice_sessions where id = $1",
        [session],
      );
      expect(s[0]).toMatchObject({ mode: "questions", item_count: 3, exam_body_id: exam });
      const { rows: items } = await q(
        `select distinct q.topic_id from public.practice_items i join public.questions q on q.id = i.question_id
          where i.session_id = $1`,
        [session],
      );
      expect(items.map((r) => r.topic_id)).toEqual([t1]);

      await q("savepoint s");
      await expect(start(q, student.id, "test-tp-t2")).rejects.toMatchObject({ code: "42501" });
      await q("rollback to savepoint s");

      await q(
        `insert into public.subscriptions (user_id, product_id, status, provider)
         values ($1, $2, 'active', 'stripe_test')`,
        [student.id, premium],
      );
      const { rows: ok } = await start(q, student.id, "test-tp-t2", 2);
      const { rows: n } = await q(
        "select item_count from public.practice_sessions where id = $1",
        [ok[0].id],
      );
      expect(n[0].item_count).toBe(2);
    });
  });

  it("un tema sin preguntas publicadas da error de datos", async () => {
    await tx(async (q) => {
      await setup(q);
      await expect(start(q, student.id, "test-tp-no-existe")).rejects.toMatchObject({
        code: "22023",
      });
    });
  });

  it("el alumno no puede llamar a practice_start_topic directamente", async () => {
    await tx(async (q) => {
      await setup(q);
      await actAs(q, student.id);
      await expect(start(q, student.id, "test-tp-t1")).rejects.toMatchObject({ code: "42501" });
    });
  });

  it("my_open_topics lista los temas que puede practicar", async () => {
    await tx(async (q) => {
      const { premium } = await setup(q);
      const open = async () => {
        await actAs(q, student.id);
        const { rows } = await q("select * from public.my_open_topics('test-opo-tp') s order by 1");
        await actAs(q, null);
        return rows.map((r) => r.s ?? Object.values(r)[0]);
      };
      expect(await open()).toEqual(["test-tp-t1"]);
      await q(
        `insert into public.subscriptions (user_id, product_id, status, provider)
         values ($1, $2, 'active', 'stripe_test')`,
        [student.id, premium],
      );
      expect(await open()).toEqual(["test-tp-t1", "test-tp-t2"]);
    });
  });
});

describe("calendario de estudio", () => {
  it("my_study_log devuelve las prácticas propias con su tema, y no las de otros", async () => {
    await tx(async (q) => {
      await setup(q);
      const { rows } = await start(q, student.id, "test-tp-t1");
      const session = rows[0].id as string;
      await q(
        "select * from public.practice_answer_question($1, $2, 0::smallint, 1::smallint)",
        [student.id, session],
      );
      const log = async (uid: string) => {
        await actAs(q, uid);
        const { rows: r } = await q(
          "select * from public.my_study_log(now() - interval '1 day', now() + interval '1 day')",
        );
        await actAs(q, null);
        return r;
      };
      const mine = await log(student.id);
      expect(mine).toHaveLength(1);
      expect(mine[0]).toMatchObject({
        kind: "practice",
        id: session,
        mode: "questions",
        answered: 1,
        total: 3,
        topic_slug: "test-tp-t1",
        topic_title: "Tema 1",
      });
      expect(await log(other.id)).toHaveLength(0);
    });
  });

  it("anon no puede leer el calendario", async () => {
    await tx(async (q) => {
      await q("set local role anon");
      await expect(
        q("select * from public.my_study_log(now() - interval '1 day', now())"),
      ).rejects.toMatchObject({ code: "42501" });
    });
  });
});

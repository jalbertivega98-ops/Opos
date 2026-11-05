import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { cleanup, connect, createUser } from "./helpers";

// ADR-035: Premium por oposición, temas gratis (config.topic_slugs) y packs de intentos.
let client: pg.Client;
let student: { id: string }, owner: { id: string };

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
const access = async (q: Q, p: string, u: string) =>
  (await q("select public.has_product_access($1, $2) as ok", [p, u])).rows[0].ok as boolean;

async function exam(q: Q, slug: string) {
  const { rows: org } = await q(
    `insert into public.organizations (slug, name, scope) values ($1, 'Org prueba', 'estatal') returning id`,
    [`org-${slug}`],
  );
  const { rows } = await q(
    `insert into public.exam_bodies (slug, organization_id, name, category, availability, is_published)
     values ($1, $2, 'Oposición de prueba', 'otros', 'available', true) returning id`,
    [slug, org[0].id],
  );
  return rows[0].id as string;
}
async function product(
  q: Q,
  slug: string,
  examId: string | null,
  type: string,
  opts: { premium?: boolean; free?: boolean; config?: object } = {},
) {
  const { rows } = await q(
    `insert into public.products (slug, type, status, title, exam_body_id, included_in_premium, is_free, config)
     values ($1, $2, 'published', 'Producto de prueba', $3, $4, $5, $6) returning id`,
    [
      slug,
      type,
      examId,
      opts.premium ?? true,
      opts.free ?? false,
      JSON.stringify(opts.config ?? {}),
    ],
  );
  return rows[0].id as string;
}
const subscribe = (q: Q, user: string, productId: string) =>
  q(
    `insert into public.subscriptions (user_id, product_id, status, provider)
     values ($1, $2, 'active', 'stripe_test')`,
    [user, productId],
  );
const startAttempt = (q: Q, user: string, mock: string) =>
  q(
    `insert into public.mock_attempts (user_id, product_id, title, config, item_count, deadline, status, submitted_at)
     values ($1, $2, 'Intento', '{}', 10, now() + interval '1 hour', 'submitted', now())`,
    [user, mock],
  );

beforeAll(async () => {
  client = await connect();
  student = await createUser(client);
  owner = await createUser(client, { role: "owner" });
});
afterAll(async () => {
  await cleanup(client, [student.id, owner.id]);
  await client.end();
});

describe("Premium por oposición", () => {
  it("da acceso solo a lo incluido en Premium de su oposición", async () => {
    await tx(async (q) => {
      const a = await exam(q, "test-opo-a");
      const b = await exam(q, "test-opo-b");
      const packA = await product(q, "test-pp-pack-a", a, "question_pack");
      const packB = await product(q, "test-pp-pack-b", b, "question_pack");
      const extraA = await product(q, "test-pp-extra-a", a, "question_pack", { premium: false });
      const premiumA = await product(q, "test-pp-premium-a", a, "subscription", { premium: false });

      expect(await access(q, packA, student.id)).toBe(false);
      await subscribe(q, student.id, premiumA);
      expect(await access(q, packA, student.id)).toBe(true);
      expect(await access(q, packB, student.id)).toBe(false);
      expect(await access(q, extraA, student.id)).toBe(false);
    });
  });

  it("el Premium global antiguo (sin oposición) sigue dando acceso a todo", async () => {
    await tx(async (q) => {
      const a = await exam(q, "test-opo-a");
      const b = await exam(q, "test-opo-b");
      const packA = await product(q, "test-pp-pack-a", a, "question_pack");
      const packB = await product(q, "test-pp-pack-b", b, "question_pack");
      const global = await product(q, "test-pp-premium-global", null, "subscription", {
        premium: false,
      });
      await subscribe(q, student.id, global);
      expect(await access(q, packA, student.id)).toBe(true);
      expect(await access(q, packB, student.id)).toBe(true);
    });
  });
});

describe("temas gratis", () => {
  it("un pack gratis con topic_slugs reparte las preguntas publicadas de esos temas", async () => {
    await tx(async (q) => {
      const a = await exam(q, "test-opo-a");
      const { rows: topics } = await q(
        `insert into public.topics (slug, title) values ('test-free-t1', 'Tema 1'), ('test-free-t2', 'Tema 2')
         returning id, slug`,
      );
      const t1 = topics.find((t) => t.slug === "test-free-t1").id as string;
      const t2 = topics.find((t) => t.slug === "test-free-t2").id as string;
      await q(
        `insert into public.exam_body_topics (exam_body_id, topic_id) values ($1, $2), ($1, $3)`,
        [a, t1, t2],
      );
      await q("select set_config('request.jwt.claims', $1, true)", [
        JSON.stringify({ sub: owner.id, role: "authenticated" }),
      ]);
      const ids: string[] = [];
      for (const [i, topic] of [t1, t1, t2].entries()) {
        const { rows } = await q(
          `insert into public.questions (stem, explanation, category, content_hash, topic_id, source_ref)
           values ($1, 'Explicación suficiente.', 'prueba', md5($1), $2, 'art. 1') returning id`,
          [`Pregunta gratis ${i}`, topic],
        );
        const id = rows[0].id as string;
        await q(
          `insert into public.question_options (question_id, label, body, is_correct)
           values ($1,'A','uno',false), ($1,'B','dos',true), ($1,'C','tres',false), ($1,'D','cuatro',false)`,
          [id],
        );
        ids.push(id);
      }
      // Publicadas las dos del tema 1; la del tema 2 se queda en borrador
      for (const id of ids.slice(0, 2))
        for (const to of ["needs_review", "approved", "published"])
          await q("update public.questions set status = $2::public.content_status where id = $1", [
            id,
            to,
          ]);
      await q("select set_config('request.jwt.claims', '', true)");

      const free = await product(q, "test-pp-gratis", a, "question_pack", {
        free: true,
        config: { topic_slugs: ["test-free-t1", "test-free-t2"] },
      });
      expect(await access(q, free, student.id)).toBe(true);
      const { rows: playable } = await q("select public.product_question_ids($1) as id", [free]);
      expect(playable.map((r) => r.id).sort()).toEqual(ids.slice(0, 2).sort());

      const { rows: offer } = await q("select public.exam_offer('test-opo-a') as o");
      expect(offer[0].o.free_topics).toEqual([
        { slug: "test-free-t1", title: "Tema 1", questions: 2 },
        { slug: "test-free-t2", title: "Tema 2", questions: 0 },
      ]);
    });
  });
});

describe("packs de intentos de simulacro", () => {
  it("dan N intentos de sus simulacros; agotados, ya no hay acceso", async () => {
    await tx(async (q) => {
      const a = await exam(q, "test-opo-a");
      const mock1 = await product(q, "test-pp-mock-1", a, "mock_exam");
      const mock2 = await product(q, "test-pp-mock-2", a, "mock_exam");
      const pack = await product(q, "test-pp-3-intentos", a, "bundle", {
        premium: false,
        config: { attempts: 3 },
      });
      await q(
        `insert into public.product_items (product_id, position, child_product_id)
         values ($1, 1, $2), ($1, 2, $3)`,
        [pack, mock1, mock2],
      );
      expect(await access(q, mock1, student.id)).toBe(false);

      await q(
        "insert into public.access_grants (user_id, product_id, source) values ($1, $2, 'purchase')",
        [student.id, pack],
      );
      expect(await access(q, mock1, student.id)).toBe(true);
      const left = async () =>
        (await q("select public.mock_credits_left($1, $2) as n", [mock1, student.id])).rows[0]
          .n as number;
      expect(await left()).toBe(3);

      // Los intentos se comparten entre los simulacros del pack
      await startAttempt(q, student.id, mock1);
      await startAttempt(q, student.id, mock2);
      expect(await left()).toBe(1);
      await startAttempt(q, student.id, mock2);
      expect(await left()).toBe(0);
      expect(await access(q, mock1, student.id)).toBe(false);
      expect(await access(q, mock2, student.id)).toBe(false);
      // El pack en sí sigue en su biblioteca (comprado)
      expect(await access(q, pack, student.id)).toBe(true);

      // Una segunda compra suma intentos
      await q(
        "insert into public.access_grants (user_id, product_id, source) values ($1, $2, 'purchase')",
        [student.id, pack],
      );
      expect(await left()).toBe(3);
      expect(await access(q, mock1, student.id)).toBe(true);
    });
  });

  it("un pack normal (sin attempts) sigue dando acceso ilimitado", async () => {
    await tx(async (q) => {
      const a = await exam(q, "test-opo-a");
      const mock = await product(q, "test-pp-mock-1", a, "mock_exam");
      const bundle = await product(q, "test-pp-pack-completo", a, "bundle");
      await q(
        `insert into public.product_items (product_id, position, child_product_id) values ($1, 1, $2)`,
        [bundle, mock],
      );
      await q(
        "insert into public.access_grants (user_id, product_id, source) values ($1, $2, 'purchase')",
        [student.id, bundle],
      );
      for (let i = 0; i < 5; i++) await startAttempt(q, student.id, mock);
      expect(await access(q, mock, student.id)).toBe(true);
    });
  });
});

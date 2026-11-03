import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

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
async function fails(q: Q, sql: string, params: unknown[], re: RegExp) {
  await q("savepoint s");
  await expect(q(sql, params)).rejects.toThrow(re);
  await q("rollback to savepoint s");
}

/** Pregunta publicada por la titular (correcta = B). */
async function published(q: Q, stem: string, isTest = false) {
  const { rows } = await q(
    `insert into public.questions (stem, explanation, category, content_hash, is_test, source_ref)
     values ($1, 'Explicación suficiente.', 'prueba', md5($1), $2, 'art. 1') returning id`,
    [stem, isTest],
  );
  const id = rows[0].id as string;
  await q(
    `insert into public.question_options (question_id, label, body, is_correct)
     values ($1,'A','uno',false), ($1,'B','dos',true), ($1,'C','tres',false), ($1,'D','cuatro',false)`,
    [id],
  );
  await q("select set_config('request.jwt.claims', $1, true)", [
    JSON.stringify({ sub: owner.id, role: "authenticated" }),
  ]);
  for (const to of ["needs_review", "approved", "published"])
    await q("update public.questions set status = $2::public.content_status where id = $1", [
      id,
      to,
    ]);
  await q("select set_config('request.jwt.claims', '', true)");
  return id;
}

async function product(q: Q, slug: string, isTest: boolean, questions: string[]) {
  const { rows } = await q(
    `insert into public.products (slug, type, status, title, is_test, included_in_premium)
     values ($1, 'question_pack', 'published', 'Pack de prueba', $2, false) returning id`,
    [slug, isTest],
  );
  for (const [i, qid] of questions.entries())
    await q(
      "insert into public.product_items (product_id, position, question_id) values ($1,$2,$3)",
      [rows[0].id, i, qid],
    );
  return rows[0].id as string;
}

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

describe("práctica con preguntas de un producto", () => {
  it("exige acceso, oculta la solución y corrige en SQL", async () => {
    await tx(async (q) => {
      const ids = [await published(q, "P1 test", true), await published(q, "P2 test", true)];
      const pid = await product(q, "test-qp-1", true, ids);

      await fails(
        q,
        "select public.practice_start_product($1, $2, 10)",
        [student.id, pid],
        /acceso/,
      );
      await q(
        "insert into public.access_grants (user_id, product_id, source) values ($1, $2, 'admin')",
        [student.id, pid],
      );
      const sid = (
        await q("select public.practice_start_product($1, $2, 10) as id", [student.id, pid])
      ).rows[0].id as string;

      const items = (
        await q(
          "select presented, question_id from public.practice_items where session_id = $1 order by position",
          [sid],
        )
      ).rows;
      expect(items).toHaveLength(2);
      for (const it of items) {
        expect(it.presented.options).toEqual(["uno", "dos", "tres", "cuatro"]);
        expect(JSON.stringify(it.presented)).not.toMatch(/is_correct|answer/);
      }

      // otra persona no puede responder en esta sesión
      await fails(
        q,
        "select * from public.practice_answer_question($1, $2, 0::smallint, 1::smallint)",
        [other.id, sid],
        /no encontrado/,
      );

      const ok = (
        await q("select * from public.practice_answer_question($1, $2, 0::smallint, 1::smallint)", [
          student.id,
          sid,
        ])
      ).rows[0];
      expect(ok).toMatchObject({ is_correct: true, answer_index: 1, finished: false });
      expect(ok.explanation).toEqual({ text: "Explicación suficiente.", ref: "art. 1" });

      const ko = (
        await q("select * from public.practice_answer_question($1, $2, 1::smallint, 3::smallint)", [
          student.id,
          sid,
        ])
      ).rows[0];
      expect(ko).toMatchObject({ is_correct: false, answer_index: 1, finished: true });

      const s = (
        await q("select status, correct_count from public.practice_sessions where id = $1", [sid])
      ).rows[0];
      expect(s).toEqual({ status: "finished", correct_count: 1 });

      // repaso: la fallada vuelve y acertarla la resuelve
      const rid = (
        await q("select public.practice_start_question_review($1, 10) as id", [student.id])
      ).rows[0].id;
      expect(rid).toBeTruthy();
      await q("select * from public.practice_answer_question($1, $2, 0::smallint, 1::smallint)", [
        student.id,
        rid,
      ]);
      const pending = (
        await q(
          "select count(*)::int as n from public.practice_items where user_id = $1 and is_correct = false and reviewed_at is null",
          [student.id],
        )
      ).rows[0].n;
      expect(pending).toBe(0);
      expect(
        (await q("select public.practice_start_question_review($1, 10) as id", [student.id]))
          .rows[0].id,
      ).toBeNull();
    });
  });

  it("no mezcla contenido de prueba con contenido real", async () => {
    await tx(async (q) => {
      const real = await published(q, "Pregunta real", false);
      const test = await published(q, "Pregunta de prueba", true);
      await q("savepoint a");
      await expect(product(q, "test-qp-mix", true, [real])).rejects.toThrow(
        /prueba con contenido real/,
      );
      await q("rollback to savepoint a");
      await expect(product(q, "test-qp-mix2", false, [test])).rejects.toThrow(
        /prueba con contenido real/,
      );
    });
  });

  it("un borrador nunca llega a un producto ni a la práctica", async () => {
    await tx(async (q) => {
      const { rows } = await q(
        `insert into public.questions (stem, category, content_hash) values ('Borrador', 'prueba', md5('b')) returning id`,
      );
      await expect(product(q, "test-qp-draft", false, [rows[0].id])).rejects.toThrow(
        /aprobadas o publicadas/,
      );
    });
  });

  it("solo service_role puede iniciar o corregir", async () => {
    for (const sql of [
      "select public.practice_start_product(gen_random_uuid(), gen_random_uuid(), 5)",
      "select public.practice_answer_question(gen_random_uuid(), gen_random_uuid(), 0::smallint, 0::smallint)",
      "select public.practice_start_question_review(gen_random_uuid(), 5)",
      "select public.product_question_ids(gen_random_uuid())",
    ]) {
      await as(client, { uid: student.id }, async (q) => {
        await expect(q(sql)).rejects.toThrow(/permission denied/);
      });
    }
  });
});

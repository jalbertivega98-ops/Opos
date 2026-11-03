import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { cleanup, connect, createUser } from "./helpers";

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
const asOwner = (q: Q) =>
  q("select set_config('request.jwt.claims', $1, true)", [
    JSON.stringify({ sub: owner.id, role: "authenticated" }),
  ]);

/** Pregunta publicada en un tema (correcta = B). */
async function published(q: Q, topic: string, stem: string) {
  const { rows } = await q(
    `insert into public.questions (stem, explanation, category, content_hash, source_ref, topic_id, locale)
     values ($1, 'Explicació suficient.', 'prova', md5($1), 'p. 1', $2, 'ca') returning id`,
    [stem, topic],
  );
  const id = rows[0].id as string;
  await q(
    `insert into public.question_options (question_id, label, body, is_correct)
     values ($1,'A','u',false), ($1,'B','dos',true), ($1,'C','tres',false), ($1,'D','quatre',false)`,
    [id],
  );
  await asOwner(q);
  for (const to of ["needs_review", "approved", "published"])
    await q("update public.questions set status = $2::public.content_status where id = $1", [
      id,
      to,
    ]);
  await q("select set_config('request.jwt.claims', '', true)");
  return id;
}

/** Tres temas (a: 2 preguntas, b: 1, c: 3) y un simulacro de 4 preguntas. */
async function seed(q: Q, questions = 4) {
  const prefix = `test-sim-${Math.random().toString(36).slice(2, 8)}`;
  const topics: Record<string, string> = {};
  for (const k of ["a", "b", "c"]) {
    const { rows } = await q(
      "insert into public.topics (slug, title) values ($1, $2) returning id",
      [`${prefix}-${k}`, `Tema ${k}`],
    );
    topics[k] = rows[0].id;
  }
  for (const [k, n] of [
    ["a", 2],
    ["b", 1],
    ["c", 3],
  ] as const)
    for (let i = 0; i < n; i++) await published(q, topics[k], `${prefix} ${k}${i}`);
  // una en castellano que no debe entrar (el simulacro es en catalán)
  const es = await published(q, topics.b, `${prefix} es`);
  await q("update public.questions set locale = 'es' where id = $1", [es]);
  const { rows } = await q(
    `insert into public.products (slug, type, status, title, included_in_premium, config)
     values ($1, 'mock_exam', 'published', 'Simulacre de prova', false,
             jsonb_build_object('questions', $2::int, 'minutes', 35, 'penalty', 0.25,
                                'pass_mark', 4, 'max_mark', 10, 'topic_prefix', $3::text,
                                'locale', 'ca'))
     returning id`,
    [`${prefix}-sim`, questions, `${prefix}-`],
  );
  return { pid: rows[0].id as string, prefix };
}
const grant = (q: Q, pid: string) =>
  q("insert into public.access_grants (user_id, product_id, source) values ($1, $2, 'admin')", [
    student.id,
    pid,
  ]);
const start = async (q: Q, pid: string) =>
  (await q("select public.mock_start($1, $2) as id", [student.id, pid])).rows[0].id as string;
const save = (q: Q, aid: string, pos: number, choice: number | null, user = student.id) =>
  q("select public.mock_save_answer($1, $2, $3::smallint, $4::smallint)", [user, aid, pos, choice]);

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

describe("simulacros con formato oficial (MOC-001)", () => {
  it("exige acceso, reparte por temas, oculta la solución y reanuda el intento", async () => {
    await tx(async (q) => {
      const { pid, prefix } = await seed(q);
      await fails(q, "select public.mock_start($1, $2)", [student.id, pid], /acceso/);
      await grant(q, pid);
      const aid = await start(q, pid);

      const a = (
        await q(
          "select status, item_count, extract(epoch from deadline - started_at)::int as secs from public.mock_attempts where id = $1",
          [aid],
        )
      ).rows[0];
      expect(a).toEqual({ status: "active", item_count: 4, secs: 35 * 60 });

      const items = (
        await q(
          "select topic_slug, presented, answer_index, is_correct from public.mock_attempt_items where attempt_id = $1",
          [aid],
        )
      ).rows;
      expect(items).toHaveLength(4);
      // al menos una pregunta de cada tema antes de repetir
      expect(new Set(items.map((i) => i.topic_slug))).toEqual(
        new Set([`${prefix}-a`, `${prefix}-b`, `${prefix}-c`]),
      );
      for (const it of items) {
        expect(it.presented.options).toEqual(["u", "dos", "tres", "quatre"]);
        expect(JSON.stringify(it.presented)).not.toMatch(/is_correct|answer/);
        expect(it.answer_index).toBeNull();
        expect(it.presented.stem).not.toMatch(/ es$/);
      }
      // volver a empezar reanuda el mismo intento
      expect(await start(q, pid)).toBe(aid);
    });
  });

  it("no empieza si el banco publicado no llega al formato", async () => {
    await tx(async (q) => {
      const { pid } = await seed(q, 7);
      await grant(q, pid);
      await fails(q, "select public.mock_start($1, $2)", [student.id, pid], /suficientes/);
    });
  });

  it("permite cambiar y dejar en blanco, y corrige con −1/4 al entregar", async () => {
    await tx(async (q) => {
      const { pid } = await seed(q);
      await grant(q, pid);
      const aid = await start(q, pid);

      await fails(
        q,
        "select public.mock_save_answer($1, $2, 0::smallint, 1::smallint)",
        [other.id, aid],
        /no encontrado/,
      );
      await fails(
        q,
        "select public.mock_save_answer($1, $2, 0::smallint, 4::smallint)",
        [student.id, aid],
        /no válida/,
      );

      await save(q, aid, 0, 3); // cambia de opinión…
      await save(q, aid, 0, 1); // …y acierta
      await save(q, aid, 1, 1); // acierto
      await save(q, aid, 2, 0); // fallo
      await save(q, aid, 3, 2);
      await save(q, aid, 3, null); // la deja en blanco

      const r = (await q("select * from public.mock_submit($1, $2)", [student.id, aid])).rows[0];
      // (2 − 1·0,25) · 10 / 4 = 4,375 → 4,38
      expect(r).toMatchObject({ correct: 2, wrong: 1, blank: 1, void: 0, passed: true });
      expect(Number(r.score)).toBe(1.75);
      expect(Number(r.mark)).toBe(4.38);

      const items = (
        await q(
          "select position, chosen_index, is_correct, answer_index, explanation from public.mock_attempt_items where attempt_id = $1 order by position",
          [aid],
        )
      ).rows;
      expect(items.map((i) => [i.chosen_index, i.is_correct, i.answer_index])).toEqual([
        [1, true, 1],
        [1, true, 1],
        [0, false, 1],
        [null, null, 1],
      ]);
      expect(items[0].explanation).toEqual({ text: "Explicació suficient.", ref: "p. 1" });

      // entregar otra vez devuelve lo mismo y ya no se puede responder
      const again = (await q("select * from public.mock_submit($1, $2)", [student.id, aid]))
        .rows[0];
      expect(Number(again.mark)).toBe(4.38);
      await fails(
        q,
        "select public.mock_save_answer($1, $2, 3::smallint, 1::smallint)",
        [student.id, aid],
        /terminado/,
      );
      expect(
        (await q("select status from public.mock_attempts where id = $1", [aid])).rows[0].status,
      ).toBe("submitted");
    });
  });

  it("al agotarse el tiempo no acepta respuestas y corrige lo guardado", async () => {
    await tx(async (q) => {
      const { pid } = await seed(q);
      await grant(q, pid);
      const aid = await start(q, pid);
      await save(q, aid, 0, 0);
      await q(
        "update public.mock_attempts set deadline = now() - interval '1 minute' where id = $1",
        [aid],
      );
      await fails(
        q,
        "select public.mock_save_answer($1, $2, 1::smallint, 1::smallint)",
        [student.id, aid],
        /terminado/,
      );
      // ya no se reanuda: empezar crea un intento nuevo
      expect(await start(q, pid)).not.toBe(aid);
      const r = (await q("select * from public.mock_submit($1, $2)", [student.id, aid])).rows[0];
      expect(r).toMatchObject({ correct: 0, wrong: 1, blank: 3, passed: false });
      expect(Number(r.mark)).toBe(0); // nunca negativa
      expect(
        (await q("select status from public.mock_attempts where id = $1", [aid])).rows[0].status,
      ).toBe("expired");
    });
  });

  it("anula la pregunta retirada durante el examen y no la cuenta", async () => {
    await tx(async (q) => {
      const { pid } = await seed(q);
      await grant(q, pid);
      const aid = await start(q, pid);
      for (const pos of [0, 1, 2, 3]) await save(q, aid, pos, 1);
      const qid = (
        await q(
          "select question_id from public.mock_attempt_items where attempt_id = $1 and position = 0",
          [aid],
        )
      ).rows[0].question_id;
      await asOwner(q);
      await q("update public.questions set status = 'archived' where id = $1", [qid]);
      const r = (await q("select * from public.mock_submit($1, $2)", [student.id, aid])).rows[0];
      expect(r).toMatchObject({ correct: 3, wrong: 0, blank: 0, void: 1 });
      expect(Number(r.mark)).toBe(10);
    });
  });

  it("el alumno solo ve sus intentos y no puede escribirlos", async () => {
    await tx(async (q) => {
      const { pid } = await seed(q);
      await grant(q, pid);
      const aid = await start(q, pid);
      await q("set local role authenticated");
      await q("select set_config('request.jwt.claims', $1, true)", [
        JSON.stringify({ sub: other.id, role: "authenticated" }),
      ]);
      expect(
        (await q("select id from public.mock_attempts where id = $1", [aid])).rows,
      ).toHaveLength(0);
      await fails(
        q,
        "update public.mock_attempt_items set chosen_index = 1 where attempt_id = $1",
        [aid],
        /permission denied/,
      );
      await fails(q, "select public.mock_start($1, $2)", [other.id, pid], /permission denied/);
      await q("select set_config('request.jwt.claims', $1, true)", [
        JSON.stringify({ sub: student.id, role: "authenticated" }),
      ]);
      expect(
        (
          await q(
            "select count(*)::int as n from public.mock_attempt_items where attempt_id = $1",
            [aid],
          )
        ).rows[0].n,
      ).toBe(4);
    });
  });
});

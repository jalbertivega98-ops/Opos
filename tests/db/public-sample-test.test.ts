import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { cleanup, connect, createUser } from "./helpers";

// ADR-041: test gratis sin registro con preguntas de los temas gratis de cada oposición.
let client: pg.Client;
let owner: { id: string };

type Q = (s: string, p?: unknown[]) => Promise<pg.QueryResult>;

beforeAll(async () => {
  client = await connect();
  owner = await createUser(client, { role: "owner" });
});
afterAll(async () => {
  await cleanup(client, [owner.id]);
  await client.end();
});

/** Prepara una oposición con un tema gratis (2 publicadas + 1 borrador) y otro de pago. */
async function fixture(q: Q) {
  const { rows: org } = await q(
    `insert into public.organizations (slug, name, scope) values ('org-test-muestra', 'Org', 'estatal') returning id`,
  );
  const { rows: exam } = await q(
    `insert into public.exam_bodies (slug, organization_id, name, category, availability, is_published)
     values ('test-opo-muestra', $1, 'Oposición de prueba', 'otros', 'available', true) returning id`,
    [org[0].id],
  );
  const { rows: topics } = await q(
    `insert into public.topics (slug, title) values ('test-muestra-t1', 'Tema 1'), ('test-muestra-t2', 'Tema 2')
     returning id, slug`,
  );
  const t1 = topics.find((t) => t.slug === "test-muestra-t1").id as string;
  const t2 = topics.find((t) => t.slug === "test-muestra-t2").id as string;
  await q(
    `insert into public.exam_body_topics (exam_body_id, topic_id) values ($1, $2), ($1, $3)`,
    [exam[0].id, t1, t2],
  );
  await q("select set_config('request.jwt.claims', $1, true)", [
    JSON.stringify({ sub: owner.id, role: "authenticated" }),
  ]);
  const ids: string[] = [];
  for (const [i, topic] of [t1, t1, t1, t2].entries()) {
    const { rows } = await q(
      `insert into public.questions (stem, explanation, category, content_hash, topic_id, source_ref)
       values ($1, 'Explicación suficiente.', 'prueba', md5($1), $2, 'art. 1') returning id`,
      [`Pregunta de muestra ${i}`, topic],
    );
    const id = rows[0].id as string;
    await q(
      `insert into public.question_options (question_id, label, body, is_correct)
       values ($1,'A','uno',false), ($1,'B','dos',true), ($1,'C','tres',false), ($1,'D','cuatro',false)`,
      [id],
    );
    ids.push(id);
  }
  // Publicadas: las dos primeras del tema 1 (gratis) y la del tema 2 (de pago)
  for (const id of [ids[0], ids[1], ids[3]])
    for (const to of ["needs_review", "approved", "published"])
      await q("update public.questions set status = $2::public.content_status where id = $1", [
        id,
        to,
      ]);
  await q("select set_config('request.jwt.claims', '', true)");
  await q(
    `insert into public.products (slug, type, status, title, exam_body_id, is_free, config)
     values ('test-muestra-gratis', 'question_pack', 'published', 'Gratis', $1, true, $2)`,
    [exam[0].id, JSON.stringify({ topic_slugs: ["test-muestra-t1"] })],
  );
  return { examId: exam[0].id as string, free: [ids[0], ids[1]], draft: ids[2], paid: ids[3] };
}

/** Ejecuta como anon dentro de una transacción que se deshace. */
async function asAnon<T>(fn: (q: Q, f: Awaited<ReturnType<typeof fixture>>) => Promise<T>) {
  await client.query("begin");
  try {
    const q: Q = (s, p) => client.query(s, p as unknown[]);
    const f = await fixture(q);
    await q("set local role anon");
    await q(`select set_config('request.jwt.claims', '{"role":"anon"}', true)`);
    return await fn(q, f);
  } finally {
    await client.query("rollback");
  }
}

describe("test gratis sin registro", () => {
  it("muestra solo preguntas publicadas de los temas gratis, sin la solución", async () => {
    await asAnon(async (q, f) => {
      const { rows } = await q(
        "select * from public.exam_sample_questions('test-opo-muestra', 10)",
      );
      expect(rows.map((r) => r.id).sort()).toEqual([...f.free].sort());
      expect(rows[0].options).toEqual(["uno", "dos", "tres", "cuatro"]);
      expect(rows[0].topic_title).toBe("Tema 1");
      expect(Object.keys(rows[0])).not.toContain("is_correct");
      expect(Object.keys(rows[0])).not.toContain("explanation");
    });
  });

  it("corrige una pregunta gratis y devuelve la solución y la explicación", async () => {
    await asAnon(async (q, f) => {
      const ok = await q(
        "select * from public.check_exam_sample_answer('test-opo-muestra', $1, 1)",
        [f.free[0]],
      );
      expect(ok.rows[0]).toMatchObject({ is_correct: true, answer_index: 1 });
      expect(ok.rows[0].explanation).toEqual({ text: "Explicación suficiente.", ref: "art. 1" });
      const ko = await q(
        "select * from public.check_exam_sample_answer('test-opo-muestra', $1, 0)",
        [f.free[0]],
      );
      expect(ko.rows[0]).toMatchObject({ is_correct: false, answer_index: 1 });
    });
  });

  it("no corrige preguntas de pago, en borrador, de otra oposición ni opciones inexistentes", async () => {
    await asAnon(async (q, f) => {
      const check = async (slug: string, id: string, choice: number) =>
        (await q("select * from public.check_exam_sample_answer($1, $2, $3)", [slug, id, choice]))
          .rows;
      expect(await check("test-opo-muestra", f.paid, 1)).toEqual([]);
      expect(await check("test-opo-muestra", f.draft, 1)).toEqual([]);
      expect(await check("otra-oposicion", f.free[0], 1)).toEqual([]);
      expect(await check("test-opo-muestra", f.free[0], 4)).toEqual([]);
    });
  });

  it("una oposición sin publicar no enseña muestra y anon no ve las funciones internas", async () => {
    await asAnon(async (q, f) => {
      await q("reset role");
      await q("update public.exam_bodies set is_published = false where id = $1", [f.examId]);
      await q("set local role anon");
      const { rows } = await q(
        "select * from public.exam_sample_questions('test-opo-muestra', 10)",
      );
      expect(rows).toEqual([]);
      await expect(q("select public.exam_free_question_ids('test-opo-muestra')")).rejects.toThrow(
        /permission denied/,
      );
    });
  });
});

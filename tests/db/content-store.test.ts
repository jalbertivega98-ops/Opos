import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

let client: pg.Client;
let alice: { id: string }, bob: { id: string }, admin: { id: string };
let editor: { id: string }, owner: { id: string };

type Q = (s: string, p?: unknown[]) => Promise<pg.QueryResult>;

async function seedQuestion(q: Q) {
  const { rows } = await q(
    `insert into public.questions (stem, explanation, category, content_hash)
     values ('¿Cuánto es 3 × 3?', 'Multiplicación: 3 × 3 = 9.', 'numerico', md5(random()::text)) returning id`,
  );
  await q(
    `insert into public.question_options (question_id, label, body, is_correct)
     values ($1,'A','6',false), ($1,'B','9',true), ($1,'C','12',false)`,
    [rows[0].id],
  );
  return rows[0].id as string;
}
/** Espera un error sin abortar la transacción de la prueba. */
async function fails(q: Q, sql: string, params: unknown[], re: RegExp) {
  await q("savepoint s");
  await expect(q(sql, params)).rejects.toThrow(re);
  await q("rollback to savepoint s");
}
const claims = (q: Q, uid: string) =>
  q("select set_config('request.jwt.claims', $1, true)", [
    JSON.stringify({ sub: uid, role: "authenticated" }),
  ]);

beforeAll(async () => {
  client = await connect();
  alice = await createUser(client);
  bob = await createUser(client);
  admin = await createUser(client, { role: "admin" });
  editor = await createUser(client, { role: "editor" });
  owner = await createUser(client, { role: "owner" });
});
afterAll(async () => {
  await client.query("delete from public.products where slug like 'test-%'");
  await cleanup(client, [alice.id, bob.id, admin.id, editor.id, owner.id]);
  await client.end();
});

describe("revisión de contenido (DEC-002)", () => {
  it("rechazo con comentario: solo la persona titular, y queda registrado", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      const id = await seedQuestion(q);
      await q("select public.review_question($1, 'needs_review')", [id]);
      await expect(
        q("select public.review_question($1, 'draft', 'falta fuente')", [id]),
      ).rejects.toThrow(/titular/);
    });
    await as(client, { uid: editor.id }, async (q) => {
      const id = await seedQuestion(q);
      await q("select public.review_question($1, 'needs_review')", [id]);
      await claims(q, owner.id);
      await q("select public.review_question($1, 'draft', 'Falta citar la fuente')", [id]);
      const { rows } = await q(
        "select to_status, comment, reviewer_id from public.question_reviews where question_id = $1 order by id",
        [id],
      );
      expect(rows.map((r) => r.to_status)).toEqual(["needs_review", "draft"]);
      expect(rows[1]).toMatchObject({ comment: "Falta citar la fuente", reviewer_id: owner.id });
      expect(rows[0].comment).toBeNull();
    });
  });

  it("las opciones de una pregunta aprobada no se pueden cambiar", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      const id = await seedQuestion(q);
      await q("select public.review_question($1, 'needs_review')", [id]);
      await claims(q, owner.id);
      await q("select public.review_question($1, 'approved')", [id]);
      await fails(
        q,
        "update public.question_options set is_correct = false where question_id = $1",
        [id],
        /revisión/,
      );
      // devolver a revisión permite editar y anula la aprobación
      await claims(q, editor.id);
      await q("select public.review_question($1, 'needs_review')", [id]);
      await q(
        "update public.question_options set body = '10' where question_id = $1 and label = 'C'",
        [id],
      );
      const { rows } = await q("select reviewed_by from public.questions where id = $1", [id]);
      expect(rows[0].reviewed_by).toBeNull();
    });
  });

  it("solo se borran borradores", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      const id = await seedQuestion(q);
      await q("select public.review_question($1, 'needs_review')", [id]);
      await fails(q, "delete from public.questions where id = $1", [id], /borradores/);
      const id2 = await seedQuestion(q);
      await q("delete from public.questions where id = $1", [id2]);
    });
  });

  it("un alumno no puede usar review_question", async () => {
    const id = await as(client, { uid: editor.id }, async (q) => {
      const qid = await seedQuestion(q);
      await claims(q, alice.id);
      await expect(q("select public.review_question($1, 'needs_review')", [qid])).rejects.toThrow(
        /no encontrada/,
      );
      return qid;
    });
    expect(id).toBeTruthy();
  });
});

describe("tienda: catálogo y accesos", () => {
  let product: string;
  let draft: string;

  beforeAll(async () => {
    const { rows } = await client.query(
      `insert into public.products (slug, type, status, title, included_in_premium)
       values ('test-pack', 'question_pack', 'published', 'Pack de prueba', true),
              ('test-borrador', 'pdf', 'draft', 'PDF en borrador', true)
       returning id, slug`,
    );
    product = rows.find((r) => r.slug === "test-pack").id;
    draft = rows.find((r) => r.slug === "test-borrador").id;
    await client.query(
      "insert into public.product_prices (product_id, amount_cents) values ($1, 999)",
      [product],
    );
  });

  it("anon ve productos publicados y sus precios, no borradores ni contenido", async () => {
    await as(client, "anon", async (q) => {
      const slugs = (await q("select slug from public.products where slug like 'test-%'")).rows;
      expect(slugs.map((r) => r.slug)).toEqual(["test-pack"]);
      const prices = (
        await q("select amount_cents from public.product_prices where product_id = $1", [product])
      ).rows;
      expect(prices).toEqual([{ amount_cents: 999 }]);
      await expect(q("select * from public.product_items")).rejects.toThrow(/permission denied/);
    });
  });

  it("un alumno no puede crear productos, pedidos ni concederse acceso", async () => {
    await as(client, { uid: alice.id }, async (q) => {
      await expect(
        q("insert into public.products (slug, type, title) values ('test-x', 'pdf', 'Hack')"),
      ).rejects.toThrow(/row-level security/);
    });
    for (const sql of [
      "insert into public.orders (user_id, total_cents) values ($1, 0)",
      "insert into public.access_grants (user_id, product_id, source) values ($1, '" +
        "00000000-0000-0000-0000-000000000000', 'admin')",
      "insert into public.subscriptions (user_id, product_id, status) values ($1, '00000000-0000-0000-0000-000000000000', 'active')",
    ]) {
      await expect(as(client, { uid: alice.id }, (q) => q(sql, [alice.id]))).rejects.toThrow(
        /permission denied/,
      );
    }
    await expect(
      as(client, { uid: alice.id }, (q) =>
        q("select public.admin_grant_access($1, $2)", [alice.id, product]),
      ),
    ).rejects.toThrow(/Solo administradores/);
    await expect(
      as(client, { uid: alice.id }, (q) =>
        q("select public.has_product_access($1, $2)", [product, bob.id]),
      ),
    ).rejects.toThrow(/permission denied/);
  });

  it("concesión manual de administración: acceso, biblioteca y revocación auditada", async () => {
    const before = await as(
      client,
      { uid: alice.id },
      async (q) => (await q("select public.my_product_access($1) as ok", [product])).rows[0].ok,
    );
    expect(before).toBe(false);

    await client.query("begin");
    await client.query("set local role authenticated");
    await claims((s, p) => client.query(s, p as unknown[]), admin.id);
    const g = await client.query("select public.admin_grant_access($1, $2, 30, 'regalo') as id", [
      alice.id,
      product,
    ]);
    await client.query("commit");
    const grantId = g.rows[0].id;

    await as(client, { uid: alice.id }, async (q) => {
      expect((await q("select public.my_product_access($1) as ok", [product])).rows[0].ok).toBe(
        true,
      );
      const lib = (await q("select slug, source from public.my_library()")).rows;
      expect(lib).toEqual([{ slug: "test-pack", source: "admin" }]);
      expect((await q("select count(*)::int as n from public.access_grants")).rows[0].n).toBe(1);
    });
    await as(client, { uid: bob.id }, async (q) => {
      expect((await q("select count(*)::int as n from public.access_grants")).rows[0].n).toBe(0);
      expect((await q("select public.my_product_access($1) as ok", [product])).rows[0].ok).toBe(
        false,
      );
    });

    await as(client, { uid: admin.id }, async (q) => {
      const rows = (await q("select kind, email, status from public.admin_list_purchases(50, 0)"))
        .rows;
      expect(rows).toContainEqual(expect.objectContaining({ kind: "grant", status: "active" }));
      await q("select public.admin_revoke_access($1)", [grantId]);
      await claims(q, alice.id);
      expect((await q("select public.my_product_access($1) as ok", [product])).rows[0].ok).toBe(
        false,
      );
    });
    const audit = await client.query(
      "select action from public.audit_log where target_id = $1 and action like 'access.%'",
      [alice.id],
    );
    expect(audit.rows.map((r) => r.action)).toContain("access.granted");
  });

  it("Premium activo da acceso a lo incluido, nunca a borradores", async () => {
    const premium = (await client.query("select id from public.products where slug = 'premium'"))
      .rows[0].id;
    await client.query(
      "insert into public.subscriptions (user_id, product_id, status, current_period_end) values ($1, $2, 'active', now() + interval '1 month')",
      [bob.id, premium],
    );
    await as(client, { uid: bob.id }, async (q) => {
      expect((await q("select public.my_product_access($1) as ok", [product])).rows[0].ok).toBe(
        true,
      );
      expect((await q("select public.my_product_access($1) as ok", [draft])).rows[0].ok).toBe(
        false,
      );
      const data = (await q("select public.export_my_data() as d")).rows[0].d;
      expect(data.subscriptions).toHaveLength(1);
    });
  });

  it("los pedidos se conservan sin datos personales al borrar la cuenta", async () => {
    const u = await createUser(client);
    const o = await client.query(
      "insert into public.orders (user_id, total_cents, status) values ($1, 999, 'paid') returning id",
      [u.id],
    );
    await cleanup(client, [u.id]);
    const { rows } = await client.query("select user_id from public.orders where id = $1", [
      o.rows[0].id,
    ]);
    expect(rows).toEqual([{ user_id: null }]);
    await client.query("delete from public.orders where id = $1", [o.rows[0].id]);
  });
});

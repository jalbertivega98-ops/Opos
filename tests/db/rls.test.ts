import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

let client: pg.Client;
let alice: { id: string }, bob: { id: string }, admin: { id: string }, editor: { id: string };

beforeAll(async () => {
  client = await connect();
  alice = await createUser(client);
  bob = await createUser(client, { locale: "ca" });
  admin = await createUser(client, { role: "admin" });
  editor = await createUser(client, { role: "editor" });
});
afterAll(async () => {
  await cleanup(client, [alice.id, bob.id, admin.id, editor.id]);
  await client.end();
});

describe("profiles", () => {
  it("se crea automáticamente con el idioma de registro", async () => {
    const { rows } = await client.query("select locale, role from public.profiles where id = $1", [
      bob.id,
    ]);
    expect(rows[0]).toEqual({ locale: "ca", role: "student" });
  });

  it("un alumno solo ve su propio perfil", async () => {
    const rows = await as(
      client,
      { uid: alice.id },
      async (q) => (await q("select id from public.profiles")).rows,
    );
    expect(rows.map((r) => r.id)).toEqual([alice.id]);
  });

  it("anon no puede leer perfiles", async () => {
    await expect(as(client, "anon", (q) => q("select * from public.profiles"))).rejects.toThrow(
      /permission denied/,
    );
  });

  it("un alumno no puede autoasignarse rol admin", async () => {
    await expect(
      as(client, { uid: alice.id }, (q) =>
        q("update public.profiles set role = 'admin' where id = $1", [alice.id]),
      ),
    ).rejects.toThrow(/No autorizado/);
  });

  it("un alumno puede editar su nombre e idioma", async () => {
    const r = await as(client, { uid: alice.id }, async (q) =>
      q("update public.profiles set display_name = 'Ana', locale = 'ca' where id = $1", [alice.id]),
    );
    expect(r.rowCount).toBe(1);
  });

  it("un alumno no puede modificar el perfil de otro", async () => {
    const r = await as(client, { uid: alice.id }, (q) =>
      q("update public.profiles set display_name = 'x' where id = $1", [bob.id]),
    );
    expect(r.rowCount).toBe(0);
  });

  it("un admin ve todos los perfiles pero no puede crear otros admins", async () => {
    const n = await as(
      client,
      { uid: admin.id },
      async (q) => (await q("select count(*)::int as n from public.profiles")).rows[0].n,
    );
    expect(n).toBeGreaterThanOrEqual(4);
    await expect(
      as(client, { uid: admin.id }, (q) =>
        q("update public.profiles set role = 'admin' where id = $1", [alice.id]),
      ),
    ).rejects.toThrow(/propietario/);
  });

  it("un admin puede suspender a un alumno", async () => {
    const r = await as(client, { uid: admin.id }, (q) =>
      q("update public.profiles set status = 'suspended' where id = $1", [alice.id]),
    );
    expect(r.rowCount).toBe(1);
  });
});

describe("actividad y auditoría", () => {
  it("track_activity registra eventos válidos y rechaza tipos desconocidos", async () => {
    await as(client, { uid: alice.id }, async (q) => {
      await q("select public.track_activity('auth.sign_in')");
      const { rows } = await q("select kind from public.activity_events");
      expect(rows).toEqual([{ kind: "auth.sign_in" }]);
      await expect(q("select public.track_activity('hack.everything')")).rejects.toThrow(
        /no permitido/,
      );
    });
  });

  it("los alumnos no pueden insertar eventos ni leer la auditoría", async () => {
    await expect(
      as(client, { uid: alice.id }, (q) =>
        q("insert into public.activity_events (user_id, kind) values ($1, 'auth.sign_in')", [
          bob.id,
        ]),
      ),
    ).rejects.toThrow(/permission denied/);
    const rows = await as(
      client,
      { uid: alice.id },
      async (q) => (await q("select * from public.audit_log")).rows,
    );
    expect(rows).toEqual([]);
    await expect(
      as(client, { uid: alice.id }, (q) => q("select public.log_admin_action('x.test')")),
    ).rejects.toThrow(/No autorizado/);
  });
});

describe("catálogo", () => {
  it("anon lee oposiciones publicadas pero no puede escribir", async () => {
    const n = await as(
      client,
      "anon",
      async (q) => (await q("select count(*)::int n from public.exam_bodies")).rows[0].n,
    );
    expect(n).toBeGreaterThan(0);
    await expect(
      as(client, "anon", (q) => q("update public.exam_bodies set name = 'x'")),
    ).rejects.toThrow(/permission denied/);
  });

  it("un alumno no puede modificar el catálogo; un editor sí", async () => {
    const r = await as(client, { uid: alice.id }, (q) =>
      q("update public.exam_bodies set name = name"),
    );
    expect(r.rowCount).toBe(0);
    const r2 = await as(client, { uid: editor.id }, (q) =>
      q("update public.exam_bodies set name = name"),
    );
    expect(r2.rowCount).toBeGreaterThan(0);
  });

  it("las oposiciones de un alumno son privadas", async () => {
    await as(client, { uid: alice.id }, async (q) => {
      await q(
        `insert into public.user_exam_targets (user_id, exam_body_id, is_primary)
         select $1, id, true from public.exam_bodies where slug = 'mossos-esquadra'`,
        [alice.id],
      );
    });
    await expect(
      as(client, { uid: bob.id }, (q) =>
        q(
          `insert into public.user_exam_targets (user_id, exam_body_id)
           select $1, id from public.exam_bodies limit 1`,
          [alice.id],
        ),
      ),
    ).rejects.toThrow(/row-level security/);
  });
});

describe("banco de preguntas", () => {
  async function seedQuestion(
    q: (s: string, p?: unknown[]) => Promise<pg.QueryResult>,
    isFree = true,
  ) {
    const { rows } = await q(
      `insert into public.questions (stem, explanation, category, content_hash, is_free)
       values ('¿Cuánto es 2 + 2?', 'Suma básica: 2 + 2 = 4.', 'numerico', md5(random()::text), $1) returning id`,
      [isFree],
    );
    const id = rows[0].id;
    await q(
      `insert into public.question_options (question_id, label, body, is_correct)
       values ($1,'A','3',false), ($1,'B','4',true), ($1,'C','5',false)`,
      [id],
    );
    return id as string;
  }

  it("los alumnos no pueden leer opciones ni la respuesta correcta", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      await seedQuestion(q);
      // mismo contexto de transacción: cambiamos a un alumno
      await q("select set_config('request.jwt.claims', $1, true)", [
        JSON.stringify({ sub: alice.id, role: "authenticated" }),
      ]);
      expect((await q("select is_correct from public.question_options")).rows).toEqual([]);
    });
    await expect(
      as(client, "anon", (q) => q("select is_correct from public.question_options")),
    ).rejects.toThrow(/permission denied/);
    const rows = await as(
      client,
      { uid: alice.id },
      async (q) => (await q("select * from public.questions")).rows,
    );
    expect(rows).toEqual([]);
  });

  it("no se puede publicar sin pasar por revisión humana", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      const id = await seedQuestion(q);
      await expect(
        q("update public.questions set status = 'published' where id = $1", [id]),
      ).rejects.toThrow(/no permitida/);
    });
  });

  it("flujo completo draft → needs_review → approved → published y demo sin respuesta", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      const id = await seedQuestion(q);
      for (const s of ["needs_review", "approved", "published"]) {
        await q("update public.questions set status = $2 where id = $1", [id, s]);
      }
      const { rows } = await q(
        "select reviewed_by, published_at from public.questions where id = $1",
        [id],
      );
      expect(rows[0].reviewed_by).toBe(editor.id);
      expect(rows[0].published_at).not.toBeNull();

      // La función de demo no expone is_correct
      await q("set local role anon");
      const demo = (await q("select * from public.get_demo_questions(null, 50)")).rows.find(
        (r) => r.id === id,
      );
      expect(JSON.stringify(demo.options)).not.toContain("is_correct");
      const optB = demo.options.find((o: { label: string }) => o.label === "B").id;
      const check = (await q("select * from public.check_demo_answer($1, $2)", [id, optB])).rows[0];
      expect(check.is_correct).toBe(true);
    });
  });

  it("no se aprueba una pregunta con dos respuestas correctas o sin explicación", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      await expect(
        q(
          `with qq as (insert into public.questions (stem, category, content_hash) values ('Pregunta sin explicación', 'x1', md5(random()::text)) returning id)
           insert into public.question_options (question_id, label, body, is_correct)
           select id, l, l, true from qq, unnest(array['A','B']) l`,
        ),
      ).rejects.toThrow(/duplicate key|unique/);
    });
  });

  it("detecta duplicados por hash de contenido", async () => {
    await as(client, { uid: editor.id }, async (q) => {
      await q(
        `insert into public.questions (stem, category, content_hash) values ('Duplicada uno', 'xx', 'h1')`,
      );
      await expect(
        q(
          `insert into public.questions (stem, category, content_hash) values ('Duplicada dos', 'xx', 'h1')`,
        ),
      ).rejects.toThrow(/duplicate key/);
    });
  });
});

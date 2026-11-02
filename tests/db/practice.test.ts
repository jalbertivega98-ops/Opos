import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

let client: pg.Client;
let alice: { id: string }, bob: { id: string }, admin: { id: string };

const item = (seed: number, extra: Record<string, unknown> = {}) => ({
  source: "generator",
  item_type: "series",
  category: "psycho_series",
  difficulty: 2,
  seed,
  generator_version: 1,
  presented: { presentation: { kind: "sequence", terms: ["1", "2"] }, options: ["3", "4", "5"] },
  ...extra,
});

/** Crea una sesión real (commit) como service_role y devuelve su id. */
async function start(user: string, items = [item(1), item(2)]) {
  await client.query("begin");
  await client.query("set local role service_role");
  const { rows } = await client.query(
    "select public.practice_start($1, 'psycho', 'series', $2::jsonb) as id",
    [user, JSON.stringify(items)],
  );
  await client.query("commit");
  return rows[0].id as string;
}

async function answer(user: string, session: string, pos: number, correct: boolean) {
  await client.query("begin");
  try {
    await client.query("set local role service_role");
    const { rows } = await client.query(
      'select * from public.practice_record_answer($1, $2, $3::smallint, 0::smallint, $4, 1::smallint, \'{"key":"x"}\'::jsonb)',
      [user, session, pos, correct],
    );
    await client.query("commit");
    return rows[0];
  } catch (e) {
    await client.query("rollback");
    throw e;
  }
}

beforeAll(async () => {
  client = await connect();
  alice = await createUser(client);
  bob = await createUser(client);
  admin = await createUser(client, { role: "admin" });
});
afterAll(async () => {
  await cleanup(client, [alice.id, bob.id, admin.id]);
  await client.end();
});

describe("practice: escritura protegida", () => {
  it("un alumno no puede insertar ni modificar resultados con su JWT", async () => {
    await expect(
      as(client, { uid: alice.id }, (q) =>
        q(
          "insert into public.practice_sessions (user_id, mode, item_type, item_count) values ($1, 'psycho', 'series', 1)",
          [alice.id],
        ),
      ),
    ).rejects.toThrow(/permission denied/);
    const s = await start(alice.id);
    await expect(
      as(client, { uid: alice.id }, (q) =>
        q("update public.practice_items set is_correct = true where session_id = $1", [s]),
      ),
    ).rejects.toThrow(/permission denied/);
  });

  it("un alumno no puede llamar a las funciones de escritura", async () => {
    await expect(
      as(client, { uid: alice.id }, (q) =>
        q("select public.practice_start($1, 'psycho', 'series', '[]'::jsonb)", [alice.id]),
      ),
    ).rejects.toThrow(/permission denied/);
    await expect(
      as(client, "anon", (q) =>
        q(
          "select public.practice_record_answer($1, gen_random_uuid(), 0::smallint, 0::smallint, true, 0::smallint, '{}'::jsonb)",
          [alice.id],
        ),
      ),
    ).rejects.toThrow(/permission denied/);
  });
});

describe("practice: flujo de una sesión", () => {
  it("registra respuestas en orden, mide el tiempo y cierra la sesión", async () => {
    const s = await start(alice.id);
    await expect(answer(alice.id, s, 1, true)).rejects.toThrow(/en orden/);
    const r1 = await answer(alice.id, s, 0, true);
    expect(r1).toMatchObject({ finished: false, answered_count: 1, correct_count: 1 });
    expect(r1.time_ms).toBeGreaterThanOrEqual(0);
    await expect(answer(alice.id, s, 0, true)).rejects.toThrow(/en orden|disponible/);
    const r2 = await answer(alice.id, s, 1, false);
    expect(r2).toMatchObject({ finished: true, answered_count: 2, correct_count: 1 });
    await expect(answer(alice.id, s, 1, true)).rejects.toThrow(/no está activa/);
    const { rows } = await client.query(
      "select status, finished_at is not null as done from public.practice_sessions where id = $1",
      [s],
    );
    expect(rows[0]).toEqual({ status: "finished", done: true });
  });

  it("no deja responder sesiones de otro usuario", async () => {
    const s = await start(alice.id);
    await expect(answer(bob.id, s, 0, true)).rejects.toThrow(/no encontrada/);
  });

  it("empezar una sesión abandona la anterior activa", async () => {
    const s1 = await start(bob.id);
    await start(bob.id);
    const { rows } = await client.query(
      "select status from public.practice_sessions where id = $1",
      [s1],
    );
    expect(rows[0].status).toBe("abandoned");
  });

  it("no acepta usuarios suspendidos", async () => {
    const u = await createUser(client);
    await client.query("update public.profiles set status = 'suspended' where id = $1", [u.id]);
    await expect(start(u.id)).rejects.toThrow(/no activa/);
    await client.query("rollback").catch(() => {});
    await cleanup(client, [u.id]);
  });
});

describe("practice: lectura y estadísticas", () => {
  it("cada alumno solo ve sus propias sesiones e ítems", async () => {
    const rows = await as(
      client,
      { uid: bob.id },
      async (q) => (await q("select distinct user_id from public.practice_items")).rows,
    );
    expect(rows.map((r) => r.user_id)).toEqual([bob.id]);
    await expect(
      as(client, "anon", (q) => q("select * from public.practice_sessions")),
    ).rejects.toThrow(/permission denied/);
  });

  it("my_practice_stats devuelve totales, racha y serie diaria propios", async () => {
    const stats = await as(
      client,
      { uid: alice.id },
      async (q) => (await q("select public.my_practice_stats(7) as s")).rows[0].s,
    );
    expect(stats.totals).toMatchObject({ answered: 2, correct: 1, pending_review: 1 });
    expect(stats.sessions_finished).toBe(1);
    expect(stats.streak).toBe(1);
    expect(stats.daily).toHaveLength(7);
    expect(stats.daily.at(-1)).toMatchObject({ answered: 2, correct: 1 });
    expect(stats.by_type).toEqual([expect.objectContaining({ item_type: "series", answered: 2 })]);
  });

  it("acertar en un repaso resuelve el fallo original", async () => {
    const { rows: failed } = await client.query(
      "select session_id, position from public.practice_items where user_id = $1 and is_correct = false",
      [alice.id],
    );
    const f = failed[0];
    const s = await start(alice.id, [
      item(2, { review_of_session: f.session_id, review_of_position: f.position }),
    ]);
    await answer(alice.id, s, 0, true);
    const { rows } = await client.query(
      "select reviewed_at is not null as ok from public.practice_items where session_id = $1 and position = $2",
      [f.session_id, f.position],
    );
    expect(rows[0].ok).toBe(true);
  });

  it("no permite repasar ítems de otro usuario", async () => {
    const { rows } = await client.query(
      "select session_id, position from public.practice_items where user_id = $1 limit 1",
      [alice.id],
    );
    await expect(
      start(bob.id, [
        item(3, { review_of_session: rows[0].session_id, review_of_position: rows[0].position }),
      ]),
    ).rejects.toThrow(/ajeno/);
    await client.query("rollback").catch(() => {});
  });

  it("las métricas agregadas son solo para administradores", async () => {
    await expect(
      as(client, { uid: alice.id }, (q) => q("select public.admin_practice_metrics()")),
    ).rejects.toThrow(/Solo administradores/);
    const m = await as(
      client,
      { uid: admin.id },
      async (q) => (await q("select public.admin_practice_metrics() as m")).rows[0].m,
    );
    expect(m.answers_7d).toBeGreaterThanOrEqual(3);
  });

  it("la exportación RGPD incluye la práctica", async () => {
    const data = await as(
      client,
      { uid: alice.id },
      async (q) => (await q("select public.export_my_data() as d")).rows[0].d,
    );
    expect(data.practice_answers.length).toBeGreaterThanOrEqual(3);
    expect(data.practice_answers[0]).not.toHaveProperty("user_id");
  });
});

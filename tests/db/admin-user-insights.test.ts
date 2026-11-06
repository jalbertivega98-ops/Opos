import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

type Insights = {
  subscriptions: { id: string; status: string; provider: string; active: boolean }[];
  grants: { product: string; status: string }[];
  orders: unknown[];
  promo_codes: { code: string; percent_off: string | number | null }[];
  sessions: { action: string }[];
  presence: { today_seconds: number; last30_seconds: number; days: unknown[] };
  study: { practice_count: number; mock_count: number; recent: unknown[] };
};

describe("ficha completa del alumno (ADR-038)", () => {
  let client: pg.Client;
  let student: string;
  let admin: string;
  let other: string;
  let premium: string;
  let pack: string;

  beforeAll(async () => {
    client = await connect();
    student = (await createUser(client)).id;
    other = (await createUser(client)).id;
    admin = (await createUser(client, { role: "admin" })).id;
    const { rows } = await client.query(
      `insert into public.products (slug, type, status, title, included_in_premium)
       values ('test-ins-prem-' || substr(md5(random()::text), 1, 8), 'subscription', 'published', 'Premium prueba', false),
              ('test-ins-pack-' || substr(md5(random()::text), 1, 8), 'question_pack', 'published', 'Pack prueba', true)
       returning id, type`,
    );
    premium = rows.find((r) => r.type === "subscription").id;
    pack = rows.find((r) => r.type === "question_pack").id;
    await client.query(
      `insert into auth.audit_log_entries (instance_id, id, payload, created_at, ip_address)
       values ('00000000-0000-0000-0000-000000000000', gen_random_uuid(),
               json_build_object('action','login','actor_id',$1::text), now() - interval '1 hour', '1.2.3.4'),
              ('00000000-0000-0000-0000-000000000000', gen_random_uuid(),
               json_build_object('action','logout','actor_id',$1::text), now(), '1.2.3.4'),
              ('00000000-0000-0000-0000-000000000000', gen_random_uuid(),
               json_build_object('action','token_refreshed','actor_id',$1::text), now(), '1.2.3.4')`,
      [student],
    );
  });
  afterAll(async () => {
    await client.query("delete from auth.audit_log_entries where payload->>'actor_id' = $1", [
      student,
    ]);
    await cleanup(client, [student, other, admin]);
    await client.query("delete from public.products where slug like 'test-ins-%'");
    await client.end();
  });

  it("el latido suma como mucho un minuto aunque lleguen avisos seguidos", async () => {
    const seconds = await as(client, { uid: student }, async (q) => {
      await q("select public.track_presence()");
      await q("select public.track_presence()");
      await q("select public.track_presence()");
      const { rows } = await q("select seconds from public.user_presence_daily");
      return rows.map((r) => r.seconds);
    });
    expect(seconds).toEqual([60]);
  });

  it("el alumno no puede escribir su tiempo ni ver el de otros", async () => {
    await client.query(
      "insert into public.user_presence_daily (user_id, day, seconds) values ($1, current_date, 120)",
      [other],
    );
    await expect(
      as(client, { uid: student }, (q) =>
        q("insert into public.user_presence_daily (user_id, day) values ($1, current_date)", [
          student,
        ]),
      ),
    ).rejects.toThrow(/permission denied/);
    await as(client, { uid: student }, async (q) => {
      const { rows } = await q("select * from public.user_presence_daily");
      expect(rows).toHaveLength(0);
    });
    await as(client, "anon", async (q) => {
      await expect(q("select public.track_presence()")).rejects.toThrow(/permission denied/);
    });
  });

  it("solo administración ve la ficha, sin IP y con entradas y salidas", async () => {
    await client.query(
      "insert into public.user_presence_daily (user_id, day, seconds) values ($1, (now() at time zone 'Europe/Madrid')::date, 600) on conflict (user_id, day) do update set seconds = 600",
      [student],
    );
    await expect(
      as(client, { uid: student }, (q) => q("select public.admin_user_insights($1)", [student])),
    ).rejects.toThrow(/Solo administradores/);
    const ins = await as(client, { uid: admin }, async (q) => {
      const { rows } = await q("select public.admin_user_insights($1) as v", [student]);
      const audit = await q(
        "select 1 from public.audit_log where action = 'user.insights_viewed' and target_id = $1",
        [student],
      );
      expect(audit.rowCount).toBe(1);
      return rows[0].v as Insights;
    });
    expect(ins.sessions.map((s) => s.action)).toEqual(["logout", "login"]);
    expect(JSON.stringify(ins)).not.toContain("1.2.3.4");
    expect(ins.presence.today_seconds).toBe(600);
    expect(ins.presence.last30_seconds).toBe(600);
    expect(ins.study.practice_count).toBe(0);
  });

  it("regalar Premium crea una suscripción sin Stripe que da acceso y se puede terminar", async () => {
    await expect(
      as(client, { uid: student }, (q) =>
        q("select public.admin_grant_premium($1, $2, 30, null)", [student, premium]),
      ),
    ).rejects.toThrow(/Solo administradores/);
    await expect(
      as(client, { uid: admin }, (q) =>
        q("select public.admin_grant_premium($1, $2, 30, null)", [student, pack]),
      ),
    ).rejects.toThrow(/Producto no disponible/);
    await as(client, { uid: admin }, async (q) => {
      const { rows } = await q("select public.admin_grant_premium($1, $2, 30, 'regalo') as id", [
        student,
        premium,
      ]);
      const sub = rows[0].id as string;
      const has = async () =>
        (await q("select public.has_product_access($1, $2) as ok", [pack, student])).rows[0]
          .ok as boolean;
      await q("set local role postgres");
      expect(await has()).toBe(true);
      await q("set local role authenticated");
      let ins = (await q("select public.admin_user_insights($1) as v", [student])).rows[0]
        .v as Insights;
      expect(ins.subscriptions[0]).toMatchObject({ provider: "none", active: true });
      await q("select public.admin_end_premium($1)", [sub]);
      await q("set local role postgres");
      expect(await has()).toBe(false);
      await q("set local role authenticated");
      ins = (await q("select public.admin_user_insights($1) as v", [student])).rows[0]
        .v as Insights;
      expect(ins.subscriptions[0]).toMatchObject({ status: "canceled", active: false });
      await q("savepoint again");
      await expect(q("select public.admin_end_premium($1)", [sub])).rejects.toThrow(
        /no encontrada/,
      );
      await q("rollback to savepoint again");
    });
  });

  it("las suscripciones de Stripe no se terminan desde el panel", async () => {
    const { rows } = await client.query(
      `insert into public.subscriptions (user_id, product_id, status, provider, provider_ref)
       values ($1, $2, 'active', 'stripe', 'sub_test_ins') returning id`,
      [student, premium],
    );
    try {
      await expect(
        as(client, { uid: admin }, (q) => q("select public.admin_end_premium($1)", [rows[0].id])),
      ).rejects.toThrow(/no encontrada/);
    } finally {
      await client.query("delete from public.subscriptions where id = $1", [rows[0].id]);
    }
  });

  it("registra códigos promocionales solo para administración", async () => {
    const args = [
      student,
      "BIENVENIDA20",
      "stripe_test",
      "co_x",
      "promo_x",
      20,
      null,
      "once",
      null,
    ];
    const sql =
      "select public.admin_record_promo_code($1, $2, $3, $4, $5, $6, $7, $8, $9, null, null)";
    await expect(as(client, { uid: student }, (q) => q(sql, args))).rejects.toThrow(
      /Solo administradores/,
    );
    await as(client, { uid: admin }, async (q) => {
      await q(sql, args);
      const ins = (await q("select public.admin_user_insights($1) as v", [student])).rows[0]
        .v as Insights;
      expect(ins.promo_codes).toHaveLength(1);
      expect(ins.promo_codes[0].code).toBe("BIENVENIDA20");
    });
    await as(client, { uid: student }, async (q) => {
      const { rows } = await q("select * from public.admin_promo_codes");
      expect(rows).toHaveLength(0);
    });
  });

  it("la exportación de datos incluye el tiempo dentro", async () => {
    const data = await as(client, { uid: student }, async (q) => {
      const { rows } = await q("select public.export_my_data() as d");
      return rows[0].d as { time_in_app: { seconds: number }[] };
    });
    expect(data.time_in_app.length).toBeGreaterThanOrEqual(1);
  });
});

import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

describe("cifras de audiencia del panel (admin_audience_metrics)", () => {
  let client: pg.Client;
  const ids: string[] = [];
  let student: string;
  let admin: string;

  beforeAll(async () => {
    client = await connect();
    student = (await createUser(client)).id;
    admin = (await createUser(client, { role: "admin" })).id;
    ids.push(student, admin);
    await client.query(
      `insert into auth.audit_log_entries (instance_id, id, payload, created_at)
       values ('00000000-0000-0000-0000-000000000000', gen_random_uuid(),
               json_build_object('action','login','actor_id',$1::text), now()),
              ('00000000-0000-0000-0000-000000000000', gen_random_uuid(),
               json_build_object('action','token_refreshed','actor_id',$1::text), now())`,
      [student],
    );
  });
  afterAll(async () => {
    await client.query("delete from auth.audit_log_entries where payload->>'actor_id' = $1", [
      student,
    ]);
    await cleanup(client, ids);
    await client.end();
  });

  it("devuelve solo agregados y cuenta altas, entradas y visitas", async () => {
    await client.query(
      "insert into public.traffic_daily (kind, channel, source, path, hits) values ('visit','direct','direct','/test-audience',3) on conflict (day, kind, channel, source, path) do update set hits = traffic_daily.hits + 3",
    );
    let m: Record<string, number>;
    try {
      m = await as(client, { uid: admin }, async (q) => {
        const { rows } = await q("select public.admin_audience_metrics() as m");
        return rows[0].m as Record<string, number>;
      });
    } finally {
      await client.query("delete from public.traffic_daily where path = '/test-audience'");
    }
    expect(Object.keys(m).sort()).toEqual(
      [
        "logins_30d",
        "logins_7d",
        "logins_today",
        "signups_30d",
        "signups_7d",
        "signups_today",
        "users_confirmed",
        "users_total",
        "visits_30d",
        "visits_7d",
        "visits_today",
      ].sort(),
    );
    expect(m.users_total).toBeGreaterThanOrEqual(2);
    expect(m.signups_7d).toBeGreaterThanOrEqual(2);
    expect(m.logins_today).toBeGreaterThanOrEqual(1);
    expect(m.logins_7d).toBeGreaterThanOrEqual(m.logins_today);
    expect(m.visits_today).toBeGreaterThanOrEqual(3);
    expect(m.visits_30d).toBeGreaterThanOrEqual(m.visits_7d);
    expect(m.signups_30d).toBeGreaterThanOrEqual(m.signups_7d);
  });

  it("da una fila por día con visitas, registros y entradas", async () => {
    const rows = await as(client, { uid: admin }, async (q) => {
      const r = await q("select * from public.admin_audience_daily(7)");
      return r.rows as { day: Date; visits: string; signups: string; logins: string }[];
    });
    expect(rows).toHaveLength(7);
    const today = rows[6];
    expect(Number(today.signups)).toBeGreaterThanOrEqual(2);
    expect(Number(today.logins)).toBeGreaterThanOrEqual(1);
    await expect(
      as(client, { uid: student }, (q) => q("select * from public.admin_audience_daily(7)")),
    ).rejects.toThrow(/Solo administradores/);
  });

  it("cuenta como entrada el latido de la zona del alumno aunque Auth no deje registro", async () => {
    const quiet = (await createUser(client)).id;
    ids.push(quiet);
    const count = async () =>
      as(client, { uid: admin }, async (q) => {
        const { rows } = await q("select public.admin_audience_metrics() as m");
        return (rows[0].m as Record<string, number>).logins_today;
      });
    const before = await count();
    await client.query(
      `insert into public.user_presence_daily (user_id, day, seconds)
       values ($1, (now() at time zone 'Europe/Madrid')::date, 60)`,
      [quiet],
    );
    expect(await count()).toBe(before + 1);
    // Una segunda fuente para la misma persona no la cuenta dos veces.
    await client.query(
      "insert into public.activity_events (user_id, kind) values ($1, 'test.kind')",
      [quiet],
    );
    expect(await count()).toBe(before + 1);
  });

  it("no expone la función auxiliar de días de entrada", async () => {
    await expect(
      as(client, { uid: admin }, (q) => q("select * from public.admin_login_days(now())")),
    ).rejects.toThrow(/permission denied/);
  });

  it("el alumnado y anon no pueden consultarlo", async () => {
    await expect(
      as(client, { uid: student }, (q) => q("select public.admin_audience_metrics()")),
    ).rejects.toThrow(/Solo administradores/);
    await expect(
      as(client, "anon", (q) => q("select public.admin_audience_metrics()")),
    ).rejects.toThrow(/permission denied/);
  });
});

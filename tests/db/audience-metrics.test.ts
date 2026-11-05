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
    await client.query("update auth.users set last_sign_in_at = now() where id = $1", [student]);
  });
  afterAll(async () => {
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
    expect(m.logins_7d).toBeGreaterThanOrEqual(1);
    expect(m.visits_today).toBeGreaterThanOrEqual(3);
    expect(m.visits_30d).toBeGreaterThanOrEqual(m.visits_7d);
    expect(m.signups_30d).toBeGreaterThanOrEqual(m.signups_7d);
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

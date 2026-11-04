import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

describe("analítica de captación (traffic_daily)", () => {
  let client: pg.Client;
  const ids: string[] = [];
  let student: string;
  let admin: string;

  beforeAll(async () => {
    client = await connect();
    student = (await createUser(client)).id;
    admin = (await createUser(client, { role: "admin" })).id;
    ids.push(student, admin);
  });
  afterAll(async () => {
    await cleanup(client, ids);
    await client.end();
  });

  it("solo service_role registra y los contadores se acumulan", async () => {
    await as(client, "service", async (q) => {
      await q("select public.track_traffic('visit','ai','chatgpt','/oposiciones/mossos-esquadra')");
      await q("select public.track_traffic('visit','ai','chatgpt','/oposiciones/mossos-esquadra')");
      const { rows } = await q(
        "select hits from public.traffic_daily where source = 'chatgpt' and day = current_date",
      );
      expect(rows[0].hits).toBeGreaterThanOrEqual(2);
    });
    for (const who of ["anon", { uid: student }, { uid: admin }] as const) {
      await expect(
        as(client, who, (q) => q("select public.track_traffic('visit','ai','chatgpt','/')")),
      ).rejects.toThrow(/permission denied/);
    }
  });

  it("rechaza valores fuera de los permitidos", async () => {
    await expect(
      as(client, "service", (q) =>
        q("select public.track_traffic('visit','ai','Evil Source','/')"),
      ),
    ).rejects.toThrow(/check constraint/);
    await expect(
      as(client, "service", (q) =>
        q("select public.track_traffic('visit','ai','chatgpt','https://evil.example')"),
      ),
    ).rejects.toThrow(/check constraint/);
  });

  it("el alumnado y anon no leen nada; el personal sí", async () => {
    await client.query(
      "insert into public.traffic_daily (kind, channel, source, path, hits) values ('crawler','search','googlebot','/test-rls',1) on conflict do nothing",
    );
    try {
      const anon = await as(client, "anon", (q) =>
        q("select count(*)::int as n from public.traffic_daily").catch(() => ({
          rows: [{ n: 0 }],
        })),
      );
      expect(anon.rows[0].n).toBe(0);
      const st = await as(client, { uid: student }, (q) =>
        q("select count(*)::int as n from public.traffic_daily"),
      );
      expect(st.rows[0].n).toBe(0);
      const ad = await as(client, { uid: admin }, (q) =>
        q("select count(*)::int as n from public.traffic_daily where path = '/test-rls'"),
      );
      expect(ad.rows[0].n).toBe(1);
      await expect(
        as(client, { uid: admin }, (q) => q("delete from public.traffic_daily")),
      ).rejects.toThrow(/permission denied/);
    } finally {
      await client.query("delete from public.traffic_daily where path = '/test-rls'");
    }
  });
});

import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

type Funnel = Record<string, number> & {
  by_exam: { exam: string; starts: number; finishes: number }[];
};

const EXAM = "test-embudo";

describe("embudo de conversión del panel (admin_funnel)", () => {
  let client: pg.Client;
  const ids: string[] = [];
  let student: string;
  let admin: string;

  const funnel = (days = 7) =>
    as(client, { uid: admin }, async (q) => {
      const { rows } = await q("select public.admin_funnel($1) as f", [days]);
      return rows[0].f as Funnel;
    });

  beforeAll(async () => {
    client = await connect();
    student = (await createUser(client)).id;
    admin = (await createUser(client, { role: "admin" })).id;
    ids.push(student, admin);
  });
  afterAll(async () => {
    await client.query("delete from public.funnel_daily where exam = $1", [EXAM]);
    await client.query("delete from public.orders where user_id = any($1::uuid[])", [ids]);
    await cleanup(client, ids);
    await client.end();
  });

  it("solo service_role registra pasos del test gratis y solo los permitidos", async () => {
    await client.query(
      `begin; set local role service_role;
       select public.track_funnel('sample_start', '${EXAM}');
       select public.track_funnel('sample_start', '${EXAM}');
       select public.track_funnel('sample_finish', '${EXAM}');
       commit;`,
    );
    for (const who of ["anon", { uid: student }, { uid: admin }] as const) {
      await expect(
        as(client, who, (q) => q(`select public.track_funnel('sample_start', '${EXAM}')`)),
      ).rejects.toThrow(/permission denied/);
    }
    await expect(
      as(client, "service", (q) => q(`select public.track_funnel('pay', '${EXAM}')`)),
    ).rejects.toThrow(/check constraint/);
    await expect(
      as(client, "service", (q) => q("select public.track_funnel('sample_start', 'Evil Exam')")),
    ).rejects.toThrow(/check constraint/);
    for (const who of ["anon", { uid: student }, { uid: admin }] as const) {
      const n = await as(client, who, async (q) => {
        const { rows } = await q("select count(*)::int as n from public.funnel_daily").catch(
          () => ({ rows: [{ n: -1 }] }),
        );
        return rows[0].n as number;
      });
      expect(n).toBeLessThanOrEqual(0);
    }
  });

  it("cuenta cada paso y por oposición", async () => {
    const f = await funnel(7);
    expect(Object.keys(f).sort()).toEqual(
      [
        "by_exam",
        "days",
        "onboarded",
        "paying",
        "practicing",
        "sample_finish",
        "sample_start",
        "signups",
        "visits",
      ].sort(),
    );
    expect(f.days).toBe(7);
    expect(f.sample_start).toBeGreaterThanOrEqual(2);
    expect(f.sample_finish).toBeGreaterThanOrEqual(1);
    expect(f.signups).toBeGreaterThanOrEqual(2);
    expect(f.by_exam.find((e) => e.exam === EXAM)).toEqual({ exam: EXAM, starts: 2, finishes: 1 });
  });

  it("los pasos de cuenta avanzan con onboarding, práctica y pago real (no regalos)", async () => {
    const before = await funnel(7);
    await client.query("update public.profiles set onboarding_completed_at = now() where id = $1", [
      student,
    ]);
    await client.query(
      `insert into public.practice_sessions (user_id, mode, item_type, item_count, answered_count)
       values ($1, 'questions', 'question', 10, 3)`,
      [student],
    );
    await client.query(
      "insert into public.orders (user_id, status, total_cents, provider) values ($1, 'paid', 999, 'none')",
      [student],
    );
    const mid = await funnel(7);
    expect(mid.onboarded).toBe(before.onboarded + 1);
    expect(mid.practicing).toBe(before.practicing + 1);
    expect(mid.paying).toBe(before.paying);
    await client.query(
      "insert into public.orders (user_id, status, total_cents, provider) values ($1, 'paid', 999, 'stripe')",
      [student],
    );
    const after = await funnel(7);
    expect(after.paying).toBe(before.paying + 1);
  });

  it("el alumnado y anon no pueden consultarlo", async () => {
    await expect(
      as(client, { uid: student }, (q) => q("select public.admin_funnel(7)")),
    ).rejects.toThrow(/Solo administradores/);
    await expect(as(client, "anon", (q) => q("select public.admin_funnel(7)"))).rejects.toThrow(
      /permission denied/,
    );
  });
});

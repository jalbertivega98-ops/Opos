import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

type Win = Record<string, number>;
type Overview = {
  days: number;
  current: Win;
  previous: Win;
  premium_paid_active: number;
  premium_gift_active: number;
  mrr_cents: number;
};

describe("resumen del panel con comparativa (admin_overview)", () => {
  let client: pg.Client;
  const ids: string[] = [];
  let student: string;
  let admin: string;

  const overview = (days: number) =>
    as(client, { uid: admin }, async (q) => {
      const { rows } = await q("select public.admin_overview($1) as o", [days]);
      return rows[0].o as Overview;
    });

  beforeAll(async () => {
    client = await connect();
    student = (await createUser(client)).id;
    admin = (await createUser(client, { role: "admin" })).id;
    ids.push(student, admin);
  });
  afterAll(async () => {
    await client.query("delete from public.orders where user_id = any($1::uuid[])", [ids]);
    await cleanup(client, ids);
    await client.end();
  });

  it("solo lo ve un administrador", async () => {
    await expect(
      as(client, { uid: student }, (q) => q("select public.admin_overview(7)")),
    ).rejects.toThrow(/Solo administradores/);
    await expect(as(client, "anon", (q) => q("select public.admin_overview(7)"))).rejects.toThrow();
  });

  it("separa el periodo actual del anterior y cuenta ventas y Premium", async () => {
    const before = await overview(7);
    expect(before.days).toBe(7);

    // Pack pagado hoy (actual) y otro hace 10 días (periodo anterior); uno de
    // prueba (stripe_test) y uno pendiente no cuentan.
    await client.query(
      `insert into public.orders (user_id, status, total_cents, provider, created_at, paid_at) values
         ($1, 'paid', 999, 'stripe', now(), now()),
         ($1, 'paid', 699, 'stripe', now() - interval '10 days', now() - interval '10 days'),
         ($1, 'paid', 5000, 'stripe_test', now(), now()),
         ($1, 'pending', 5000, 'stripe', now(), null)`,
      [student],
    );
    const { rows: price } = await client.query(
      `select pp.id, pp.product_id, pp.amount_cents from public.product_prices pp
         join public.products p on p.id = pp.product_id
        where p.type = 'subscription' and pp.billing_interval = 'month' limit 1`,
    );
    expect(price).toHaveLength(1);
    await client.query(
      `insert into public.subscriptions (user_id, product_id, price_id, status, provider, current_period_end)
       values ($1, $2, $3, 'active', 'stripe', now() + interval '20 days'),
              ($1, $2, null, 'active', 'none', now() + interval '20 days')`,
      [student, price[0].product_id, price[0].id],
    );

    const after = await overview(7);
    const d = (w: "current" | "previous", k: string) => after[w][k] - before[w][k];
    expect(d("current", "pack_sales")).toBe(1);
    expect(d("current", "pack_revenue_cents")).toBe(999);
    expect(d("previous", "pack_sales")).toBe(1);
    expect(d("previous", "pack_revenue_cents")).toBe(699);
    expect(d("current", "new_premium")).toBe(1);
    expect(d("current", "new_premium_cents")).toBe(price[0].amount_cents);
    expect(after.premium_paid_active - before.premium_paid_active).toBe(1);
    expect(after.premium_gift_active - before.premium_gift_active).toBe(1);
    expect(after.mrr_cents - before.mrr_cents).toBe(price[0].amount_cents);
    // Las dos cuentas de la prueba se crearon hoy
    expect(after.current.signups).toBeGreaterThanOrEqual(2);
  });

  it("limita el periodo a 1–90 días", async () => {
    expect((await overview(500)).days).toBe(90);
    expect((await overview(0)).days).toBe(1);
  });
});

import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

let client: pg.Client;
let alice: { id: string };

type Q = (s: string, p?: unknown[]) => Promise<pg.QueryResult>;

async function product(q: Q, type = "question_pack") {
  const { rows } = await q(
    `insert into public.products (slug, type, status, title, included_in_premium)
     values ('test-bill-' || substr(md5(random()::text), 1, 8), $1, 'published', 'Pack de prueba', true)
     returning id`,
    [type],
  );
  return rows[0].id as string;
}
const access = async (q: Q, p: string, u: string) =>
  (await q("select public.has_product_access($1, $2) as ok", [p, u])).rows[0].ok as boolean;

beforeAll(async () => {
  client = await connect();
  alice = await createUser(client);
});
afterAll(async () => {
  await client.query("delete from public.products where slug like 'test-bill-%'");
  await cleanup(client, [alice.id]);
  await client.end();
});

describe("cobros (Stripe → pedidos y accesos)", () => {
  it("nadie con su JWT puede registrar pagos ni leer clientes/avisos", async () => {
    await as(client, { uid: alice.id }, async (q) => {
      await expect(
        q(
          `select public.billing_record_payment($1, gen_random_uuid(), null, 'pi_x', 100, 'eur', 'stripe_test')`,
          [alice.id],
        ),
      ).rejects.toThrow(/permission denied/);
    });
    await as(client, { uid: alice.id }, async (q) => {
      await expect(q("select * from public.billing_customers")).rejects.toThrow(
        /permission denied/,
      );
    });
    await as(client, "anon", async (q) => {
      await expect(q("select public.billing_refund_payment('pi_x')")).rejects.toThrow(
        /permission denied/,
      );
    });
  });

  it("pago único: pedido pagado + acceso; repetido no duplica; reembolso lo retira", async () => {
    await as(client, "service", async (q) => {
      const p = await product(q);
      expect(await access(q, p, alice.id)).toBe(false);
      const pay = () =>
        q(
          `select public.billing_record_payment($1, $2, null, 'pi_test_1', 4900, 'eur', 'stripe_test') as id`,
          [alice.id, p],
        );
      const first = (await pay()).rows[0].id;
      const again = (await pay()).rows[0].id;
      expect(again).toBe(first);
      const { rows: orders } = await q(
        "select status, total_cents, currency, provider from public.orders where provider_ref = 'pi_test_1'",
      );
      expect(orders).toEqual([
        { status: "paid", total_cents: 4900, currency: "EUR", provider: "stripe_test" },
      ]);
      const { rows: grants } = await q(
        "select count(*)::int as n from public.access_grants where order_id = $1",
        [first],
      );
      expect(grants[0].n).toBe(1);
      expect(await access(q, p, alice.id)).toBe(true);

      expect((await q("select public.billing_refund_payment('pi_test_1') as r")).rows[0].r).toBe(
        true,
      );
      expect((await q("select public.billing_refund_payment('pi_test_1') as r")).rows[0].r).toBe(
        false,
      );
      expect(await access(q, p, alice.id)).toBe(false);
    });
  });

  it("no se puede «comprar» una suscripción como pago único", async () => {
    await as(client, "service", async (q) => {
      const sub = await product(q, "subscription");
      await expect(
        q(
          `select public.billing_record_payment($1, $2, null, 'pi_test_2', 100, 'eur', 'stripe_test')`,
          [alice.id, sub],
        ),
      ).rejects.toThrow(/pago único/);
    });
  });

  it("Premium: activo da acceso a lo incluido; cancelado o impagado, no", async () => {
    await as(client, "service", async (q) => {
      const premium = await product(q, "subscription");
      const pack = await product(q);
      const sync = (status: string, end = "now() + interval '30 days'") =>
        q(
          `select public.billing_sync_subscription($1, $2, null, 'sub_test_1', $3::public.subscription_status,
                                                    ${end}, false, 'stripe_test') as id`,
          [alice.id, premium, status],
        );
      const id = (await sync("active")).rows[0].id;
      expect(await access(q, pack, alice.id)).toBe(true);
      expect((await sync("past_due")).rows[0].id).toBe(id);
      expect(await access(q, pack, alice.id)).toBe(false);
      await sync("active");
      expect(await access(q, pack, alice.id)).toBe(true);
      await sync("canceled");
      expect(await access(q, pack, alice.id)).toBe(false);
      const { rows } = await q(
        "select count(*)::int as n from public.subscriptions where provider_ref = 'sub_test_1'",
      );
      expect(rows[0].n).toBe(1);
    });
  });

  it("proveedor desconocido rechazado", async () => {
    await as(client, "service", async (q) => {
      const p = await product(q);
      await expect(
        q(`select public.billing_record_payment($1, $2, null, 'pi_test_3', 1, 'eur', 'paypal')`, [
          alice.id,
          p,
        ]),
      ).rejects.toThrow(/Proveedor/);
    });
  });
});

import { expect, test } from "@playwright/test";
import pg from "pg";
import Stripe from "stripe";
import { confirmEmail, newEmail, signUp } from "./helpers";

/**
 * Pagos en modo de pruebas SIN cuenta de Stripe: el servidor arranca con una
 * clave ficticia (sk_test_…) y un secreto de webhook local (playwright.config.ts).
 * Se firman avisos como lo haría Stripe y se comprueba que dan acceso.
 */
const SECRET = process.env.STRIPE_WEBHOOK_SECRET ?? "whsec_e2e_local";
const DB_URL = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";
const stripe = new Stripe("sk_test_e2e_dummy");

async function db<T>(fn: (c: pg.Client) => Promise<T>) {
  const c = new pg.Client({ connectionString: DB_URL });
  await c.connect();
  try {
    return await fn(c);
  } finally {
    await c.end();
  }
}

test.describe("Pagos (Stripe en modo de pruebas)", () => {
  test("webhook firmado da acceso; sin firma o repetido no hace nada", async ({
    page,
    request,
  }) => {
    const email = newEmail("compra");
    await signUp(page, email, "Compradora");
    await confirmEmail(page, email);

    const slug = `test-e2e-pack-${Date.now()}`;
    const { userId, productId, priceId } = await db(async (c) => {
      const u = await c.query("select id from auth.users where email = $1", [email]);
      const p = await c.query(
        `insert into public.products (slug, type, status, title, is_test)
         values ($1, 'question_pack', 'published', 'Pack E2E de pago', true) returning id`,
        [slug],
      );
      const pr = await c.query(
        `insert into public.product_prices (product_id, amount_cents) values ($1, 1900) returning id`,
        [p.rows[0].id],
      );
      return { userId: u.rows[0].id, productId: p.rows[0].id, priceId: pr.rows[0].id };
    });

    try {
      const payload = JSON.stringify({
        id: `evt_e2e_${Date.now()}`,
        object: "event",
        type: "checkout.session.completed",
        livemode: false,
        data: {
          object: {
            id: "cs_test_e2e",
            object: "checkout.session",
            mode: "payment",
            payment_status: "paid",
            payment_intent: `pi_e2e_${Date.now()}`,
            amount_total: 1900,
            currency: "eur",
            livemode: false,
            metadata: { user_id: userId, product_id: productId, price_id: priceId },
          },
        },
      });

      // Sin firma válida: rechazado
      const forged = await request.post("/api/stripe/webhook", {
        data: payload,
        headers: { "content-type": "application/json", "stripe-signature": "t=1,v1=bad" },
      });
      expect(forged.status()).toBe(400);

      const signed = () =>
        request.post("/api/stripe/webhook", {
          data: payload,
          headers: {
            "content-type": "application/json",
            "stripe-signature": stripe.webhooks.generateTestHeaderString({
              payload,
              secret: SECRET,
            }),
          },
        });
      const ok = await signed();
      expect(ok.status()).toBe(200);
      expect((await ok.json()).result).toBe("paid");
      expect((await (await signed()).json()).result).toBe("duplicate");

      await page.goto("/app/perfil");
      await expect(page.getByTestId("purchases")).toContainText("Pack E2E de pago");
      await expect(page.getByTestId("purchases")).toContainText("Comprado");

      const orders = await db((c) =>
        c.query("select status, total_cents from public.orders where user_id = $1", [userId]),
      );
      expect(orders.rows).toEqual([{ status: "paid", total_cents: 1900 }]);
    } finally {
      await db(async (c) => {
        await c.query("delete from public.orders where user_id = $1", [userId]);
        await c.query("delete from public.products where slug = $1", [slug]);
      });
    }
  });

  test("Premium de su oposición: botón de compra con consentimiento y aviso de modo de pruebas", async ({
    page,
  }) => {
    const email = newEmail("premium");
    await signUp(page, email, "Premium");
    await confirmEmail(page, email);
    const slug = `test-e2e-premium-${Date.now()}`;
    await db(async (c) => {
      const u = await c.query("select id from auth.users where email = $1", [email]);
      const exam = await c.query(
        "select id from public.exam_bodies where slug = 'mossos-esquadra'",
      );
      await c.query(
        `insert into public.user_exam_targets (user_id, exam_body_id, is_primary) values ($1, $2, true)
         on conflict do nothing`,
        [u.rows[0].id, exam.rows[0].id],
      );
      const p = await c.query(
        `insert into public.products (slug, type, status, title, exam_body_id, included_in_premium)
         values ($1, 'subscription', 'published', 'Premium · Mossos (E2E)', $2, false) returning id`,
        [slug, exam.rows[0].id],
      );
      await c.query(
        `insert into public.product_prices (product_id, amount_cents, billing_interval) values ($1, 1299, 'month')`,
        [p.rows[0].id],
      );
    });
    try {
      // La portada deja de poner «Próximamente» y lleva a la compra
      await page.goto("/");
      await page.locator("#precios").getByRole("link", { name: "Hazte Premium" }).click();
      await expect(page).toHaveURL(/\/app\/perfil(#suscripcion)?$/);
      const form = page.getByTestId("buy-form").last();
      await expect(form).toContainText("Modo de pruebas");
      const button = form.getByTestId("buy-button");
      await expect(button).toHaveText(/Hazte Premium/);
      // La casilla es obligatoria: sin marcarla no se sale de la página
      await button.click();
      await expect(page).toHaveURL(/\/app\/perfil(#suscripcion)?$/);
      // Con la clave ficticia Stripe rechaza la sesión: error controlado, sin cobro
      await form.getByRole("checkbox").check();
      await button.click();
      await expect(page.getByTestId("checkout-notice")).toHaveAttribute("data-notice", "error", {
        timeout: 20_000,
      });

      await page.goto("/app/perfil?compra=cancelada");
      await expect(page.getByTestId("checkout-notice")).toContainText("No se ha cobrado nada");
    } finally {
      await db((c) => c.query("delete from public.products where slug = $1", [slug]));
    }
  });
});

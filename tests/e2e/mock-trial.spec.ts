import { expect, test } from "@playwright/test";
import pg from "pg";
import { confirmEmail, newEmail, signUp } from "./helpers";

async function db<T>(fn: (c: pg.Client) => Promise<T>) {
  const c = new pg.Client({
    connectionString: process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia",
  });
  await c.connect();
  try {
    return await fn(c);
  } finally {
    await c.end();
  }
}

/**
 * Primer simulacro gratis (ADR-048): sin Premium ni packs, la alumna ve los
 * simulacros de su oposición, empieza uno y lo puede retomar; los demás se cierran.
 */
test("el primer simulacro de la oposición es gratis y se puede retomar", async ({ page }) => {
  test.setTimeout(120_000);
  const email = newEmail("prueba-gratis");
  await signUp(page, email, "Gratis");
  await confirmEmail(page, email);
  const stamp = Date.now();
  const slugs = [`test-e2e-trial-a-${stamp}`, `test-e2e-trial-b-${stamp}`];
  await db(async (c) => {
    const u = await c.query("select id from auth.users where email = $1", [email]);
    const exam = await c.query("select id from public.exam_bodies where slug = 'mossos-esquadra'");
    await c.query(
      `insert into public.user_exam_targets (user_id, exam_body_id, is_primary) values ($1, $2, true)
       on conflict do nothing`,
      [u.rows[0].id, exam.rows[0].id],
    );
    for (const [i, slug] of slugs.entries())
      await c.query(
        `insert into public.products (slug, type, status, title, exam_body_id, config)
         values ($1, 'mock_exam', 'published', $2, $3,
                 '{"kind":"psycho","questions":10,"minutes":10,"penalty":0,"pass_mark":5,"max_mark":10}')`,
        [slug, `Simulacro gratis E2E ${i + 1}`, exam.rows[0].id],
      );
  });
  try {
    await page.goto("/app/simulacros");
    await expect(page.getByTestId("mock-trial")).toContainText("Tu primer simulacro es gratis");
    const first = page.getByTestId("library-item").filter({ hasText: "Simulacro gratis E2E 1" });
    await expect(
      page.getByTestId("library-item").filter({ hasText: "Simulacro gratis E2E 2" }),
    ).toBeVisible();
    await first.getByTestId("mock-start").click();
    await expect(page).toHaveURL(/\/app\/simulacros\/[0-9a-f-]{36}$/);
    const attempt = page.url();

    // En curso: solo queda ese, y se retoma el mismo intento
    await page.goto("/app/simulacros");
    await expect(
      page.getByTestId("library-item").filter({ hasText: "Simulacro gratis E2E 2" }),
    ).toHaveCount(0);
    await first.getByTestId("mock-start").click();
    await expect(page).toHaveURL(attempt);
  } finally {
    await db(async (c) => {
      await c.query(
        "delete from public.mock_attempts where product_id in (select id from public.products where slug = any($1))",
        [slugs],
      );
      await c.query("delete from public.products where slug = any($1)", [slugs]);
    });
  }
});

import { expect, test } from "@playwright/test";

test.describe("Textos legales", () => {
  for (const [slug, title, text] of [
    ["aviso-legal", "Aviso legal", "Ley 34/2002"],
    ["condiciones", "Condiciones", "desistimiento"],
    ["privacidad", "Privacidad", "Stripe"],
    ["cookies", "Cookies", "técnicas"],
  ] as const) {
    test(`${slug}: muestra el texto`, async ({ page }) => {
      await page.goto(`/legal/${slug}`);
      await expect(page.getByRole("heading", { level: 1 })).toHaveText(title);
      await expect(page.locator("article")).toContainText(text);
    });
  }

  test("titular: la marca OPOSAPRUEBA, sin datos personales", async ({ page }) => {
    await page.goto("/legal/aviso-legal");
    await expect(page.locator("article")).toContainText("Titular: OPOSAPRUEBA");
    await expect(page.getByTestId("legal-pending")).toHaveCount(0);
    await expect(
      page.getByRole("contentinfo").getByRole("link", { name: "Aviso legal" }),
    ).toBeVisible();
  });

  test("en catalán avisa de que el texto está en castellano", async ({ page }) => {
    await page.goto("/ca/legal/condiciones");
    await expect(page.getByText("només està disponible en castellà")).toBeVisible();
  });

  test("documento inexistente da 404", async ({ page }) => {
    const res = await page.goto("/legal/inventado");
    expect(res?.status()).toBe(404);
  });
});

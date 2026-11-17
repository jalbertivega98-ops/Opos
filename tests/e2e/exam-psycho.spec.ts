import { expect, test } from "@playwright/test";

test.describe("Psicotécnicos por oposición (ADR-063)", () => {
  test("Mossos: formato oficial, práctica gratis y enlaces", async ({ page }) => {
    await page.goto("/oposiciones/mossos-esquadra");
    await expect(page.getByTestId("exam-psycho-link")).toHaveAttribute(
      "href",
      "/oposiciones/mossos-esquadra/psicotecnicos",
    );

    await page.goto("/oposiciones/mossos-esquadra/psicotecnicos");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText(
      "Psicotécnicos de Mossos d'Esquadra gratis",
    );
    await expect(page).toHaveTitle(/^Psicotécnicos Mossos d'Esquadra gratis/);
    await expect(page.getByTestId("official-format")).toContainText("80 preguntas en 35 minutos");
    await expect(page.getByRole("heading", { name: "Ejercicio 1 de 10" })).toBeVisible();
    await expect(page.getByRole("link", { name: /Matrices/ }).first()).toHaveAttribute(
      "href",
      /\/psicotecnicos\//,
    );
    await expect(page.locator('link[rel="canonical"]')).toHaveAttribute(
      "href",
      /\/oposiciones\/mossos-esquadra\/psicotecnicos$/,
    );
  });

  test("sitemap y oposiciones sin psicotécnico", async ({ request, page }) => {
    const xml = await (await request.get("/sitemap.xml")).text();
    expect(xml).toContain("/oposiciones/mossos-esquadra/psicotecnicos");
    expect(xml).toContain("/ca/oposiciones/auxiliar-administrativo-estado/psicotecnicos");
    expect(xml).not.toContain("/oposiciones/auxilio-judicial/psicotecnicos");
    expect((await request.get("/oposiciones/auxilio-judicial/psicotecnicos")).status()).toBe(404);

    await page.goto("/oposiciones/auxilio-judicial");
    await expect(page.getByTestId("exam-psycho-link")).toHaveCount(0);
  });
});

import { expect, test } from "@playwright/test";

// ADR-052: guía de la prueba física de Mossos con baremos oficiales y calculadora.
test.describe("Prueba física de Mossos (ADR-052)", () => {
  test("se llega desde la ficha y la calculadora da la nota con los baremos", async ({ page }) => {
    await page.goto("/oposiciones/mossos-esquadra");
    await page.getByTestId("physical-test-link").click();
    await expect(page).toHaveURL(/\/oposiciones\/mossos-esquadra\/prueba-fisica$/);
    // Carga directa (la navegación en cliente conserva un momento las etiquetas de la ficha)
    await page.reload();
    await expect(page.getByRole("heading", { level: 1 })).toContainText("Prueba física");
    await expect(page.locator('link[rel="alternate"][hreflang="ca"]')).toHaveAttribute(
      "href",
      /\/ca\/oposiciones\/mossos-esquadra\/prueba-fisica$/,
    );
    await expect(page.getByTestId("scale-men")).toContainText("21,5");
    await expect(page.getByRole("link", { name: /ISP\/1763\/2026/ })).toHaveAttribute(
      "href",
      /dogc\.gencat\.cat/,
    );

    const calc = page.getByTestId("physical-calculator");
    await calc.getByLabel("Hombres").check();
    await page.getByTestId("physical-mark-agility").fill("18.9");
    await page.getByTestId("physical-mark-bench").fill("31");
    await page.getByTestId("physical-mark-shuttle").fill("9");
    await expect(page.getByTestId("physical-total")).toHaveText("Nota de la prueba: 5 de 10");
    await expect(calc).toContainText("Aprobada");

    // Un 0 en un ejercicio elimina aunque la media llegue
    await page.getByTestId("physical-mark-bench").fill("50");
    await page.getByTestId("physical-mark-agility").fill("16");
    await page.getByTestId("physical-mark-shuttle").fill("6");
    await expect(calc).toContainText("0 puntos en algún ejercicio");
  });

  test("Bombers: baremos de medio punto, tiempos en minutos y sin mínimo por ejercicio", async ({
    page,
  }) => {
    await page.goto("/oposiciones/bombers-generalitat");
    await expect(page.getByTestId("physical-test-link")).toHaveAttribute(
      "href",
      "/oposiciones/bombers-generalitat/prueba-fisica",
    );
    await page.goto("/oposiciones/bombers-generalitat/prueba-fisica");
    await expect(page.getByRole("heading", { level: 1 })).toContainText(
      "Pruebas físicas de Bombers",
    );
    await expect(page.getByTestId("scale-women")).toContainText("Mujeres");
    await expect(page.getByTestId("scale-women")).toContainText(`6'00" a 6'05"`);
    await expect(page.getByTestId("scale-men")).toContainText("Resto de personas");
    await expect(page.getByTestId("scale-men")).toContainText(`≤ 1'26"`);

    const calc = page.getByTestId("physical-calculator");
    await calc.getByLabel("Resto de personas").check();
    await page.getByTestId("physical-mark-vegetation").fill("4:35");
    await page.getByTestId("physical-mark-structural").fill("2:41");
    await page.getByTestId("physical-mark-water").fill("3'23");
    await expect(page.getByTestId("physical-total")).toHaveText("Nota de la prueba: 5 de 10");
    await expect(calc).toContainText("Aprobada");

    // Sin mínimo por ejercicio: un 0 no elimina si la media llega al 5
    await page.getByTestId("physical-mark-vegetation").fill("6:00");
    await page.getByTestId("physical-mark-structural").fill("1:20");
    await page.getByTestId("physical-mark-water").fill("2:00");
    await expect(page.getByTestId("physical-points-vegetation")).toHaveText("0 puntos");
    await expect(calc).toContainText("Aprobada");

    await page.getByTestId("physical-mark-water").fill("abc");
    await expect(calc).toContainText("minutos y segundos");
  });

  test("solo existe para oposiciones con guía y está en el sitemap", async ({ page, request }) => {
    const res = await page.goto("/oposiciones/auxilio-judicial/prueba-fisica");
    expect(res?.status()).toBe(404);
    const xml = await (await request.get("/sitemap.xml")).text();
    expect(xml).toContain("/oposiciones/mossos-esquadra/prueba-fisica");
    expect(xml).toContain("/ca/oposiciones/mossos-esquadra/prueba-fisica");
    expect(xml).toContain("/oposiciones/bombers-generalitat/prueba-fisica");
  });
});

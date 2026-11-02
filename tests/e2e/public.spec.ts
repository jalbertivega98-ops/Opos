import { expect, test } from "@playwright/test";

test.describe("Web pública", () => {
  test("landing con buscador que lleva al catálogo", async ({ page }) => {
    await page.goto("/");
    await expect(page.getByRole("heading", { level: 1 })).toContainText("Prepara tu oposición");
    await page.getByLabel("Busca tu oposición").fill("mossos");
    await page.getByRole("button", { name: "Buscar" }).click();
    await expect(page).toHaveURL(/\/oposiciones\?q=mossos/);
    const cards = page.getByTestId("exam-card");
    await expect(cards).toHaveCount(1);
    await expect(cards.first()).toContainText("Próximamente");
  });

  test("ficha de oposición sin contenido indica 'próximamente' y no inventa datos", async ({
    page,
  }) => {
    await page.goto("/oposiciones/policia-nacional-basica");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText(
      "Policía Nacional · Escala Básica",
    );
    await expect(page.getByText("todavía no tiene contenido suficiente")).toBeVisible();
    await expect(page.getByText("Aún no hemos publicado convocatorias verificadas")).toBeVisible();
  });

  test("filtro por categoría y búsqueda sin resultados", async ({ page }) => {
    await page.goto("/oposiciones?category=justicia");
    await expect(page.getByTestId("exam-card")).toHaveCount(2);
    await page.goto("/oposiciones?q=zzzz%25%2C(");
    await expect(page.getByText("No hemos encontrado oposiciones")).toBeVisible();
  });

  test("cambio de idioma a catalán", async ({ page }) => {
    await page.goto("/oposiciones");
    await page.getByRole("button", { name: "Català" }).first().click();
    await expect(page).toHaveURL(/\/ca\/oposiciones/);
    await expect(page.getByRole("heading", { level: 1 })).toHaveText("Catàleg d'oposicions");
    await expect(page.locator("html")).toHaveAttribute("lang", "ca");
  });

  test("404 para rutas inexistentes", async ({ page }) => {
    const res = await page.goto("/esto-no-existe");
    expect(res?.status()).toBe(404);
    await expect(page.getByText("Página no encontrada")).toBeVisible();
  });

  test("cabeceras de seguridad", async ({ request }) => {
    const res = await request.get("/");
    expect(res.headers()["x-frame-options"]).toBe("DENY");
    expect(res.headers()["x-content-type-options"]).toBe("nosniff");
    expect(res.headers()["x-powered-by"]).toBeUndefined();
  });
});

test.describe("Móvil @mobile", () => {
  test("sin desbordamiento horizontal y menú accesible @mobile", async ({ page }) => {
    await page.goto("/");
    const overflow = await page.evaluate(
      () => document.documentElement.scrollWidth - window.innerWidth,
    );
    expect(overflow).toBeLessThanOrEqual(0);
    await page.getByLabel("Menú").first().click();
    await page
      .getByRole("navigation", { name: "Menú" })
      .getByRole("link", { name: "Oposiciones" })
      .click();
    await expect(page).toHaveURL(/\/oposiciones$/);
  });
});

test.describe("Demo de psicotécnicos", () => {
  test("completa 10 series con corrección en servidor", async ({ page }) => {
    await page.goto("/psicotecnicos");
    await expect(page.getByRole("heading", { level: 1 })).toContainText("series numéricas");
    // La respuesta no está en el HTML enviado al cliente
    const html = await page.content();
    expect(html).not.toContain("answerIndex");
    for (let i = 1; i <= 10; i++) {
      await expect(page.getByRole("heading", { name: `Serie ${i} de 10` })).toBeVisible();
      await page
        .getByRole("group", { name: "¿Qué número continúa la serie?" })
        .getByRole("button")
        .first()
        .click();
      await expect(page.getByText(/¡Correcto!|Incorrecto\. La respuesta era/)).toBeVisible();
      await page.getByRole("button", { name: i === 10 ? "Ver resultado" : "Siguiente" }).click();
    }
    await expect(page.getByTestId("series-result")).toContainText(/Has acertado \d+ de 10/);
  });
});

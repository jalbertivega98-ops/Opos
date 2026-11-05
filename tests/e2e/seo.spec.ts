import { expect, test } from "@playwright/test";
import { confirmEmail, grantRole, newEmail, signUp } from "./helpers";

/** Lee los bloques JSON-LD de la página. */
async function jsonLdTypes(page: import("@playwright/test").Page) {
  const blocks = await page.locator('script[type="application/ld+json"]').allTextContents();
  return blocks.flatMap((b) => {
    const data = JSON.parse(b);
    return (Array.isArray(data) ? data : [data]).flatMap((d) => d["@type"]);
  });
}

test.describe("SEO y GEO (ADR-025)", () => {
  test("robots.txt, sitemap.xml y llms.txt responden", async ({ request }) => {
    const robots = await request.get("/robots.txt");
    expect(robots.status()).toBe(200);
    // En local no es indexable: se bloquea todo.
    expect(await robots.text()).toContain("Disallow: /");

    const sitemap = await request.get("/sitemap.xml");
    expect(sitemap.status()).toBe(200);
    const xml = await sitemap.text();
    expect(xml).toContain("/oposiciones/mossos-esquadra");
    expect(xml).toContain("/ca/psicotecnicos/interpretacion-de-tablas");
    expect(xml).toContain('hreflang="ca"');
    // Fichas «próximamente» sin guía: fuera del sitemap.
    expect(xml).not.toContain("/oposiciones/guardia-urbana-barcelona");

    const llms = await request.get("/llms.txt");
    expect(llms.headers()["content-type"]).toContain("text/plain");
    expect(await llms.text()).toContain("# OPOSAPRUEBA");
  });

  test("guía de oposición: canonical, hreflang, datos oficiales y JSON-LD", async ({ page }) => {
    await page.goto("/oposiciones/auxiliar-administrativo-estado");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText(
      "Oposiciones a Auxiliar Administrativo del Estado",
    );
    await expect(page.locator('link[rel="canonical"]')).toHaveAttribute(
      "href",
      /\/oposiciones\/auxiliar-administrativo-estado$/,
    );
    await expect(page.locator('link[rel="alternate"][hreflang="ca"]')).toHaveAttribute(
      "href",
      /\/ca\/oposiciones\/auxiliar-administrativo-estado$/,
    );
    await expect(
      page.getByText("1.700 (156 reservadas a personas con discapacidad)"),
    ).toBeVisible();
    await expect(page.getByRole("link", { name: /BOE-A-2025-26262/ })).toHaveAttribute(
      "href",
      /boe\.es/,
    );
    expect(await jsonLdTypes(page)).toEqual(
      expect.arrayContaining(["BreadcrumbList", "WebPage", "FAQPage"]),
    );
    // Enlace a la página del tipo de psicotécnico.
    await page.getByRole("link", { name: "Interpretación de tablas" }).click();
    await expect(page).toHaveURL(/\/psicotecnicos\/interpretacion-de-tablas$/);
  });

  test("página de tipo de psicotécnico: entrenador, método y datos estructurados", async ({
    page,
  }) => {
    await page.goto("/ca/psicotecnicos/matrices");
    await expect(page.locator("html")).toHaveAttribute("lang", "ca");
    await expect(page.getByRole("heading", { level: 1 })).toContainText("matrius");
    await page.getByTestId("psycho-option").first().click();
    await expect(page.getByText(/Correcte|Incorrecte/)).toBeVisible();
    expect(await page.content()).not.toContain("answerIndex");
    expect(await jsonLdTypes(page)).toEqual(expect.arrayContaining(["Quiz", "BreadcrumbList"]));
  });

  test("zonas privadas y búsquedas no indexables", async ({ page }) => {
    await page.goto("/entrar");
    await expect(page.locator('meta[name="robots"]')).toHaveAttribute("content", /noindex/);
    await page.goto("/oposiciones?q=mossos");
    await expect(page.locator('meta[name="robots"]')).toHaveAttribute("content", /noindex/);
    await expect(page.locator('link[rel="canonical"]')).toHaveAttribute("href", /\/oposiciones$/);
  });

  test("el panel de tráfico registra visitas desde IA y solo lo ve el personal", async ({
    page,
    request,
  }) => {
    test.setTimeout(90_000);
    await request.get("/psicotecnicos/probabilidad", {
      headers: {
        accept: "text/html",
        "sec-fetch-dest": "document",
        referer: "https://www.perplexity.ai/search?q=psicotecnicos",
      },
    });
    const email = newEmail("trafico");
    await signUp(page, email, "Admin");
    await confirmEmail(page, email);
    await page.goto("/admin/trafico");
    await expect(page).not.toHaveURL(/\/admin\/trafico$/); // alumna: sin acceso
    grantRole(email, "admin");
    await page.goto("/admin/trafico");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText(
      "Tráfico desde buscadores e IA",
    );
    await expect(page.getByTestId("traffic-landings")).toContainText(
      "/psicotecnicos/probabilidad · perplexity",
    );
  });
});

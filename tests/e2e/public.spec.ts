import { expect, test } from "@playwright/test";
import pg from "pg";
import { DB_URL } from "./sample-seed";

/** Contador de hoy de un paso del embudo para un tipo de psicotécnico (ADR-069). */
async function funnelHits(step: string, exam: string): Promise<number> {
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    const { rows } = await db.query(
      `select coalesce(sum(hits), 0)::int as n from public.funnel_daily
        where step = $1 and exam = $2 and day = (now() at time zone 'Europe/Madrid')::date`,
      [step, exam],
    );
    return rows[0].n as number;
  } finally {
    await db.end();
  }
}

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

  test("la portada deja resolver el ejercicio de muestra", async ({ page }) => {
    await page.goto("/");
    const options = page.getByRole("group", { name: "Opciones de respuesta" }).first();
    await options.getByRole("button", { name: /42/ }).click();
    await expect(page.getByText("¡Correcto! La respuesta es 42.")).toBeVisible();
    await page.getByRole("button", { name: "Volver a intentarlo" }).click();
    await options.getByRole("button", { name: /36/ }).click();
    await expect(page.getByText("No es esa. La respuesta correcta es 42.")).toBeVisible();
  });

  test("ficha de oposición sin contenido indica 'próximamente' y no inventa datos", async ({
    page,
  }) => {
    // Guardia Urbana ya tiene guía y contenido (ADR-039): usamos una sin publicar.
    await page.goto("/oposiciones/correos-personal-laboral");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText("Correos · Personal laboral");
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

  test("el menú se cierra al elegir, al pulsar fuera y con Escape @mobile", async ({ page }) => {
    await page.goto("/");
    const toggle = page.getByRole("button", { name: "Menú", exact: true });
    const menu = page.getByRole("navigation", { name: "Menú" });

    // Elegir una opción: navega, se cierra y marca la página actual
    await toggle.click();
    await expect(menu).toBeVisible();
    await menu.getByRole("link", { name: "Psicotécnicos" }).click();
    await expect(page).toHaveURL(/\/psicotecnicos$/);
    await expect(menu).toBeHidden();
    await page.getByRole("button", { name: "Menú", exact: true }).click();
    await expect(menu.getByRole("link", { name: "Psicotécnicos" })).toHaveAttribute(
      "aria-current",
      "page",
    );

    // Pulsar fuera
    await page.locator("main").click({ position: { x: 10, y: 10 } });
    await expect(menu).toBeHidden();

    // Escape devuelve el foco al botón
    await toggle.click();
    await expect(menu).toBeVisible();
    await page.keyboard.press("Escape");
    await expect(menu).toBeHidden();
    await expect(toggle).toBeFocused();

    // Ancla en la misma página: también se cierra
    await page.goto("/");
    await toggle.click();
    await menu.getByRole("link", { name: /precios/i }).click();
    await expect(menu).toBeHidden();
  });
});

test.describe("Demo de psicotécnicos", () => {
  test("completa 10 series con corrección en servidor y sin guardar nada", async ({ page }) => {
    const starts = await funnelHits("psycho_start", "series");
    const signups = await funnelHits("psycho_signup", "series");
    await page.goto("/psicotecnicos");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText("Psicotécnicos");
    await expect(page.getByText("¿Qué número continúa la serie?")).toBeVisible();
    // La respuesta no está en el HTML enviado al cliente
    const html = await page.content();
    expect(html).not.toContain("answerIndex");
    for (let i = 1; i <= 10; i++) {
      await expect(page.getByRole("heading", { name: `Ejercicio ${i} de 10` })).toBeVisible();
      if (i === 2) {
        // se puede dejar en blanco: enseña la solución sin contarla como fallo
        await page.getByTestId("psycho-skip").click();
        await expect(page.getByText(/En blanco\. La respuesta era/)).toBeVisible();
      } else {
        await page
          .getByRole("group", { name: "Opciones de respuesta" })
          .getByRole("button")
          .first()
          .click();
        await expect(page.getByText(/¡Correcto!|Incorrecto\. La respuesta era/)).toBeVisible();
      }
      await page.getByRole("button", { name: i === 10 ? "Ver resultado" : "Siguiente" }).click();
    }
    await expect(page.getByTestId("series-result")).toContainText(/Has acertado \d+ de 10/);
    await expect(page.getByTestId("series-blank")).toHaveText("En blanco: 1.");
    await expect(page.getByText("Los resultados de la demostración no se guardan.")).toBeVisible();
    await expect(page.getByRole("link", { name: "Crear cuenta gratis" }).last()).toBeVisible();
    // El embudo cuenta una vez que se empezó y el clic en «Crear cuenta» (ADR-069).
    await expect.poll(() => funnelHits("psycho_start", "series")).toBe(starts + 1);
    await page
      .getByTestId("series-result")
      .getByRole("link", { name: "Crear cuenta gratis" })
      .click();
    await expect(page).toHaveURL(/\/registro/);
    await expect.poll(() => funnelHits("psycho_signup", "series")).toBe(signups + 1);
  });
});

test.describe("Tipos de psicotécnicos", () => {
  for (const tipo of ["letters", "numeric", "analogies", "matrices", "spatial", "attention"]) {
    test(`demo de ${tipo}: corrige y explica`, async ({ page }) => {
      await page.goto(`/psicotecnicos?tipo=${tipo}`);
      await expect(page.getByTestId("psycho-stem")).toBeVisible();
      await page.getByTestId("psycho-option").first().click();
      await expect(page.getByText(/¡Correcto!|Incorrecto\. La respuesta era/)).toBeVisible();
      expect(await page.content()).not.toContain("answerIndex");
    });
  }
});

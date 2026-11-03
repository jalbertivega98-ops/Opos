import { expect, test, type Page } from "@playwright/test";
import { confirmEmail, newEmail, signOut, signUp } from "./helpers";

async function answerAll(page: Page, total: number) {
  for (let i = 1; i <= total; i++) {
    await expect(page.getByRole("heading", { name: `Ejercicio ${i} de ${total}` })).toBeVisible();
    await page
      .getByRole("group", { name: "Opciones de respuesta" })
      .getByRole("button")
      .first()
      .click();
    await expect(page.getByText(/¡Correcto!|Incorrecto\. La respuesta era/)).toBeVisible();
    await page.getByRole("button", { name: i === total ? "Ver resultado" : "Siguiente" }).click();
  }
}

test.describe("Práctica con resultados guardados", () => {
  test("guarda la sesión, muestra estadísticas reales y es privada", async ({ page }) => {
    const email = newEmail("practica");
    await signUp(page, email, "Pau");
    await confirmEmail(page, email);

    // Sin datos todavía
    await page.goto("/app/progreso");
    await expect(page.getByText(/Todavía no hay datos/)).toBeVisible();

    // Nueva práctica de 5 series
    await page.goto("/app/practica");
    await page.getByLabel("Número de ejercicios").selectOption("5");
    await page.getByRole("button", { name: "Empezar" }).click();
    await expect(page).toHaveURL(/\/app\/practica\/[0-9a-f-]{36}$/);
    const sessionUrl = page.url();

    // Responder 2, recargar y comprobar que continúa donde lo dejó
    for (let i = 1; i <= 2; i++) {
      await page
        .getByRole("group", { name: "Opciones de respuesta" })
        .getByRole("button")
        .first()
        .click();
      await expect(page.getByText(/¡Correcto!|Incorrecto\./)).toBeVisible();
      await page.getByRole("button", { name: "Siguiente" }).click();
    }
    await page.reload();
    await expect(page.getByRole("heading", { name: "Ejercicio 3 de 5" })).toBeVisible();
    for (let i = 3; i <= 5; i++) {
      await page
        .getByRole("group", { name: "Opciones de respuesta" })
        .getByRole("button")
        .first()
        .click();
      await expect(page.getByText(/¡Correcto!|Incorrecto\./)).toBeVisible();
      await page.getByRole("button", { name: i === 5 ? "Ver resultado" : "Siguiente" }).click();
    }

    const summary = page.getByTestId("practice-summary");
    await expect(summary).toContainText(/Has acertado \d de 5/);
    const correct = Number((await summary.textContent())!.match(/Has acertado (\d) de 5/)![1]);
    await expect(page.getByTestId("review-item")).toHaveCount(5);

    // Estadísticas reales
    await page.goto("/app/progreso");
    const kpis = page.getByTestId("progress-kpis");
    await expect(kpis).toContainText("Ejercicios respondidos5");
    await expect(kpis).toContainText(`${Math.round((correct / 5) * 100)} %`);
    await expect(kpis).toContainText("1 día");
    await expect(page.getByTestId("progress-by-type")).toContainText("Series numéricas");

    // Panel principal con datos
    await page.goto("/app");
    await expect(page.getByTestId("dashboard-stat").last()).toHaveText("5");

    // Repaso de fallos: solo si hubo alguno
    await page.goto("/app/practica");
    const failed = 5 - correct;
    if (failed > 0) {
      await page.getByRole("button", { name: "Repasar psicotécnicos" }).click();
      await expect(page).toHaveURL(/\/app\/practica\/[0-9a-f-]{36}$/);
      await expect(page.getByRole("heading", { level: 1 })).toHaveText("Repaso");
      await answerAll(page, failed);
      await expect(page.getByTestId("practice-summary")).toBeVisible();
    } else {
      await expect(page.getByRole("button", { name: "Repasar psicotécnicos" })).toBeDisabled();
    }

    // Otra persona no puede ver la sesión
    await signOut(page);
    const other = newEmail("ajeno");
    await signUp(page, other, "Otra");
    await confirmEmail(page, other);
    const res = await page.goto(sessionUrl);
    expect(res?.status()).toBe(404);
  });

  test("la demo anónima no guarda nada en la cuenta", async ({ page }) => {
    // Primero la demo sin sesión, luego registro: el progreso debe estar vacío
    await page.goto("/psicotecnicos");
    await page
      .getByRole("group", { name: "Opciones de respuesta" })
      .getByRole("button")
      .first()
      .click();
    await expect(page.getByText(/¡Correcto!|Incorrecto\./)).toBeVisible();
    const email = newEmail("demo");
    await signUp(page, email, "Demo");
    await confirmEmail(page, email);
    await page.goto("/app/progreso");
    await expect(page.getByText(/Todavía no hay datos/)).toBeVisible();
  });
});

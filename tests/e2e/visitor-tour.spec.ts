import { expect, test } from "@playwright/test";
import { dropExam, seedExam } from "./sample-seed";

// Visitante nuevo: sin la marca de «guía vista» que pone la configuración por defecto.
test.use({ storageState: { cookies: [], origins: [] } });

test.describe("Guía para visitantes sin cuenta (ADR-057)", () => {
  let slug: string;
  test.beforeAll(async () => {
    slug = await seedExam();
  });
  test.afterAll(async () => {
    await dropExam(slug);
  });

  test("ya no sale sola: no tapa el test gratis (ADR-065)", async ({ page }) => {
    await page.goto("/");
    await page.waitForTimeout(1200);
    await expect(page.getByTestId("visitor-tour")).toHaveCount(0);
    await expect(page.getByTestId("hero-free-tests")).toBeVisible();
  });

  test("con ?guia=1 se recorre paso a paso y no vuelve sola", async ({ page }) => {
    await page.goto("/?guia=1");
    const tour = page.getByTestId("visitor-tour");
    const card = tour.getByRole("dialog");
    await expect(card).toContainText("Te damos la bienvenida a OPOSAPRUEBA");
    await expect(card).toContainText("Paso 1 de 6");
    await card.getByRole("button", { name: "Empezar" }).click();
    await expect(card).toContainText("Empieza aquí: un test gratis");
    // Paso interactivo: el selector resaltado se puede usar sin cerrar la guía.
    await page.locator("#hero-test-exam").focus();
    await expect(card).toContainText("Empieza aquí");
    for (const title of ["¿No ves la tuya?", "Cómo funciona", "Gratis para empezar"]) {
      await page.getByTestId("tour-next").click();
      await expect(card).toContainText(title);
    }
    await page.getByTestId("tour-next").click();
    await expect(card).toContainText("Crea tu cuenta gratis");
    await card.getByRole("button", { name: "Entendido" }).click();
    await expect(tour).toHaveCount(0);

    await page.goto("/");
    await page.waitForTimeout(1200);
    await expect(page.getByTestId("visitor-tour")).toHaveCount(0);
    // Se puede volver a abrir a petición.
    await page.getByTestId("visitor-tour-launch").click();
    await expect(page.getByTestId("visitor-tour")).toBeVisible();
    await page.keyboard.press("Escape");
    await expect(page.getByTestId("visitor-tour")).toHaveCount(0);
  });

  test("«Cómo funciona»: pasos con capturas y «Ver la guía» abre la guía sin la bienvenida (ADR-062)", async ({
    page,
  }) => {
    await page.addInitScript(() => localStorage.setItem("opa.visitorTour", "done"));
    await page.goto("/#como-funciona");
    const showcase = page.getByTestId("how-showcase");
    const step3 = showcase.getByTestId("how-step-3");
    await step3.click();
    await expect(step3).toHaveAttribute("aria-selected", "true");
    await expect(showcase.getByRole("tabpanel").getByRole("img")).toHaveAttribute(
      "alt",
      /pregunta de test corregida/,
    );
    // Flechas del teclado entre pasos
    await page.keyboard.press("ArrowUp");
    await expect(showcase.getByTestId("how-step-2")).toHaveAttribute("aria-selected", "true");

    await showcase.getByTestId("how-guide").click();
    const card = page.getByTestId("visitor-tour").getByRole("dialog");
    await expect(card).toContainText("Paso 2 de 6");
    await expect(card).toContainText("Empieza aquí: un test gratis");
    // Con el foco en la tarjeta, → avanza y ← vuelve
    await card.press("ArrowRight");
    await expect(card).toContainText("¿No ves la tuya?");
    await card.press("ArrowLeft");
    await expect(card).toContainText("Empieza aquí");
  });

  test("desde la guía se empieza el test y las pistas acompañan las primeras preguntas", async ({
    page,
  }) => {
    await page.goto("/?guia=1");
    const card = page.getByTestId("visitor-tour").getByRole("dialog");
    await card.getByRole("button", { name: "Empezar" }).click();
    const picker = page.getByTestId("hero-free-tests");
    await picker.locator("select").selectOption(slug);
    // Con teclado: el clic de Playwright desplaza la página en cada reintento y
    // el hueco del resaltado va un fotograma por detrás.
    await picker.getByRole("button").focus();
    await page.keyboard.press("Enter");
    await expect(page).toHaveURL(new RegExp(`/oposiciones/${slug}/test$`));
    await expect(page.getByTestId("visitor-tour")).toHaveCount(0);

    const tip = page.getByTestId("test-guide");
    await expect(tip).toHaveAttribute("data-phase", "answer");
    await page.getByTestId("question-option").first().click();
    await expect(tip).toHaveAttribute("data-phase", "feedback");
    await page.getByRole("button", { name: "Siguiente" }).click();
    await expect(tip).toHaveAttribute("data-phase", "keepGoing");
    await page.getByTestId("test-guide-hide").click();
    await expect(tip).toHaveCount(0);
    await page.reload();
    await expect(page.getByTestId("question-stem")).toBeVisible();
    await expect(page.getByTestId("test-guide")).toHaveCount(0);
  });

  test("móvil: la guía se ve y se puede cerrar @mobile", async ({ page }) => {
    await page.goto("/?guia=1");
    const card = page.getByTestId("visitor-tour").getByRole("dialog");
    await card.getByRole("button", { name: "Empezar" }).click();
    await expect(card).toBeInViewport();
    await page.getByTestId("tour-close").click();
    await expect(page.getByTestId("visitor-tour")).toHaveCount(0);
  });
});

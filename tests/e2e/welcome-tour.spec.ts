import { expect, test } from "@playwright/test";
import { confirmEmail, newEmail, signUp } from "./helpers";

test.describe("Tutorial de bienvenida y vídeos de ayuda (ADR-055)", () => {
  test("sale la primera vez, se recorre entero y no vuelve; se puede repetir desde el perfil", async ({
    page,
  }) => {
    const email = newEmail("tour");
    await signUp(page, email, "Nuria");
    await confirmEmail(page, email, { keepTour: true });

    await page.goto("/app");
    const tour = page.getByRole("dialog");
    await expect(tour).toBeVisible();
    await expect(tour).toContainText("Bienvenida a OPOSAPRUEBA");
    await expect(tour).toContainText("Paso 1 de 8");
    await tour.getByRole("button", { name: "Empezar" }).click();
    await expect(tour).toContainText("Tu plan de estudio");
    for (let i = 0; i < 6; i++) await page.getByTestId("tour-next").click();
    await expect(tour).toContainText("¡Listo para empezar!");
    await tour.getByRole("button", { name: "¡A estudiar!" }).click();
    await expect(page.getByTestId("welcome-tour")).toHaveCount(0);

    // Guardado en el perfil: al volver ya no sale.
    await expect
      .poll(async () => {
        await page.goto("/app");
        return page.getByTestId("welcome-tour").count();
      })
      .toBe(0);

    // Repetirlo a petición; Escape lo cierra.
    await page.goto("/app/perfil");
    await page.getByTestId("replay-tour").click();
    await expect(page.getByRole("dialog")).toBeVisible();
    await page.keyboard.press("Escape");
    await expect(page.getByTestId("welcome-tour")).toHaveCount(0);
  });

  test("cerrar con «Ahora no» también cuenta como visto", async ({ page }) => {
    const email = newEmail("tour-skip");
    await signUp(page, email);
    await confirmEmail(page, email, { keepTour: true });
    await page.goto("/app");
    await page.getByRole("dialog").getByRole("button", { name: "Ahora no" }).click();
    await expect(page.getByTestId("welcome-tour")).toHaveCount(0);
    await expect
      .poll(async () => {
        await page.goto("/app");
        return page.getByTestId("welcome-tour").count();
      })
      .toBe(0);
  });

  test("la portada tiene los vídeos de dudas y se reproducen al pulsar", async ({ page }) => {
    await page.goto("/");
    const section = page.getByTestId("help-videos");
    await expect(section.getByTestId("help-video")).toHaveCount(6);
    await section.getByRole("button", { name: /¿Qué puedo hacer gratis\?/ }).click();
    const video = section.locator("video");
    await expect(video).toHaveAttribute("src", "/videos/ayuda/que-es-gratis.mp4");
    const res = await page.request.get("/videos/ayuda/que-es-gratis.mp4");
    expect(res.status()).toBe(200);
    expect(res.headers()["content-type"]).toContain("video/mp4");
  });

  test("cada ficha de oposición con guía tiene su vídeo", async ({ page }) => {
    await page.goto("/oposiciones/mossos-esquadra");
    const box = page.getByTestId("exam-video");
    await expect(box).toBeVisible();
    await expect(box.getByRole("heading", { level: 2 })).toHaveText("Tu oposición en medio minuto");
    await box.getByText("Leer lo que dice").click();
    await expect(box).toContainText("ochenta preguntas de aptitudes");
  });
});

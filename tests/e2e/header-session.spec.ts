import { expect, test } from "@playwright/test";
import { confirmEmail, newEmail, signUp } from "./helpers";

// Las páginas públicas son estáticas y la cabecera mira la sesión en el navegador (ADR-059).
test("la cabecera de una página estática reconoce la sesión y «Cerrar sesión» la cierra", async ({
  page,
}) => {
  await page.setViewportSize({ width: 1280, height: 800 });
  const email = newEmail("cabecera");
  await signUp(page, email);
  await confirmEmail(page, email);
  await expect(page).toHaveURL(/\/app/);

  await page.goto("/oposiciones");
  const header = page.locator("header");
  await expect(header.getByRole("link", { name: "Mi panel" })).toBeVisible();
  await expect(header.getByRole("link", { name: "Empieza gratis" })).toHaveCount(0);

  await header.getByRole("button", { name: "Cerrar sesión" }).click();
  await expect(page).toHaveURL(/localhost:\d+\/$/);
  await expect(header.getByRole("link", { name: "Empieza gratis" })).toBeVisible();
  await page.goto("/app");
  await expect(page).toHaveURL(/\/entrar/);
});

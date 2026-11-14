import { expect, test } from "@playwright/test";
import { PASSWORD, confirmEmail, newEmail, signIn, signOut, signUp } from "./helpers";

test.describe("Perfil y derechos RGPD", () => {
  test("editar perfil, cambiar idioma, exportar datos y eliminar cuenta", async ({ page }) => {
    const email = newEmail("perfil");
    await signUp(page, email);
    await confirmEmail(page, email);

    await page.goto("/app/perfil");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText("Mi perfil");
    await page.getByLabel("Nombre (opcional)").fill("Marta G.");
    await page.getByRole("button", { name: "Guardar cambios" }).click();
    await expect(page.getByText("Cambios guardados.")).toBeVisible();

    // Cambio de idioma preferido → interfaz en catalán
    await page.getByLabel("Idioma preferido").selectOption("ca");
    await page.getByRole("button", { name: "Guardar cambios" }).click();
    await expect(page).toHaveURL(/\/ca\/app\/perfil\?saved=1/);
    await expect(page.getByRole("heading", { level: 1 })).toHaveText("El meu perfil");

    // Exportación de datos
    const res = await page.request.get("/api/account/export");
    expect(res.status()).toBe(200);
    expect(res.headers()["content-disposition"]).toContain("attachment");
    const data = await res.json();
    expect(data.account.email).toBe(email);
    expect(data.profile.display_name).toBe("Marta G.");
    expect(data.profile.locale).toBe("ca");

    // Eliminación: contraseña incorrecta y palabra de confirmación
    await page.getByLabel("Contrasenya", { exact: true }).fill("Incorrecta123");
    await page.getByLabel("Escriu ELIMINAR per confirmar").fill("ELIMINAR");
    await page.getByRole("button", { name: "Elimina el meu compte definitivament" }).click();
    await expect(page.getByText("Contrasenya incorrecta.")).toBeVisible();

    await page.getByLabel("Contrasenya", { exact: true }).fill(PASSWORD);
    await page.getByLabel("Escriu ELIMINAR per confirmar").fill("ELIMINAR");
    await page.getByRole("button", { name: "Elimina el meu compte definitivament" }).click();
    await expect(page).toHaveURL(/\/ca\?cuenta=eliminada/);
    await expect(page.getByText("El teu compte s'ha eliminat")).toBeVisible();

    // Ya no puede entrar
    await signIn(page, email);
    await expect(page.getByRole("alert").filter({ hasText: /./ })).toContainText("incorrectos");
  });

  test("cambiar contraseña y pedir cambio de correo desde el perfil", async ({ page }) => {
    const email = newEmail("seguridad");
    await signUp(page, email);
    await confirmEmail(page, email);
    await page.goto("/app/perfil");

    const NEW_PASSWORD = "NuevaClave2027";
    // Contraseña actual incorrecta
    await page.locator("#pw-current").fill("Incorrecta123");
    await page.locator("#pw-new").fill(NEW_PASSWORD);
    await page.locator("#pw-confirm").fill(NEW_PASSWORD);
    await page.getByRole("button", { name: "Cambiar contraseña" }).click();
    await expect(page.getByText("Contraseña incorrecta.")).toBeVisible();

    // Confirmación distinta
    await page.locator("#pw-current").fill(PASSWORD);
    await page.locator("#pw-new").fill(NEW_PASSWORD);
    await page.locator("#pw-confirm").fill("OtraClave2027");
    await page.getByRole("button", { name: "Cambiar contraseña" }).click();
    await expect(page.getByText("Las contraseñas no coinciden.")).toBeVisible();

    await page.locator("#pw-current").fill(PASSWORD);
    await page.locator("#pw-new").fill(NEW_PASSWORD);
    await page.locator("#pw-confirm").fill(NEW_PASSWORD);
    await page.getByRole("button", { name: "Cambiar contraseña" }).click();
    await expect(page.getByText("Contraseña cambiada.", { exact: false })).toBeVisible();

    // Cambio de correo: mismo correo y luego uno nuevo
    await page.locator("#email-new").fill(email);
    await page.locator("#email-current-password").fill(NEW_PASSWORD);
    await page.getByRole("button", { name: "Cambiar correo" }).click();
    await expect(page.getByText("Ese ya es tu correo actual.")).toBeVisible();

    await page.locator("#email-new").fill(newEmail("nuevo"));
    await page.locator("#email-current-password").fill(NEW_PASSWORD);
    await page.getByRole("button", { name: "Cambiar correo" }).click();
    await expect(
      page.getByText("Te hemos enviado un enlace de confirmación.", { exact: false }),
    ).toBeVisible();

    // La contraseña nueva funciona y la antigua no
    await signOut(page);
    await signIn(page, email);
    await expect(page.getByRole("alert").filter({ hasText: /./ })).toContainText("incorrectos");
    await signIn(page, email, NEW_PASSWORD);
    await expect(page).toHaveURL(/\/app/);
  });

  test("la exportación exige sesión", async ({ request }) => {
    const res = await request.get("/api/account/export");
    expect(res.status()).toBe(401);
  });
});

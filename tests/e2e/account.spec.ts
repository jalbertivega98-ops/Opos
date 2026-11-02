import { expect, test } from "@playwright/test";
import { PASSWORD, confirmEmail, newEmail, signIn, signUp } from "./helpers";

test.describe("Perfil y derechos RGPD", () => {
  test("editar perfil, cambiar idioma, exportar datos y eliminar cuenta", async ({ page }) => {
    const email = newEmail("perfil");
    await signUp(page, email, "Marta");
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
    await page.getByLabel("Contrasenya").fill("Incorrecta123");
    await page.getByLabel("Escriu ELIMINAR per confirmar").fill("ELIMINAR");
    await page.getByRole("button", { name: "Elimina el meu compte definitivament" }).click();
    await expect(page.getByText("Contrasenya incorrecta.")).toBeVisible();

    await page.getByLabel("Contrasenya").fill(PASSWORD);
    await page.getByLabel("Escriu ELIMINAR per confirmar").fill("ELIMINAR");
    await page.getByRole("button", { name: "Elimina el meu compte definitivament" }).click();
    await expect(page).toHaveURL(/\/ca\?cuenta=eliminada/);
    await expect(page.getByText("El teu compte s'ha eliminat")).toBeVisible();

    // Ya no puede entrar
    await signIn(page, email);
    await expect(page.getByRole("alert").filter({ hasText: /./ })).toContainText("incorrectos");
  });

  test("la exportación exige sesión", async ({ request }) => {
    const res = await request.get("/api/account/export");
    expect(res.status()).toBe(401);
  });
});

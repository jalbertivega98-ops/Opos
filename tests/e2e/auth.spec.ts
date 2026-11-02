import { expect, test } from "@playwright/test";
import {
  PASSWORD,
  confirmEmail,
  grantRole,
  latestLink,
  newEmail,
  signIn,
  signOut,
  signUp,
} from "./helpers";

test.describe("Registro, verificación y onboarding", () => {
  test("flujo completo de alta hasta el panel", async ({ page }) => {
    const email = newEmail("alta");
    await signUp(page, email, "Laura");

    // Sin confirmar no puede entrar
    await signIn(page, email);
    await expect(page.getByRole("alert").filter({ hasText: /./ })).toContainText(
      "Confirma tu correo",
    );

    await confirmEmail(page, email);
    await expect(page).toHaveURL(/\/app\/onboarding/);

    await page.getByLabel("¿Qué oposición preparas?").selectOption("mossos-esquadra");
    await expect(page.getByText("está marcada como «Próximamente»")).toBeVisible();
    await page.getByText("Ya he estudiado algo").click();
    await page.getByText("Mejorar en psicotécnicos").click();
    await page.getByRole("button", { name: "Generar mi plan" }).click();

    await expect(page).toHaveURL(/\/app\?welcome=1/);
    await expect(page.getByRole("heading", { level: 1 })).toHaveText("Hola, Laura");
    await expect(page.getByText("Mossos d'Esquadra")).toBeVisible();
    await expect(page.getByText("Siguiendo")).toBeVisible();
    await expect(page.getByText("Onboarding completado")).toBeVisible();
  });

  test("validaciones del formulario de registro", async ({ page }) => {
    await page.goto("/registro");
    await page.getByLabel("Correo electrónico").fill("no-es-un-email");
    await page.getByLabel("Contraseña").fill("corta");
    await page.getByRole("button", { name: "Crear cuenta" }).click();
    await expect(page.getByText("Formato no válido.")).toBeVisible();
    await expect(page.getByText("al menos 8 caracteres")).toBeVisible();
    await expect(page.getByText("Debes aceptar las condiciones")).toBeVisible();
    await expect(page.getByLabel("Correo electrónico")).toHaveValue("no-es-un-email");
  });

  test("onboarding valida que haya objetivos", async ({ page }) => {
    const email = newEmail("objetivos");
    await signUp(page, email);
    await confirmEmail(page, email);
    await page.getByLabel("¿Qué oposición preparas?").selectOption("auxilio-judicial");
    await page.getByRole("button", { name: "Generar mi plan" }).click();
    await expect(page.getByText("Elige al menos un objetivo")).toBeVisible();
  });
});

test.describe("Sesión", () => {
  test("rutas protegidas redirigen a entrar y vuelven al destino", async ({ page }) => {
    const email = newEmail("sesion");
    await signUp(page, email);
    await confirmEmail(page, email);
    await signOut(page);

    await page.goto("/app");
    await expect(page).toHaveURL(/\/entrar\?next=%2Fapp/);
    await page.getByLabel("Correo electrónico").fill(email);
    await page.getByLabel("Contraseña").fill("ContraseñaMala1");
    await page.getByRole("button", { name: "Entrar", exact: true }).click();
    await expect(page.getByRole("alert").filter({ hasText: /./ })).toContainText(
      "Correo o contraseña incorrectos",
    );
    await page.getByLabel("Contraseña").fill(PASSWORD);
    await page.getByRole("button", { name: "Entrar", exact: true }).click();
    await expect(page).toHaveURL(/\/app$/);
    await expect(page.getByText("Inicio de sesión")).toBeVisible();

    // Cerrar sesión desde la cabecera
    await page.getByRole("button", { name: "Cerrar sesión" }).first().click();
    await expect(page).toHaveURL(/localhost:3000\/$/);
    await page.goto("/app");
    await expect(page).toHaveURL(/\/entrar/);
  });

  test("recuperación de contraseña", async ({ page }) => {
    const email = newEmail("recupera");
    await signUp(page, email);
    await confirmEmail(page, email);
    await signOut(page);

    const before = new Date(Date.now() - 1000);
    await page.goto("/recuperar");
    await page.getByLabel("Correo electrónico").fill(email);
    await page.getByRole("button", { name: "Enviar enlace" }).click();
    await expect(page.getByText("Si existe una cuenta con ese correo")).toBeVisible();

    const link = await latestLink(email, { subject: /reset|password|contraseña/i, after: before });
    await page.goto(link);
    await expect(page).toHaveURL(/\/restablecer/);
    await page.getByLabel("Contraseña", { exact: true }).fill("NuevaClave2026");
    await page.getByLabel("Repite la contraseña").fill("NuevaClave2026");
    await page.getByRole("button", { name: "Guardar contraseña" }).click();
    await expect(page).toHaveURL(/\/app\?pw=updated/);
    await expect(page.getByText("Contraseña actualizada")).toBeVisible();

    await signOut(page);
    await signIn(page, email, "NuevaClave2026");
    await expect(page).toHaveURL(/\/app$/);
  });

  test("la recuperación no revela si el email existe", async ({ page }) => {
    await page.goto("/recuperar");
    await page.getByLabel("Correo electrónico").fill(newEmail("noexiste"));
    await page.getByRole("button", { name: "Enviar enlace" }).click();
    await expect(page.getByText("Si existe una cuenta con ese correo")).toBeVisible();
  });
});

test.describe("Administración", () => {
  test("un alumno no accede; un admin ve métricas reales", async ({ page }) => {
    const email = newEmail("admin");
    await signUp(page, email, "Admin");
    await confirmEmail(page, email);

    await page.goto("/admin");
    await expect(page).toHaveURL(/\/app$/);

    grantRole(email, "admin");
    await page.goto("/admin");
    await expect(page.getByRole("heading", { level: 1 })).toHaveText("Administración");
    const total = Number(
      (await page.getByTestId("kpi-totalUsers").locator("p").nth(1).innerText()).replace(/\D/g, ""),
    );
    expect(total).toBeGreaterThanOrEqual(1);
    await expect(page.getByRole("table")).toContainText("Admin");
  });
});

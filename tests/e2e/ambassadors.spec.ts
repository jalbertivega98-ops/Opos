import { expect, test } from "@playwright/test";
import { randomUUID } from "node:crypto";
import { PASSWORD, confirmEmail, grantRole, newEmail, signUp } from "./helpers";

test.describe("Programa de embajadoras (ADR-054)", () => {
  test("alta en /admin, enlace propio al registro y registro atribuido", async ({
    page,
    browser,
  }) => {
    test.setTimeout(120_000);
    const code = `emb-${randomUUID().slice(0, 6)}`;
    const adminEmail = newEmail("admin");

    await signUp(page, adminEmail, "Admin");
    await confirmEmail(page, adminEmail);
    grantRole(adminEmail, "admin");

    // 1. Alta de la embajadora
    await page.goto("/admin/embajadoras");
    await expect(page.getByRole("heading", { name: "Embajadoras", level: 1 })).toBeVisible();
    const form = page.getByTestId("ambassador-form");
    await form.getByLabel("Nombre").fill("Laura Opos");
    await form.getByLabel("Código").fill(code.toUpperCase());
    await form.getByLabel("Cuenta").fill("@laura.opos");
    await form.getByRole("button", { name: "Dar de alta" }).click();
    await expect(page.getByText("Embajadora dada de alta")).toBeVisible();
    const row = page.getByTestId("ambassadors-table").getByRole("row", { name: /Laura Opos/ });
    await expect(row).toContainText(`/r/${code}`);

    // El mismo código no se puede repetir
    await form.getByLabel("Nombre").fill("Otra");
    await form.getByLabel("Código").fill(code);
    await form.getByRole("button", { name: "Dar de alta" }).click();
    await expect(page.getByText("Ese código ya lo tiene otra embajadora.").first()).toBeVisible();

    // 2. Una seguidora entra por el enlace y se registra
    const ctx = await browser.newContext();
    const fp = await ctx.newPage();
    await fp.goto(`/r/${code}`);
    await expect(fp).toHaveURL(new RegExp(`/registro\\?ref=${code}$`));
    await expect(fp.getByLabel("Código de invitación")).toHaveValue(code);
    const followerEmail = newEmail("seguidora");
    await fp.getByLabel("Correo electrónico").fill(followerEmail);
    await fp.getByLabel("Contraseña").fill(PASSWORD);
    await fp.getByRole("checkbox").check();
    await fp.getByRole("button", { name: "Crear cuenta" }).click();
    await expect(fp).toHaveURL(/verifica-tu-correo/);
    await ctx.close();

    // Un código inventado no rompe el registro
    const ctx2 = await browser.newContext();
    const op = await ctx2.newPage();
    await op.goto("/registro?ref=no-existe-xyz");
    await op.getByLabel("Correo electrónico").fill(newEmail("otra"));
    await op.getByLabel("Contraseña").fill(PASSWORD);
    await op.getByRole("checkbox").check();
    await op.getByRole("button", { name: "Crear cuenta" }).click();
    await expect(op).toHaveURL(/verifica-tu-correo/);
    await ctx2.close();

    // 3. El panel cuenta el registro
    await page.reload();
    const cells = page
      .getByTestId("ambassadors-table")
      .getByRole("row", { name: /Laura Opos/ })
      .getByRole("cell");
    await expect(cells.nth(3)).toContainText("1");

    // 4. Pausar y reactivar
    await row.getByRole("button", { name: "Pausar" }).click();
    await expect(row.getByText("Pausada")).toBeVisible();
    await row.getByRole("button", { name: "Reactivar" }).click();
    await expect(row.getByText("Activa")).toBeVisible();
  });

  test("un alumno no entra en /admin/embajadoras", async ({ page }) => {
    const email = newEmail("alumna");
    await signUp(page, email, "Alumna");
    await confirmEmail(page, email);
    await page.goto("/admin/embajadoras");
    await expect(page.getByRole("heading", { name: "Embajadoras", level: 1 })).toHaveCount(0);
  });
});

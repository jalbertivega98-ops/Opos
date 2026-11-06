import { expect, test } from "@playwright/test";

/**
 * «Continuar con Google» (ADR-040). En local GoTrue tiene Google activado con credenciales
 * falsas: comprobamos que el botón lleva a Google con PKCE y la vuelta a /auth/callback.
 * El login real con Google no se puede completar aquí.
 */
test.describe("Continuar con Google", () => {
  test("el botón de entrar lleva a Google con la vuelta a nuestro callback", async ({ page }) => {
    // Playwright no intercepta la redirección 302 a Google: capturamos la URL de Supabase
    // (/auth/v1/authorize) y miramos a dónde redirige sin seguirla.
    let authorizeUrl: string | undefined;
    await page.route("**/auth/v1/authorize?**", (route) => {
      authorizeUrl = route.request().url();
      return route.fulfill({ status: 200, body: "google" });
    });
    await page.goto("/entrar");
    await expect(page.getByText(/se crea tu cuenta y aceptas/)).toBeVisible();
    await page.getByRole("button", { name: "Continuar con Google" }).click();
    await expect.poll(() => authorizeUrl).toBeTruthy();

    const authorize = new URL(authorizeUrl!);
    expect(authorize.searchParams.get("provider")).toBe("google");
    expect(authorize.searchParams.get("code_challenge_method")).toBe("s256");
    const back = new URL(authorize.searchParams.get("redirect_to")!);
    expect(back.pathname).toBe("/auth/callback");
    expect(back.searchParams.get("via")).toBe("google");
    expect(back.searchParams.get("next")).toBe("/app");

    const res = await page.request.get(authorizeUrl!, { maxRedirects: 0 });
    const google = new URL(res.headers().location);
    expect(google.host).toBe("accounts.google.com");
    expect(google.searchParams.get("client_id")).toBe("local-google-client");
    expect(google.searchParams.get("prompt")).toBe("select_account");
    // El verificador PKCE queda en una cookie para canjear el código a la vuelta.
    const cookies = await page.context().cookies();
    expect(cookies.some((c) => c.name.endsWith("-code-verifier"))).toBe(true);
  });

  test("aparece también en el registro y en catalán", async ({ page }) => {
    await page.goto("/registro");
    await expect(page.getByRole("button", { name: "Continuar con Google" })).toBeVisible();
    await page.goto("/ca/registro");
    await expect(page.getByRole("button", { name: "Continua amb Google" })).toBeVisible();
  });

  test("si el alumno cancela en Google vuelve al login con un aviso claro", async ({ page }) => {
    await page.goto("/auth/callback?error=access_denied&via=google&next=%2Fapp");
    await expect(page).toHaveURL(/\/entrar\?error=oauth/);
    await expect(page.getByText("No se ha podido entrar con Google")).toBeVisible();
  });

  test("un código inválido de Google no deja entrar", async ({ page }) => {
    await page.goto("/auth/callback?code=falso&via=google");
    await expect(page).toHaveURL(/\/entrar\?error=oauth/);
  });
});

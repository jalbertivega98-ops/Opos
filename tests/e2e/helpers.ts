import { expect, type Page } from "@playwright/test";
import { execFileSync } from "node:child_process";
import { randomUUID } from "node:crypto";

const MAILPIT = process.env.MAILPIT_URL ?? "http://127.0.0.1:54324";

export const newEmail = (tag = "e2e") => `${tag}-${randomUUID().slice(0, 8)}@example.test`;
export const PASSWORD = "Opositor2026";

type MailSummary = { ID: string; Subject: string; Created: string };

/** Espera el último correo para `to` en Mailpit y devuelve el primer enlace http(s). */
export async function latestLink(to: string, opts: { subject?: RegExp; after?: Date } = {}) {
  let link: string | undefined;
  await expect
    .poll(
      async () => {
        const res = await fetch(
          `${MAILPIT}/api/v1/search?query=${encodeURIComponent(`to:"${to}"`)}`,
        );
        const json = (await res.json()) as { messages: MailSummary[] };
        const msg = json.messages.find(
          (m) =>
            (!opts.subject || opts.subject.test(m.Subject)) &&
            (!opts.after || new Date(m.Created) >= opts.after),
        );
        if (!msg) return undefined;
        const full = (await (await fetch(`${MAILPIT}/api/v1/message/${msg.ID}`)).json()) as {
          Text: string;
          HTML: string;
        };
        const body = full.Text || full.HTML;
        link = body.match(/https?:\/\/[^\s"'<>)]+/)?.[0]?.replace(/&amp;/g, "&");
        return link;
      },
      { timeout: 15_000, message: `correo para ${to}` },
    )
    .toBeTruthy();
  return link!;
}

export async function signUp(page: Page, email: string, name = "Laura") {
  await page.goto("/registro");
  await page.getByLabel("Nombre (opcional)").fill(name);
  await page.getByLabel("Correo electrónico").fill(email);
  await page.getByLabel("Contraseña").fill(PASSWORD);
  await page.getByRole("checkbox").check();
  await page.getByRole("button", { name: "Crear cuenta" }).click();
  await expect(page).toHaveURL(/verifica-tu-correo/);
}

export async function confirmEmail(page: Page, email: string) {
  const link = await latestLink(email, { subject: /confirm/i });
  await page.goto(link);
}

export async function signIn(page: Page, email: string, password = PASSWORD) {
  await page.goto("/entrar");
  await page.getByLabel("Correo electrónico").fill(email);
  await page.getByLabel("Contraseña").fill(password);
  await page.getByRole("button", { name: "Entrar", exact: true }).click();
}

export async function signOut(page: Page) {
  await page.context().clearCookies();
}

export function grantRole(email: string, role: "admin" | "editor" | "owner" | "student") {
  execFileSync("node", ["scripts/grant-role.mjs", email, role], { stdio: "pipe" });
}

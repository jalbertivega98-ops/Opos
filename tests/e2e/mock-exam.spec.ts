import { expect, test } from "@playwright/test";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { confirmEmail, grantRole, newEmail, signUp } from "./helpers";

/**
 * Simulacro con CONTENIDO DE PRUEBA (content/test/simulacro-prueba.json):
 * 5 preguntas, 35 min, −1/4. La alumna falla una, acierta tres y deja una en
 * blanco → (3 − 0,25) · 10 / 5 = 5,5.
 */
const SET = JSON.parse(readFileSync("content/test/simulacro-prueba.json", "utf8")) as {
  meta: { mock: { title: string } };
  questions: { stem: string; correct: number }[];
};
const correctFor = (stem: string) => SET.questions.find((q) => q.stem === stem)!.correct;

test("simulacro con tiempo, respuestas modificables, blanco y nota con penalización", async ({
  page,
  browser,
}) => {
  test.setTimeout(120_000);
  const ownerEmail = newEmail("titular");
  const studentEmail = newEmail("alumna");
  await signUp(page, ownerEmail, "Titular");
  await confirmEmail(page, ownerEmail);
  grantRole(ownerEmail, "owner");
  execFileSync(
    "node",
    [
      "scripts/content/load-questions.mjs",
      "content/test/simulacro-prueba.json",
      "--test",
      "--publish-as",
      ownerEmail,
    ],
    { stdio: "pipe" },
  );

  const sctx = await browser.newContext();
  const sp = await sctx.newPage();
  await signUp(sp, studentEmail, "Alumna");
  await confirmEmail(sp, studentEmail);

  await page.goto("/admin/compras");
  await page.getByLabel("Correo del alumno").fill(studentEmail);
  await page.getByLabel("Producto", { exact: true }).selectOption({ label: SET.meta.mock.title });
  await page.getByRole("button", { name: "Conceder acceso" }).click();
  await expect(page.getByText("Acceso concedido.")).toBeVisible();

  await sp.goto("/app/productos");
  const card = sp.getByTestId("library-item").filter({ hasText: SET.meta.mock.title });
  await expect(card.getByTestId("mock-format")).toHaveText(
    "5 preguntas · 35 min · error −0,25 · mínimo 4",
  );
  await card.getByTestId("mock-start").click();
  await expect(sp).toHaveURL(/\/app\/simulacros\/[0-9a-f-]{36}$/);
  await expect(sp.getByTestId("mock-timer")).toHaveText(/^3[45]:\d\d$/);

  const answerCurrent = async (pick: (right: number) => number) => {
    const stem = (await sp.getByTestId("question-stem").textContent())!.trim();
    const option = sp.getByTestId("question-option").nth(pick(correctFor(stem)));
    await option.click();
    await expect(option).toHaveAttribute("aria-checked", "true");
  };

  // 1: primero acierta, luego cambia a una errónea (cuenta el último cambio)
  await answerCurrent((r) => r);
  await answerCurrent((r) => (r + 1) % 4);
  // 2–4: aciertos
  for (let n = 2; n <= 4; n++) {
    await sp.getByRole("button", { name: "Siguiente" }).click();
    await expect(sp.getByRole("heading", { name: `Pregunta ${n} de 5` })).toBeVisible();
    await answerCurrent((r) => r);
  }
  // 5: la contesta y la deja en blanco
  await sp.getByRole("button", { name: "Pregunta 5, en blanco" }).click();
  await answerCurrent((r) => r);
  await sp.getByRole("button", { name: "Dejar en blanco" }).click();
  await expect(sp.getByTestId("mock-answered")).toHaveText("4 de 5 contestadas");

  // Recargar conserva las respuestas guardadas y el tiempo
  await sp.reload();
  await expect(sp.getByTestId("mock-answered")).toHaveText("4 de 5 contestadas");

  await sp.getByTestId("mock-submit").click();
  await expect(
    sp.getByText("Tienes 1 pregunta en blanco. ¿Quieres entregar igualmente?"),
  ).toBeVisible();
  await sp.getByTestId("mock-confirm").click();

  await expect(sp.getByTestId("mock-mark")).toHaveText("5,5 / 10");
  await expect(sp.getByTestId("mock-result")).toContainText("Superado (mínimo 4)");
  await expect(sp.getByTestId("mock-breakdown")).toHaveText("3 aciertos · 1 errores · 1 en blanco");
  await expect(sp.getByTestId("review-item")).toHaveCount(5);

  // Aparece en el historial de la biblioteca
  await sp.goto("/app/productos");
  await expect(sp.getByTestId("mock-history")).toContainText("5,5 / 10");
  await sctx.close();
});

import { expect, test } from "@playwright/test";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { confirmEmail, grantRole, newEmail, signUp } from "./helpers";

/**
 * Recorrido completo con CONTENIDO DE PRUEBA (content/test/pack-prueba.json):
 * la titular concede acceso → la alumna ve el producto → responde → resultados
 * → progreso → repaso de errores. Las 30 preguntas reales de Mossos siguen en
 * borrador y no intervienen.
 */
const PACK = JSON.parse(readFileSync("content/test/pack-prueba.json", "utf8")) as {
  meta: { product: { title: string } };
  questions: { stem: string; options: string[]; correct: number }[];
};
const correctFor = (stem: string) => PACK.questions.find((q) => q.stem === stem)!.correct;

test.describe("Recorrido del alumno con preguntas del banco", () => {
  test("acceso concedido, test, resultados, progreso y repaso de errores", async ({
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
        "content/test/pack-prueba.json",
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

    // Sin acceso, la biblioteca está vacía
    await sp.goto("/app/productos");
    await expect(sp.getByTestId("library")).toHaveCount(0);

    // 1. La titular concede acceso al producto de prueba
    await page.goto("/admin/compras");
    await page.getByLabel("Correo del alumno").fill(studentEmail);
    await page
      .getByLabel("Producto", { exact: true })
      .selectOption({ label: PACK.meta.product.title });
    await page.getByRole("button", { name: "Conceder acceso" }).click();
    await expect(page.getByText("Acceso concedido.")).toBeVisible();

    // 2. La alumna lo ve en «Mis productos», marcado como PRUEBA
    await sp.goto("/app/productos");
    const card = sp.getByTestId("library-item").filter({ hasText: PACK.meta.product.title });
    await expect(card).toContainText("PRUEBA");
    await expect(card).toContainText(`${PACK.questions.length} preguntas`);
    await card.getByLabel("Preguntas por test").selectOption("5");
    await card.getByRole("button", { name: "Practicar" }).click();
    await expect(sp).toHaveURL(/\/app\/practica\/[0-9a-f-]{36}$/);

    // 3. Responde: falla la primera y acierta el resto
    for (let i = 0; i < 5; i++) {
      await expect(sp.getByRole("heading", { name: `Pregunta ${i + 1} de 5` })).toBeVisible();
      const stem = (await sp.getByTestId("question-stem").textContent())!.trim();
      const right = correctFor(stem);
      const pick = i === 0 ? (right + 1) % 4 : right;
      await sp.getByTestId("question-option").nth(pick).click();
      await expect(
        sp.getByText(i === 0 ? /Incorrecta\. La respuesta correcta es la/ : "¡Correcto!"),
      ).toBeVisible();
      await expect(sp.getByText("Referencia: prueba")).toBeVisible();
      await sp.getByRole("button", { name: i === 4 ? "Ver resultados" : "Siguiente" }).click();
    }

    // 4. Resultados con corrección
    await expect(sp.getByTestId("practice-summary")).toContainText("4 de 5");
    await expect(sp.getByTestId("review-item")).toHaveCount(5);

    // 5. Progreso
    await sp.goto("/app/progreso");
    await expect(sp.getByText("Preguntas de temario")).toBeVisible();

    // 6. Repaso de errores: la fallada vuelve y al acertarla queda resuelta
    await sp.goto("/app/practica");
    await expect(sp.getByTestId("pending-split")).toContainText("Preguntas: 1");
    await sp.getByRole("button", { name: "Repasar preguntas" }).click();
    await expect(sp.getByRole("heading", { name: "Pregunta 1 de 1" })).toBeVisible();
    const stem = (await sp.getByTestId("question-stem").textContent())!.trim();
    await sp.getByTestId("question-option").nth(correctFor(stem)).click();
    await expect(sp.getByText("¡Correcto!")).toBeVisible();
    await sp.getByRole("button", { name: "Ver resultados" }).click();
    await expect(sp.getByTestId("practice-summary")).toContainText("1 de 1");
    await sp.goto("/app/practica");
    await expect(sp.getByTestId("pending-split")).toContainText("Preguntas: 0");

    await sctx.close();
  });

  test("las preguntas reales siguen en borrador y se revisan junto a su fuente", async ({
    page,
  }) => {
    const ownerEmail = newEmail("titular");
    await signUp(page, ownerEmail, "Titular");
    await confirmEmail(page, ownerEmail);
    grantRole(ownerEmail, "owner");
    execFileSync("node", ["scripts/content/load-questions.mjs", "content/mossos/b1-estatut.json"], {
      stdio: "pipe",
    });
    await page.goto("/admin/revision/fuentes?tema=mossos-b1-estatut");
    await expect(page.getByTestId("sources-count")).toHaveText(/^(30|60) preguntas$/); // 30 en castellano (+30 en catalán si se cargó el lote CA)
    const first = page.getByTestId("source-card").first();
    await expect(first).toContainText("Borrador");
    await expect(first).toContainText("art. 1");
    await expect(first.getByTestId("source-excerpt")).toContainText("norma institucional básica");
    await expect(page.getByText("Extracto parcial")).toHaveCount(3);
    // panel de aprobación por lotes: visible para la titular y con confirmación obligatoria
    const batch = page.getByTestId("batch-review");
    await expect(batch).toContainText("Aprobar por lotes");
    await expect(batch.getByRole("checkbox").first()).toHaveAttribute("required", "");
  });
});

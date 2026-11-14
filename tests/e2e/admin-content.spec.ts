import { expect, test } from "@playwright/test";
import { randomUUID } from "node:crypto";
import { confirmEmail, grantRole, newEmail, signUp } from "./helpers";

test.describe("Contenido y tienda en el panel", () => {
  test("editor, revisión por la titular, importación, producto y acceso manual", async ({
    page,
    browser,
  }) => {
    test.setTimeout(120_000);
    const tag = randomUUID().slice(0, 6);
    const ownerEmail = newEmail("titular");
    const adminEmail = newEmail("admin");
    const studentEmail = newEmail("alumna");

    // Alumna
    const sctx = await browser.newContext();
    const sp = await sctx.newPage();
    await signUp(sp, studentEmail);
    await confirmEmail(sp, studentEmail);

    // Admin (no titular): puede redactar pero no aprobar
    const actx = await browser.newContext();
    const ap = await actx.newPage();
    await signUp(ap, adminEmail);
    await confirmEmail(ap, adminEmail);
    grantRole(adminEmail, "admin");

    // Titular
    await signUp(page, ownerEmail);
    await confirmEmail(page, ownerEmail);
    grantRole(ownerEmail, "owner");

    // 1. Crear pregunta (admin)
    const stem = `¿Cuál es el resultado de 6 × 7? (${tag})`;
    await ap.goto("/admin/preguntas/nueva");
    await ap.getByLabel("Enunciado").fill(stem);
    await ap.getByRole("textbox", { name: "Opción A" }).fill("36");
    await ap.getByRole("textbox", { name: "Opción B" }).fill("42");
    await ap.getByRole("textbox", { name: "Opción C" }).fill("48");
    await ap.getByRole("textbox", { name: "Opción D" }).fill("54");
    await ap.getByLabel("Correcta: B").check();
    await ap.getByLabel("Explicación (obligatoria para aprobar)").fill("6 × 7 = 42.");
    await ap.getByLabel(/Categoría/).fill("calculo");
    await ap.getByRole("button", { name: "Guardar borrador" }).click();
    await expect(ap).toHaveURL(/\/admin\/preguntas\/[0-9a-f-]{36}\?saved=1/);
    const questionUrl = ap.url().replace(/\?.*$/, "");
    await expect(ap.getByText("Pregunta guardada.")).toBeVisible();

    // Duplicado detectado
    await ap.goto("/admin/preguntas/nueva");
    await ap.getByLabel("Enunciado").fill(stem.toUpperCase());
    for (const [l, v] of [
      ["A", "54"],
      ["B", "48"],
      ["C", "42"],
      ["D", "36"],
    ])
      await ap.getByRole("textbox", { name: `Opción ${l}` }).fill(v);
    await ap.getByLabel(/Categoría/).fill("calculo");
    await ap.getByRole("button", { name: "Guardar borrador" }).click();
    await expect(
      ap.getByText("Ya existe una pregunta con el mismo enunciado y opciones."),
    ).toBeVisible();

    // 2. Enviar a revisión; el admin no puede aprobar
    await ap.goto(questionUrl);
    await ap.getByRole("button", { name: "Enviar a revisión" }).click();
    await expect(ap.getByText("Enviada a revisión.")).toBeVisible();
    await ap.reload();
    await expect(ap.getByRole("button", { name: "Aprobar" })).toBeDisabled();

    // 3. La titular rechaza (con motivo obligatorio), luego aprueba y publica
    await page.goto("/admin/revision");
    const card = page.getByTestId("review-card").filter({ hasText: stem });
    await card.getByRole("button", { name: "Rechazar (vuelve a borrador)" }).click();
    await expect(card.getByText("Indica el motivo del rechazo.")).toBeVisible();
    await card.getByLabel(/Comentario/).fill("Añade la fuente");
    await card.getByRole("button", { name: "Rechazar (vuelve a borrador)" }).click();
    // al salir de la cola, la tarjeta desaparece
    await expect(card).toHaveCount(0);

    await page.goto(questionUrl);
    await expect(page.getByTestId("review-history")).toContainText("«Añade la fuente»");
    await page.getByRole("button", { name: "Enviar a revisión" }).click();
    await expect(page.getByText("Enviada a revisión.")).toBeVisible();
    await page.reload();
    await page.getByRole("button", { name: "Aprobar" }).click();
    await expect(page.getByText("Pregunta aprobada.")).toBeVisible();
    await page.reload();
    await page.getByRole("button", { name: "Publicar" }).click();
    await expect(page.getByText("Pregunta publicada.")).toBeVisible();
    await page.reload();
    await expect(page.getByTestId("question-status")).toHaveText("Publicada");
    await expect(page.getByLabel("Enunciado")).toBeDisabled();

    // 4. Importación CSV (todo como borrador, duplicados detectados)
    const csv = [
      "stem,explanation,category,difficulty,locale,option_a,option_b,option_c,correct,exams",
      `"Importada uno ${tag}","Expl.",importacion,1,es,a,b,c,A,mossos-esquadra`,
      `"Importada dos ${tag}","Expl.",importacion,2,es,a,b,c,C,`,
      `"Mala ${tag}",,importacion,1,es,a,,,A,`,
    ].join("\n");
    const upload = async () => {
      await page.goto("/admin/preguntas/importar");
      await page
        .getByLabel(/Archivo/)
        .setInputFiles({ name: "preguntas.csv", mimeType: "text/csv", buffer: Buffer.from(csv) });
      await page.getByRole("button", { name: "Importar" }).click();
    };
    await upload();
    await expect(page.getByTestId("import-report")).toHaveText(
      "2 de 3 filas válidas · 2 importadas",
    );
    await expect(page.getByText(/Línea 4:/)).toBeVisible();
    await upload();
    await expect(page.getByTestId("import-report")).toHaveText(
      "2 de 3 filas válidas · 0 importadas",
    );
    await expect(page.getByText("Duplicadas (ya existían): líneas 2, 3")).toBeVisible();
    await page.goto(`/admin/preguntas?estado=draft&q=${tag}`);
    await expect(page.getByTestId("questions-table")).toContainText(`Importada uno ${tag}`);

    // 5. Producto con la pregunta publicada
    await page.goto("/admin/productos/nuevo");
    await page.getByLabel("Título (castellano)").fill(`Pack de cálculo ${tag}`);
    await page.getByLabel(/Identificador en la URL/).fill(`pack-calculo-${tag}`);
    await page.getByLabel("Estado").selectOption("published");
    await page.getByLabel(/Precio en euros/).fill("9,99");
    await page.getByRole("button", { name: "Guardar producto" }).click();
    await expect(page.getByText("Producto guardado.")).toBeVisible();
    await page.getByLabel(new RegExp(`6 × 7.*${tag}`)).check();
    await page.getByRole("button", { name: "Guardar selección" }).click();
    await expect(page.getByText("Selección guardada.")).toBeVisible();

    // 6. Acceso manual a la alumna y biblioteca
    await page.goto("/admin/compras");
    await page.getByLabel("Correo del alumno").fill(studentEmail);
    await page
      .getByLabel("Producto", { exact: true })
      .selectOption({ label: `Pack de cálculo ${tag}` });
    await page.getByLabel(/Días de acceso/).fill("30");
    await page.getByRole("button", { name: "Conceder acceso" }).click();
    await expect(page.getByText("Acceso concedido.")).toBeVisible();
    await expect(page.getByTestId("purchases-table")).toContainText(studentEmail);

    await sp.goto("/app/perfil");
    await expect(sp.getByTestId("purchases")).toContainText(`Pack de cálculo ${tag}`);
    await expect(sp.getByTestId("purchases")).toContainText("Acceso concedido");

    // La alumna no entra en el panel
    await sp.goto("/admin/preguntas");
    await expect(sp).toHaveURL(/\/app$/);
    await sctx.close();
    await actx.close();
  });
});

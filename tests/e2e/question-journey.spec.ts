import { expect, test } from "@playwright/test";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { randomUUID } from "node:crypto";
import pg from "pg";
import { confirmEmail, grantRole, newEmail, signUp } from "./helpers";

const DB_URL = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";

/**
 * Recorrido del alumno desde su plan (ADR-036) con preguntas de prueba
 * (enunciados de content/test/pack-prueba.json) en un tema propio de Mossos y
 * un pack gratis de ese tema: plan → «Empezar test» → resultados → calendario
 * del panel → progreso → repaso de errores. Se borra todo al acabar.
 */
const PACK = JSON.parse(readFileSync("content/test/pack-prueba.json", "utf8")) as {
  questions: { stem: string; options: string[]; correct: number; explanation: string }[];
};
const QUESTIONS = PACK.questions.slice(0, 5);
const correctFor = (stem: string) => QUESTIONS.find((q) => q.stem === stem)!.correct;

async function withDb<T>(fn: (db: pg.Client) => Promise<T>) {
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    return await fn(db);
  } finally {
    await db.end();
  }
}

/** Tema de Mossos con 5 preguntas publicadas y un pack gratis que lo incluye. */
async function seedTopic() {
  const id = randomUUID().slice(0, 8);
  const slug = `e2e-tema-${id}`;
  const title = `Z.8 Tema de prueba ${id}`;
  await withDb(async (db) => {
    await db.query("begin");
    // contenido sembrado ya publicado (sin el flujo de revisión, que se prueba aparte)
    await db.query("set local session_replication_role = replica");
    const { rows } = await db.query(
      `with t as (insert into public.topics (slug, title) values ($1, $2) returning id),
            e as (insert into public.exam_body_topics (exam_body_id, topic_id, order_index)
                  select b.id, t.id, 998 from public.exam_bodies b, t where b.slug = 'mossos-esquadra')
       select id from t`,
      [slug, title],
    );
    for (const q of QUESTIONS) {
      const { rows: qr } = await db.query(
        `insert into public.questions (stem, explanation, category, content_hash, topic_id, source_ref, status)
         values ($1, $2, 'prueba', md5($1 || $3), $4, 'prueba', 'published') returning id`,
        [q.stem, q.explanation, id, rows[0].id],
      );
      for (const [i, body] of q.options.entries())
        await db.query(
          `insert into public.question_options (question_id, label, body, is_correct) values ($1, $2, $3, $4)`,
          [qr[0].id, String.fromCharCode(65 + i), body, i === q.correct],
        );
    }
    await db.query(
      `insert into public.products (slug, type, status, title, exam_body_id, is_free, included_in_premium, config)
       select $1, 'question_pack', 'published', 'Tema gratis e2e', b.id, true, false, $2
         from public.exam_bodies b where b.slug = 'mossos-esquadra'`,
      [`e2e-gratis-${id}`, JSON.stringify({ topic_slugs: [slug] })],
    );
    await db.query("commit");
  });
  return { slug, title, product: `e2e-gratis-${id}` };
}

async function dropTopic(seed: { slug: string; product: string }) {
  await withDb(async (db) => {
    await db.query("begin");
    await db.query("set local session_replication_role = replica");
    await db.query("delete from public.products where slug = $1", [seed.product]);
    const topic = `(select id from public.topics where slug = $1)`;
    await db.query(
      `delete from public.question_options where question_id in (select id from public.questions where topic_id = ${topic})`,
      [seed.slug],
    );
    await db.query(`delete from public.questions where topic_id = ${topic}`, [seed.slug]);
    await db.query(`delete from public.exam_body_topics where topic_id = ${topic}`, [seed.slug]);
    await db.query("delete from public.topics where slug = $1", [seed.slug]);
    await db.query("commit");
  });
}

test.describe("Recorrido del alumno con preguntas del banco", () => {
  test("plan, test del tema, resultados, calendario, progreso y repaso de errores", async ({
    page,
  }) => {
    test.setTimeout(120_000);
    const seed = await seedTopic();
    try {
      const studentEmail = newEmail("alumna");
      await signUp(page, studentEmail, "Alumna");
      await confirmEmail(page, studentEmail);
      await page.getByLabel("¿Qué oposición preparas?").selectOption("mossos-esquadra");
      await page.getByText("Empiezo de cero").click();
      await page.getByText("Mejorar en psicotécnicos").click();
      await page.getByRole("button", { name: "Generar mi plan" }).click();
      await expect(page).toHaveURL(/\/app\?welcome=1/);

      // Ya no hay pestaña de productos; la vieja dirección lleva al perfil
      const nav = page.getByRole("navigation", { name: "Mi panel" });
      await expect(nav.getByRole("link", { name: "Simulacros" })).toBeVisible();
      await expect(nav.getByRole("link", { name: "Mis productos" })).toHaveCount(0);

      // 1. La tarea del tema en el plan lleva directa al test
      const task = page.getByTestId("plan-task").filter({ hasText: seed.title });
      await expect(task).toHaveAttribute("data-state", "pending");
      await task.getByRole("button", { name: "Empezar test" }).click();
      await expect(page).toHaveURL(/\/app\/practica\/[0-9a-f-]{36}$/);

      // 2. Responde: falla la primera y acierta el resto
      for (let i = 0; i < 5; i++) {
        await expect(page.getByRole("heading", { name: `Pregunta ${i + 1} de 5` })).toBeVisible();
        const stem = (await page.getByTestId("question-stem").textContent())!.trim();
        const right = correctFor(stem);
        const pick = i === 0 ? (right + 1) % 4 : right;
        await page.getByTestId("question-option").nth(pick).click();
        await expect(
          page.getByText(i === 0 ? /Incorrecta\. La respuesta correcta es la/ : "¡Correcto!"),
        ).toBeVisible();
        await expect(page.getByText("Referencia: prueba")).toBeVisible();
        await page.getByRole("button", { name: i === 4 ? "Ver resultados" : "Siguiente" }).click();
      }

      // 3. Resultados con corrección
      await expect(page.getByTestId("practice-summary")).toContainText("4 de 5");
      await expect(page.getByTestId("review-item")).toHaveCount(5);

      // 4. El panel lo apunta en el calendario y en el avance de la tarea
      await page.goto("/app");
      const entry = page.getByTestId("calendar-entry").filter({ hasText: seed.title });
      await expect(entry).toContainText("4 de 5 bien");
      await expect(page.getByTestId("calendar-summary")).toContainText("1 práctica en 1 día");
      await expect(
        page.getByTestId("plan-task").filter({ hasText: seed.title }).getByTestId("task-progress"),
      ).toContainText(/5 de \d+ preguntas esta semana/);
      // La semana anterior está vacía
      await page.getByTestId("calendar-prev").click();
      await expect(page.getByTestId("calendar-summary")).toContainText("no hay práctica");

      // 5. Progreso
      await page.goto("/app/progreso");
      await expect(page.getByText("Preguntas de temario")).toBeVisible();

      // 6. Repaso de errores: la fallada vuelve y al acertarla queda resuelta
      await page.goto("/app/practica");
      await expect(page.getByTestId("pending-split")).toContainText("Preguntas: 1");
      await page.getByRole("button", { name: "Repasar preguntas" }).click();
      await expect(page.getByRole("heading", { name: "Pregunta 1 de 1" })).toBeVisible();
      const stem = (await page.getByTestId("question-stem").textContent())!.trim();
      await page.getByTestId("question-option").nth(correctFor(stem)).click();
      await expect(page.getByText("¡Correcto!")).toBeVisible();
      await page.getByRole("button", { name: "Ver resultados" }).click();
      await expect(page.getByTestId("practice-summary")).toContainText("1 de 1");
      await page.goto("/app/practica");
      await expect(page.getByTestId("pending-split")).toContainText("Preguntas: 0");

      // 7. La antigua «Mis productos» redirige al perfil, donde está la suscripción
      await page.goto("/app/productos");
      await expect(page).toHaveURL(/\/app\/perfil$/);
      await expect(page.getByTestId("billing-section")).toBeVisible();
    } finally {
      await dropTopic(seed);
    }
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
    // mismo created_at para todo el lote: se localiza la tarjeta por su extracto
    const first = page
      .getByTestId("source-card")
      .filter({ hasText: "norma institucional básica" })
      .first();
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

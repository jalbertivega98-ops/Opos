import { expect, test } from "@playwright/test";
import pg from "pg";
import { randomUUID } from "node:crypto";
import { confirmEmail, grantRole, newEmail, signUp } from "./helpers";

const DB_URL = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";

/** Crea un tema de prueba de Mossos con una ficha en borrador. */
async function seedNote() {
  const id = randomUUID().slice(0, 8);
  const slug = `e2e-ficha-${id}`;
  const title = `Z.9 Tema de prova ${id}`;
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    await db.query(
      `with t as (insert into public.topics (slug, title) values ($1, $2) returning id),
            e as (insert into public.exam_body_topics (exam_body_id, topic_id, order_index)
                  select b.id, t.id, 999 from public.exam_bodies b, t where b.slug = 'mossos-esquadra')
       insert into public.topic_notes (topic_id, outline, key_ideas, glossary, amendments, page_from, page_to)
       select id, '[{"n":"1","title":"Primer apartat"},{"n":"1.1","title":"Subapartat"}]',
              '["Primera idea força literal.","Segona idea força literal."]', '["Terme clau"]',
              '[{"text":"Esmena oficial de prova."}]', 10, 12 from t`,
      [slug, title],
    );
  } finally {
    await db.end();
  }
  return { slug, title };
}

/** Borra el tema de prueba (la ficha cae en cascada) para no dejar restos en local. */
async function dropNote(slug: string) {
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    await db.query(
      `delete from public.exam_body_topics where topic_id = (select id from public.topics where slug = $1)`,
      [slug],
    );
    await db.query("delete from public.topics where slug = $1", [slug]);
  } finally {
    await db.end();
  }
}

test.describe("Fichas de estudio (CNT-011)", () => {
  test("la titular revisa y publica una ficha y la alumna la estudia", async ({
    page,
    browser,
  }) => {
    test.setTimeout(120_000);
    const { slug, title } = await seedNote();
    const ownerEmail = newEmail("titular");
    await signUp(page, ownerEmail);
    await confirmEmail(page, ownerEmail);
    grantRole(ownerEmail, "owner");

    // Una alumna que prepara Mossos no ve la ficha mientras está en borrador
    const sctx = await browser.newContext();
    const sp = await sctx.newPage();
    const studentEmail = newEmail("alumna");
    await signUp(sp, studentEmail);
    await confirmEmail(sp, studentEmail);
    await sp.getByLabel("¿Qué oposición preparas?").selectOption("mossos-esquadra");
    await sp.getByText("Ya he estudiado algo").click();
    await sp.getByText("Mejorar en psicotécnicos").click();
    await sp.getByRole("button", { name: "Generar mi plan" }).click();
    await expect(sp).toHaveURL(/\/app\?welcome=1/);
    await sp.goto(`/app/temario/${slug}`);
    await expect(sp.getByTestId("topic-note")).toHaveCount(0);

    // La titular la aprueba y la publica desde el panel
    await page.goto("/admin/revision/fichas");
    const card = page.getByTestId("note-card").filter({ hasText: title });
    await card.locator("summary").click();
    await expect(card.getByTestId("note-key-ideas")).toContainText("Primera idea força literal.");
    await card.getByLabel("Confirmo que he revisado esta ficha").check();
    await card.getByRole("button", { name: "Aprobar ficha" }).click();
    await expect(card.getByText("Ficha aprobada.")).toBeVisible();
    await page.reload();
    const card2 = page.getByTestId("note-card").filter({ hasText: title });
    await card2.locator("summary").click();
    await card2.getByLabel("Confirmo que he revisado esta ficha").check();
    await card2.getByRole("button", { name: "Publicar ficha" }).click();
    await expect(card2.getByText("Ficha publicada.")).toBeVisible();

    // La alumna la encuentra en «Temario» y la abre
    await sp.goto("/app/temario");
    await sp.getByRole("link", { name: new RegExp(title) }).click();
    await expect(sp).toHaveURL(new RegExp(`/app/temario/${slug}$`));
    await expect(sp.getByRole("heading", { level: 1 })).toHaveText(title);
    await expect(sp.getByTestId("note-outline")).toContainText("1.1. Subapartat");
    await expect(sp.getByTestId("note-key-ideas")).toContainText("Segona idea força literal.");
    await expect(sp.getByTestId("note-glossary")).toContainText("Terme clau");
    await expect(sp.getByTestId("note-amendments")).toContainText("Esmena oficial de prova.");
    await sctx.close();
    await dropNote(slug);
  });
});

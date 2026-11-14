import { expect, test } from "@playwright/test";
import pg from "pg";
import { randomUUID } from "node:crypto";

const DB_URL = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";

/** Crea una oposición de prueba con un tema gratis y 6 preguntas publicadas (B es la buena). */
async function seedExam() {
  const id = randomUUID().slice(0, 8);
  const slug = `e2e-test-gratis-${id}`;
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    await db.query("begin");
    // Datos de prueba ya «publicados»: se saltan los disparadores del flujo de revisión.
    await db.query("set local session_replication_role = replica");
    await db.query(
      `with o as (select id from public.organizations limit 1),
            b as (insert into public.exam_bodies (slug, organization_id, name, category, availability, is_published)
                  select $1, o.id, 'Oposición E2E ' || $2, 'otros', 'available', true from o returning id),
            t as (insert into public.topics (slug, title) values ($1 || '-t1', 'Tema E2E') returning id),
            et as (insert into public.exam_body_topics (exam_body_id, topic_id) select b.id, t.id from b, t),
            p as (insert into public.products (slug, type, status, title, exam_body_id, is_free, config)
                  select $1 || '-gratis', 'question_pack', 'published', 'Gratis', b.id, true,
                         jsonb_build_object('topic_slugs', jsonb_build_array($1 || '-t1')) from b)
       select 1`,
      [slug, id],
    );
    for (let i = 0; i < 6; i++) {
      const { rows } = await db.query(
        `insert into public.questions (stem, explanation, category, content_hash, topic_id, source_ref, status, published_at)
         select $1, 'Explicación de prueba.', 'prueba', md5($1), t.id, 'art. 1', 'published', now()
           from public.topics t where t.slug = $2 || '-t1' returning id`,
        [`Pregunta E2E ${id} número ${i}`, slug],
      );
      await db.query(
        `insert into public.question_options (question_id, label, body, is_correct)
         values ($1,'A','Opción uno',false), ($1,'B','Opción buena',true), ($1,'C','Opción tres',false), ($1,'D','Opción cuatro',false)`,
        [rows[0].id],
      );
    }
    await db.query("commit");
  } finally {
    await db.end();
  }
  return slug;
}

async function dropExam(slug: string) {
  const db = new pg.Client({ connectionString: DB_URL });
  await db.connect();
  try {
    await db.query("begin");
    await db.query("set local session_replication_role = replica");
    const topic = `(select id from public.topics where slug = $1 || '-t1')`;
    await db.query(`delete from public.questions where topic_id = ${topic}`, [slug]);
    await db.query(`delete from public.exam_body_topics where topic_id = ${topic}`, [slug]);
    await db.query("delete from public.products where slug = $1 || '-gratis'", [slug]);
    await db.query("delete from public.topics where slug = $1 || '-t1'", [slug]);
    await db.query("delete from public.exam_bodies where slug = $1", [slug]);
    await db.query("delete from public.funnel_daily where exam = $1", [slug]);
    await db.query("commit");
  } finally {
    await db.end();
  }
}

test.describe("Test gratis sin registro (ADR-041)", () => {
  let slug: string;
  test.beforeAll(async () => {
    slug = await seedExam();
  });
  test.afterAll(async () => {
    await dropExam(slug);
  });

  test("se llega desde la ficha, se hace sin cuenta y acaba invitando a registrarse", async ({
    page,
  }) => {
    await page.goto(`/oposiciones/${slug}`);
    await expect(page.getByTestId("sample-test-link")).toHaveAttribute(
      "href",
      `/oposiciones/${slug}/test`,
    );
    await page.goto(`/oposiciones/${slug}/test`);
    await expect(page.getByRole("heading", { level: 1 })).toContainText(
      "Test gratis de Oposición E2E",
    );
    await expect(page.locator('link[rel="canonical"]')).toHaveAttribute(
      "href",
      new RegExp(`/oposiciones/${slug}/test$`),
    );

    for (let i = 0; i < 6; i++) {
      // Falla la primera, acierta el resto
      await page
        .getByTestId("question-option")
        .nth(i === 0 ? 0 : 1)
        .click();
      await expect(
        page.getByText(i === 0 ? "Incorrecta. La respuesta correcta es la B." : "¡Correcto!"),
      ).toBeVisible();
      await expect(page.getByText("Explicación de prueba.")).toBeVisible();
      // Desde la 3.ª pregunta se invita a guardar el progreso con una cuenta (ADR-056).
      await expect(page.getByTestId("sample-save-progress")).toHaveCount(i >= 2 ? 1 : 0);
      await page.getByRole("button", { name: i === 5 ? "Ver resultados" : "Siguiente" }).click();
    }
    await expect(page.getByTestId("sample-result")).toContainText("Has acertado 5 de 6");
    await expect(page.getByTestId("sample-result")).toContainText("Equivale a un 8,3 sobre 10");
    // Repaso de lo fallado: solo la primera, con la respuesta buena y la explicación.
    const misses = page.getByTestId("sample-misses").getByRole("listitem");
    await expect(misses).toHaveCount(1);
    await expect(misses.first()).toContainText(`Pregunta E2E`);
    await expect(misses.first()).toContainText("Tu respuesta: Opción uno");
    await expect(misses.first()).toContainText("Correcta: B. Opción buena");
    // El registro conserva la oposición.
    await expect(page.getByTestId("sample-register")).toHaveAttribute(
      "href",
      `/registro?exam=${slug}`,
    );
    // El embudo del panel cuenta que se empezó y se terminó (ADR-047), sin datos personales.
    await expect
      .poll(async () => {
        const db = new pg.Client({ connectionString: DB_URL });
        await db.connect();
        try {
          const { rows } = await db.query(
            "select step, hits from public.funnel_daily where exam = $1 order by step",
            [slug],
          );
          return rows.map((r) => `${r.step}:${r.hits}`).join(",");
        } finally {
          await db.end();
        }
      })
      .toBe("sample_finish:1,sample_start:1");
  });

  test("la portada pone el test gratis como acción principal (ADR-056)", async ({ page }) => {
    await page.goto("/");
    const picker = page.getByTestId("hero-free-tests");
    await expect(picker.getByLabel("Haz un test gratis de tu oposición")).toBeVisible();
    await picker.getByLabel("Haz un test gratis de tu oposición").selectOption(slug);
    await picker.getByRole("button", { name: "Empezar test gratis" }).click();
    await expect(page).toHaveURL(new RegExp(`/oposiciones/${slug}/test$`));
    await expect(page.getByTestId("question-stem")).toBeVisible();
    // Crear cuenta sigue a un clic, como segunda opción.
    await page.goto("/");
    await expect(page.getByTestId("hero-signup")).toHaveAttribute("href", "/registro");
  });

  test("«Preparar esta oposición» lleva al visitante a crear la cuenta con la oposición elegida", async ({
    page,
  }) => {
    await page.goto(`/oposiciones/${slug}`);
    await page.getByTestId("prepare-exam").click();
    await expect(page).toHaveURL(/\/registro\?next=/);
    expect(decodeURIComponent(page.url())).toContain(`/app/onboarding?exam=${slug}`);
    await expect(page.getByRole("heading", { level: 1 })).toContainText("Crea tu cuenta");
    await expect(page.locator('form input[name="next"]').last()).toHaveValue(
      `/app/onboarding?exam=${slug}`,
    );
    // «Ya tengo cuenta» también conserva el destino.
    await expect(page.getByRole("link", { name: "Entra", exact: true })).toHaveAttribute(
      "href",
      `/entrar?next=${encodeURIComponent(`/app/onboarding?exam=${slug}`)}`,
    );
  });

  test("aparece en el sitemap y una oposición sin preguntas gratis no tiene test", async ({
    request,
  }) => {
    const xml = await (await request.get("/sitemap.xml")).text();
    expect(xml).toContain(`/oposiciones/${slug}/test`);
    expect((await request.get("/oposiciones/correos-personal-laboral/test")).status()).toBe(404);
  });
});

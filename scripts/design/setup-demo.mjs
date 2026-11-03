// Prepara datos de DEMOSTRACIÓN en la pila LOCAL para capturas de diseño (antes/después).
// Publica en local el temario de supabase/preview (igual que la preview) y crea dos alumnas:
//  · «Laura»: onboarding con Mossos, prácticas hechas, fallos pendientes y una práctica a medias.
//  · «Nueva»: recién registrada, sin onboarding (estado vacío).
// Guarda las sesiones (storageState) en la carpeta indicada. Solo para la pila local.
// Uso: node scripts/design/setup-demo.mjs <carpeta-estado>
import { chromium } from "playwright";
import { execFileSync } from "node:child_process";
import { mkdirSync } from "node:fs";
import { randomUUID } from "node:crypto";
import pg from "pg";

const OUT = process.argv[2] ?? "design-state";
const BASE = process.env.BASE_URL ?? "http://localhost:3000";
const MAILPIT = "http://127.0.0.1:54324";
const DB = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";
const PASSWORD = "Opositor2026";
if (!/127\.0\.0\.1|localhost/.test(DB)) throw new Error("Solo para la base de datos local");
mkdirSync(OUT, { recursive: true });

const db = new pg.Client({ connectionString: DB });
await db.connect();

async function confirmLink(email) {
  for (let i = 0; i < 40; i++) {
    const r = await (
      await fetch(`${MAILPIT}/api/v1/search?query=${encodeURIComponent(`to:"${email}"`)}`)
    ).json();
    if (r.messages?.length) {
      const full = await (await fetch(`${MAILPIT}/api/v1/message/${r.messages[0].ID}`)).json();
      return (full.Text || full.HTML).match(/https?:\/\/[^\s"'<>)]+/)[0].replace(/&amp;/g, "&");
    }
    await new Promise((res) => setTimeout(res, 500));
  }
  throw new Error("sin correo");
}

const browser = await chromium.launch();
const tag = randomUUID().slice(0, 6);
async function signUp(ctx, email, name) {
  const page = await ctx.newPage();
  await page.goto(`${BASE}/registro`);
  await page.getByLabel("Nombre (opcional)").fill(name);
  await page.getByLabel("Correo electrónico").fill(email);
  await page.getByLabel("Contraseña").fill(PASSWORD);
  await page.getByRole("checkbox").check();
  await page.getByRole("button", { name: "Crear cuenta" }).click();
  await page.waitForURL(/verifica-tu-correo/);
  await page.goto(await confirmLink(email));
  await page.waitForLoadState("networkidle");
  return page;
}

// 0) Temario de la preview cargado en local (idempotente)
for (const f of [
  "3-b1-guia-ca",
  "5a-temario-mossos-ambit-a",
  "5b-temario-mossos-ambit-b",
  "5c-temario-mossos-ambit-c",
  "6-packs-mossos-ca",
  "7-simulacros",
  "9-pack-completo",
]) {
  execFileSync("psql", ["-q", "-v", "ON_ERROR_STOP=1", DB, "-f", `supabase/preview/${f}.sql`], {
    stdio: "ignore",
  });
}

// 1) Titular: publica en local el temario cargado (equivale a «Aprobar y publicar todo»).
const owner = `titular-${tag}@example.test`;
const octx = await browser.newContext();
await signUp(octx, owner, "Titular");
execFileSync("node", ["scripts/grant-role.mjs", owner, "owner"]);
const { rows } = await db.query("select id from auth.users where email = $1", [owner]);
await db.query("begin");
await db.query("select set_config('request.jwt.claims', $1, true)", [
  JSON.stringify({ sub: rows[0].id, role: "authenticated" }),
]);
await db.query("select set_config('request.jwt.claim.sub', $1, true)", [rows[0].id]);
await db.query("select public.review_all_batch(true)");
await db.query("select public.open_exams_with_content()");
await db.query("commit");

// 2) Laura: onboarding Mossos + actividad
const lctx = await browser.newContext();
const lp = await signUp(lctx, `laura-${tag}@example.test`, "Laura");
await lp.goto(`${BASE}/app/onboarding`);
await lp.getByLabel("¿Qué oposición preparas?").selectOption("mossos-esquadra");
await lp.getByText("Ya he estudiado algo").click();
await lp.getByText("Mejorar en psicotécnicos").click();
await lp.getByRole("button", { name: "Generar mi plan" }).click();
await lp.waitForURL(/\/app\?welcome=1/);
await db.query(
  `insert into public.access_grants (user_id, product_id, source, note)
   select u.id, p.id, 'admin', 'capturas de diseño' from auth.users u, public.products p
    where u.email = $1 and p.slug = 'mossos-pack-complet-2026'`,
  [`laura-${tag}@example.test`],
);

async function psychoSession(answers) {
  await lp.goto(`${BASE}/app/practica`);
  await lp.getByRole("button", { name: "Empezar" }).click();
  await lp.waitForURL(/practica\/[0-9a-f-]{36}$/);
  for (let i = 0; i < answers; i++) {
    await lp
      .getByTestId("psycho-option")
      .nth(i % 3)
      .click();
    await lp
      .getByRole("button", { name: i === 9 ? "Ver resultado" : "Siguiente", exact: true })
      .click();
  }
}
await psychoSession(10);
await lp.waitForSelector('[data-testid="practice-summary"]');

// test de preguntas del pack (10 preguntas, algunas falladas)
await lp.goto(`${BASE}/app/productos`);
const card = lp
  .getByTestId("library-item")
  .filter({ has: lp.getByRole("button", { name: "Practicar" }) })
  .first();
await card.getByRole("button", { name: "Practicar" }).click();
await lp.waitForURL(/practica\/[0-9a-f-]{36}$/);
for (let i = 0; i < 10; i++) {
  const opts = lp.getByTestId("question-option");
  if ((await opts.count()) === 0) break;
  await opts.nth(i % 4).click();
  const next = lp.getByRole("button", { name: /^(Siguiente|Ver resultados)$/ });
  await next.click();
  if (
    await lp
      .getByTestId("practice-summary")
      .isVisible()
      .catch(() => false)
  )
    break;
}

// práctica a medias (para «Continuar donde lo dejaste»)
await psychoSession(4);
await lctx.storageState({ path: `${OUT}/laura.json` });

// 3) Alumna nueva, sin onboarding
const nctx = await browser.newContext();
await signUp(nctx, `nueva-${tag}@example.test`, "Marta");
await nctx.storageState({ path: `${OUT}/nueva.json` });

await browser.close();
await db.end();
console.log(`estado guardado en ${OUT}`);

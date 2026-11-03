// Capturas de las pantallas principales (escritorio y móvil) con datos de PRUEBA.
// Requiere la pila local + `npm run dev`. Uso: node scripts/screenshots.mjs <carpeta-salida>
import { chromium, devices } from "playwright";
import { execFileSync } from "node:child_process";
import { readFileSync, mkdirSync } from "node:fs";
import { randomUUID } from "node:crypto";
import pg from "pg";

const OUT = process.argv[2] ?? "screenshots";
const BASE = process.env.BASE_URL ?? "http://localhost:3000";
const MAILPIT = "http://127.0.0.1:54324";
const PASSWORD = "Opositor2026";
mkdirSync(OUT, { recursive: true });
const pack = JSON.parse(readFileSync("content/test/pack-prueba.json", "utf8"));
const correctFor = (stem) => pack.questions.find((q) => q.stem === stem)?.correct ?? 0;

const db = new pg.Client({
  connectionString: process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia",
});
await db.connect();

async function confirmLink(email) {
  for (let i = 0; i < 30; i++) {
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
const owner = `titular-${tag}@example.test`;
const student = `laura-${tag}@example.test`;

async function signUp(page, email, name) {
  await page.goto(`${BASE}/registro`);
  await page.getByLabel("Nombre (opcional)").fill(name);
  await page.getByLabel("Correo electrónico").fill(email);
  await page.getByLabel("Contraseña").fill(PASSWORD);
  await page.getByRole("checkbox").check();
  await page.getByRole("button", { name: "Crear cuenta" }).click();
  await page.waitForURL(/verifica-tu-correo/);
  await page.goto(await confirmLink(email));
  await page.waitForLoadState("networkidle");
}

// titular de prueba + contenido de prueba publicado
const octx = await browser.newContext();
await signUp(await octx.newPage(), owner, "Titular");
execFileSync("node", ["scripts/grant-role.mjs", owner, "owner"]);
execFileSync("node", [
  "scripts/content/load-questions.mjs",
  "content/test/pack-prueba.json",
  "--test",
  "--publish-as",
  owner,
]);

// alumna con acceso concedido (como haría la titular desde Admin › Compras)
const desk = await browser.newContext({
  viewport: { width: 1280, height: 800 },
  deviceScaleFactor: 2,
});
const page = await desk.newPage();
await signUp(page, student, "Laura");
await db.query(
  `insert into public.access_grants (user_id, product_id, source, note)
   select u.id, p.id, 'admin', 'capturas' from auth.users u, public.products p
    where u.email = $1 and p.slug = 'prueba-pack-demo'`,
  [student],
);

// actividad: un test de psicotécnicos y un test de preguntas (con un fallo)
await page.goto(`${BASE}/app/practica`);
await page.getByRole("button", { name: "Empezar" }).click();
await page.waitForURL(/practica\/[0-9a-f-]{36}$/);
for (let i = 0; i < 10; i++) {
  await page
    .getByTestId("psycho-option")
    .nth(i % 3)
    .click();
  await page
    .getByRole("button", { name: i === 9 ? "Ver resultado" : "Siguiente", exact: true })
    .click();
}
await page.waitForSelector('[data-testid="practice-summary"]');

async function startPack(p) {
  await p.goto(`${BASE}/app/productos`);
  const card = p.getByTestId("library-item").filter({ hasText: "[PRUEBA]" });
  await card.getByLabel("Preguntas por test").selectOption("5");
  await card.getByRole("button", { name: "Practicar" }).click();
  await p.waitForURL(/practica\/[0-9a-f-]{36}$/);
}
await startPack(page);
for (let i = 0; i < 5; i++) {
  const stem = (await page.getByTestId("question-stem").textContent()).trim();
  const right = correctFor(stem);
  await page
    .getByTestId("question-option")
    .nth(i === 1 ? (right + 1) % 4 : right)
    .click();
  await page.getByRole("button", { name: i === 4 ? "Ver resultados" : "Siguiente" }).click();
}
await page.waitForSelector('[data-testid="practice-summary"]');

const mobile = await browser.newContext({ ...devices["iPhone 13"] });
await mobile.addCookies((await desk.cookies()).map((c) => ({ ...c })));
const mpage = await mobile.newPage();

async function shot(p, name, url, prep) {
  if (url) await p.goto(`${BASE}${url}`);
  if (prep) await prep(p);
  await p.waitForLoadState("networkidle");
  // con la cabecera fija, capturar desde arriba evita que aparezca a media página
  await p.evaluate(() => window.scrollTo(0, 0));
  await p.waitForTimeout(300);
  await p.screenshot({ path: `${OUT}/${name}.png`, fullPage: true });
}
const anon = await browser.newContext({
  viewport: { width: 1280, height: 800 },
  deviceScaleFactor: 2,
});
const anonM = await browser.newContext({ ...devices["iPhone 13"] });
await shot(await anon.newPage(), "1-portada-escritorio", "/");
await shot(await anonM.newPage(), "1-portada-movil", "/");
await shot(page, "2-panel-escritorio", "/app");
await shot(mpage, "2-panel-movil", "/app");
// ejercicio: test en curso con la corrección y la referencia visibles
const exercise = async (p) => {
  await startPack(p);
  const stem = (await p.getByTestId("question-stem").textContent()).trim();
  await p
    .getByTestId("question-option")
    .nth((correctFor(stem) + 1) % 4)
    .click();
  await p.getByText(/Incorrecta\. La respuesta/).waitFor();
};
await shot(page, "3-ejercicio-escritorio", null, exercise);
await shot(mpage, "3-ejercicio-movil", null, exercise);
await shot(page, "4-progreso-escritorio", "/app/progreso");
await shot(mpage, "4-progreso-movil", "/app/progreso");
await shot(page, "5-mis-productos-escritorio", "/app/productos");

// revisión con fuente (titular)
const ownerDesk = await browser.newContext({
  viewport: { width: 1280, height: 800 },
  deviceScaleFactor: 2,
});
await ownerDesk.addCookies(await octx.cookies());
const op = await ownerDesk.newPage();
await op.goto(`${BASE}/admin/revision/fuentes?tema=mossos-b1-estatut`);
await op.waitForLoadState("networkidle");
await op.screenshot({ path: `${OUT}/6-revision-fuente-escritorio.png` });

await browser.close();
await db.end();
console.log(`capturas en ${OUT}`);

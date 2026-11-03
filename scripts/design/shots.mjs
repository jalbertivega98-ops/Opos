// Capturas de portada y panel del alumno (escritorio + móvil, claro + oscuro opcional).
// Requiere `npm run dev` y el estado creado por scripts/design/setup-demo.mjs.
// Uso: node scripts/design/shots.mjs <carpeta-estado> <carpeta-salida> [--dark]
import { chromium, devices } from "playwright";
import { mkdirSync } from "node:fs";

const [STATE, OUT] = process.argv.slice(2);
const dark = process.argv.includes("--dark");
const BASE = process.env.BASE_URL ?? "http://localhost:3000";
mkdirSync(OUT, { recursive: true });
const browser = await chromium.launch();
const desk = { viewport: { width: 1280, height: 800 }, deviceScaleFactor: 2 };
const mob = { ...devices["iPhone 13"] };
const scheme = { colorScheme: dark ? "dark" : "light" };
const sfx = dark ? "-oscuro" : "";

async function shot(opts, storageState, url, name) {
  const ctx = await browser.newContext({
    ...opts,
    ...scheme,
    ...(storageState ? { storageState } : {}),
  });
  const p = await ctx.newPage();
  await p.goto(`${BASE}${url}`);
  await p.waitForLoadState("networkidle");
  await p.addStyleTag({ content: "nextjs-portal{display:none!important}" });
  await p.evaluate(() => window.scrollTo(0, 0));
  await p.waitForTimeout(400);
  await p.screenshot({ path: `${OUT}/${name}${sfx}.png`, fullPage: true });
  await ctx.close();
}
const laura = `${STATE}/laura.json`;
const nueva = `${STATE}/nueva.json`;
await shot(desk, null, "/", "1-portada-escritorio");
await shot(mob, null, "/", "1-portada-movil");
await shot(desk, laura, "/app", "2-panel-escritorio");
await shot(mob, laura, "/app", "2-panel-movil");
await shot(desk, nueva, "/app", "3-panel-nuevo-escritorio");
await shot(mob, nueva, "/app", "3-panel-nuevo-movil");
await browser.close();
console.log(`capturas en ${OUT}`);

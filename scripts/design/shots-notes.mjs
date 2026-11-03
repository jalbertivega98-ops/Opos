// Capturas del temario (fichas de estudio) con la alumna demo de setup-demo.mjs.
// Uso: node scripts/design/shots-notes.mjs <carpeta-estado> <carpeta-salida>
import { chromium, devices } from "playwright";
const [STATE, OUT] = process.argv.slice(2);
const BASE = "http://localhost:3000";
const browser = await chromium.launch();
const desk = { viewport: { width: 1280, height: 800 }, deviceScaleFactor: 2 };
const mob = { ...devices["iPhone 13"] };
async function shot(opts, url, name, full = true) {
  const ctx = await browser.newContext({ ...opts, storageState: `${STATE}/laura.json` });
  const p = await ctx.newPage();
  await p.goto(`${BASE}${url}`);
  await p.waitForLoadState("networkidle");
  await p.addStyleTag({ content: "nextjs-portal{display:none!important}" });
  await p.waitForTimeout(400);
  await p.screenshot({ path: `${OUT}/${name}.png`, fullPage: full });
  await ctx.close();
}
await shot(desk, "/app/temario", "1-temario-escritorio");
await shot(desk, "/app/temario/mossos-a2-historia-2", "2-ficha-a2-escritorio");
await shot(mob, "/app/temario/mossos-b1-estatut", "3-ficha-b1-movil");
await browser.close();

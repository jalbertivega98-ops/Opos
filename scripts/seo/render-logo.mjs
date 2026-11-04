// Genera las imágenes de marca para buscadores y redes a partir de src/app/icon.svg:
//  * public/logo-512.png: logo de Schema.org (Organization.logo).
//  * public/og-image.png: imagen para compartir (Open Graph, 1200 × 630).
// Uso: node scripts/seo/render-logo.mjs  (en el contenedor: PW_CHROMIUM_PATH=/opt/pw-browsers/chromium)
import { chromium } from "@playwright/test";
import { readFileSync } from "node:fs";

const svg = readFileSync("src/app/icon.svg", "utf8");
const exe = process.env.PW_CHROMIUM_PATH;
const browser = await chromium.launch(exe ? { executablePath: exe } : {});

const logo = await browser.newPage({ viewport: { width: 512, height: 512 } });
await logo.setContent(
  `<body style="margin:0">${svg.replace("<svg ", '<svg width="512" height="512" ')}</body>`,
);
await logo.locator("svg").screenshot({ path: "public/logo-512.png", omitBackground: true });

const og = await browser.newPage({ viewport: { width: 1200, height: 630 } });
await og.setContent(`<!doctype html><html lang="es"><body style="margin:0">
<div style="box-sizing:border-box;width:1200px;height:630px;padding:72px;background:#0b2545;color:#fff;
  font-family:Georgia,'Times New Roman',serif;display:flex;flex-direction:column;justify-content:space-between">
  <div style="display:flex;align-items:center;gap:20px;font:800 46px system-ui,sans-serif">
    ${svg.replace("<svg ", '<svg width="80" height="80" style="border:2px solid #2dd4bf;border-radius:22px" ')}
    <span>OPOS<span style="color:#2dd4bf">APRUEBA</span></span>
  </div>
  <div>
    <div style="font-size:70px;font-weight:700;line-height:1.08">Test de oposiciones, temario y psicotécnicos</div>
    <div style="margin-top:24px;font:400 30px system-ui,sans-serif;color:#c9d6e8">
      Preguntas basadas en fuentes oficiales · Psicotécnicos gratis · Simulacros</div>
  </div>
</div></body></html>`);
await og.screenshot({ path: "public/og-image.png" });
await browser.close();
console.log("public/logo-512.png y public/og-image.png generados");

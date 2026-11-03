import { chromium, devices } from "playwright";
const [state, url, mobile] = process.argv.slice(2);
const b = await chromium.launch();
const ctx = await b.newContext({
  ...(mobile ? devices["iPhone 13"] : { viewport: { width: 1280, height: 800 } }),
  ...(state !== "-" ? { storageState: state } : {}),
});
const p = await ctx.newPage();
await p.goto("http://localhost:3000" + url);
await p.waitForLoadState("networkidle");
const r = await p.evaluate(() => {
  const W = document.documentElement.clientWidth;
  const out = [];
  for (const el of document.querySelectorAll("body *")) {
    const rc = el.getBoundingClientRect();
    if (rc.right > W + 1)
      out.push(
        `${el.tagName}.${(el.className?.baseVal ?? el.className).toString().slice(0, 80)} right=${Math.round(rc.right)}`,
      );
  }
  return { W, sw: document.documentElement.scrollWidth, out: out.slice(0, 8) };
});
console.log(JSON.stringify(r, null, 1));
await b.close();

// Avisa a IndexNow (Bing, Yandex, Seznam, Naver…) de las URL del sitemap.
// Uso (solo con la web pública, sin contraseña de preview):
//   SITE_URL=https://oposaprueba.com INDEXNOW_KEY=<clave> node scripts/seo/indexnow.mjs
// La misma clave debe estar en Vercel como INDEXNOW_KEY (se sirve en /indexnow.txt).
const site = (process.env.SITE_URL ?? "").replace(/\/+$/, "");
// Clave pública por defecto (la misma que sirve /indexnow.txt si no hay INDEXNOW_KEY).
const key = process.env.INDEXNOW_KEY || "5b801bdc923c43ffa5b29374fbfd1d12";
if (!/^https:\/\//.test(site) || !key) {
  console.error("Faltan SITE_URL (https) o INDEXNOW_KEY.");
  process.exit(1);
}
const xml = await (await fetch(`${site}/sitemap.xml`)).text();
const urls = [...new Set([...xml.matchAll(/<loc>([^<]+)<\/loc>/g)].map((m) => m[1]))];
if (!urls.length) {
  console.error("El sitemap no tiene URL (¿sigue activa la contraseña de preview?).");
  process.exit(1);
}
const res = await fetch("https://api.indexnow.org/indexnow", {
  method: "POST",
  headers: { "content-type": "application/json; charset=utf-8" },
  body: JSON.stringify({
    host: new URL(site).host,
    key,
    keyLocation: `${site}/indexnow.txt`,
    urlList: urls,
  }),
});
console.log(`IndexNow: ${res.status} ${res.statusText} · ${urls.length} URL enviadas`);
if (!res.ok) process.exit(1);

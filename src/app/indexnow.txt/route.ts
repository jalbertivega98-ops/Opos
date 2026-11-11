/**
 * Clave de IndexNow (Bing, Yandex, Seznam…): el archivo demuestra que el dominio
 * es nuestro. La clave es pública por diseño. Ver scripts/seo/indexnow.mjs.
 */
const INDEXNOW_DEFAULT_KEY = "5b801bdc923c43ffa5b29374fbfd1d12";

export function GET() {
  const key = process.env.INDEXNOW_KEY?.trim() || INDEXNOW_DEFAULT_KEY;
  if (!key || !/^[a-zA-Z0-9-]{8,128}$/.test(key)) return new Response("Not found", { status: 404 });
  return new Response(key, { headers: { "content-type": "text/plain; charset=utf-8" } });
}

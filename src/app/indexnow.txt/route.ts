/**
 * Clave de IndexNow (Bing, Yandex, Seznam…): el archivo demuestra que el dominio
 * es nuestro. La clave es pública por diseño. Ver scripts/seo/indexnow.mjs.
 */
export function GET() {
  const key = process.env.INDEXNOW_KEY?.trim();
  if (!key || !/^[a-zA-Z0-9-]{8,128}$/.test(key)) return new Response("Not found", { status: 404 });
  return new Response(key, { headers: { "content-type": "text/plain; charset=utf-8" } });
}

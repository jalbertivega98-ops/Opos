# SEO y GEO · guía de mantenimiento (ADR-025)

Objetivo: que buscadores (Google, Bing) y asistentes de IA (ChatGPT, Gemini, Perplexity, Copilot, Claude) puedan rastrear las páginas públicas de OPOSAPRUEBA, entenderlas y citarlas. Siempre con datos reales y verificados.

## 1. Interruptor de indexación

`isIndexable()` (`src/lib/seo/site.ts`) es `true` solo si se cumplen todas estas condiciones:

- `PREVIEW_PASSWORD` está vacía.
- `VERCEL_ENV` es `production` o no está definida.
- `NEXT_PUBLIC_SITE_URL` empieza por `https://` y no es localhost.
- `SEO_INDEXABLE` no vale `false`.

Mientras no es indexable, `robots.txt` devuelve `Disallow: /` y todas las páginas llevan `noindex, nofollow`. Hoy la web tiene contraseña de preview, así que **ningún rastreador puede entrar**. Para abrirla: quitar `PREVIEW_PASSWORD` en Vercel y **redesplegar** (`robots.txt` y `sitemap.xml` se generan en el build).

## 2. Qué se sirve

| Recurso       | Ruta            | Notas                                                                                                                                    |
| ------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| robots.txt    | `/robots.txt`   | Permite a OAI-SearchBot, ChatGPT-User, PerplexityBot, Claude-SearchBot, Googlebot, Bingbot… Bloquea `/app`, `/admin`, `/api/`, `/auth/`. |
| Sitemap       | `/sitemap.xml`  | Portada, catálogo, guías de oposición indexables y 12 tipos de psicotécnico, en es y ca con hreflang. Se regenera cada hora.             |
| llms.txt      | `/llms.txt`     | Resumen en Markdown para asistentes de IA (llmstxt.org).                                                                                 |
| Imagen social | `/og-image.png` | 1200 × 630. Se regenera con `PW_CHROMIUM_PATH=/opt/pw-browsers/chromium node scripts/seo/render-logo.mjs`.                               |
| Logo          | `/logo-512.png` | Lo usa `Organization.logo` en Schema.org.                                                                                                |
| IndexNow      | `/indexnow.txt` | Devuelve `INDEXNOW_KEY` o la clave pública por defecto. La Action `indexnow.yml` avisa a IndexNow tras cada push a main (ADR-045).      |

## 3. Páginas públicas y contenido

- `/` es la portada, con Organization, WebSite y FAQPage.
- `/oposiciones` es el catálogo. Las búsquedas y los filtros son `noindex` y su canonical apunta al catálogo.
- `/oposiciones/[slug]` es la ficha de cada oposición. Si existe una guía en `src/lib/seo/exam-guides.ts`, muestra datos clave, estructura del examen, fechas, temario (tabla `topics`), psicotécnicos relacionados, preguntas frecuentes y fuentes oficiales. Las fichas «próximamente» sin guía son `noindex, follow`.
- `/oposiciones/[slug]/test` es el test gratis sin registro (ADR-041): 10 preguntas del día de los temas gratis, corregidas al momento y sin guardar nada. Sale en la ficha y en el sitemap si hay al menos 5 preguntas; si no, es `noindex` (o 404 si no hay ninguna). Ataca búsquedas tipo «test oposiciones <nombre>».
- `/psicotecnicos` reúne los psicotécnicos. `?tipo=` sigue funcionando y su canonical apunta a la página del tipo.
- `/psicotecnicos/[tipo]` tiene 12 páginas, cada una con entrenador gratuito, método, oposiciones relacionadas, preguntas frecuentes y Quiz/LearningResource. El contenido está en `src/lib/seo/psycho-guides.ts`.

**Regla:** los datos de examen (plazas, fechas, formato, cortes) solo se añaden si salen de una fuente oficial leída y anotada en `docs/research/`. Hay que actualizar `verifiedOn` cada vez. No se añaden testimonios, valoraciones, precios sin fijar ni cifras de alumnos.

**Añadir una oposición:** se crea su guía en `exam-guides.ts` con `es` y `ca`. Sus psicotécnicos se enlazan en `psychoTypes`. Después se añade su nombre corto en `EXAM_NAMES` (`psicotecnicos/[tipo]/page.tsx`).

## 4. Google Search Console (cuando la web sea pública)

1. Entra en https://search.google.com/search-console y añade una propiedad de **dominio** `oposaprueba.com`.
2. Google da un registro TXT. Añádelo en Cloudflare → DNS → `TXT @`. Es la opción recomendada, porque cubre `www` y todos los protocolos.
3. Si prefieres la etiqueta HTML, usa la propiedad de prefijo de URL, copia solo el código del `content` en `GOOGLE_SITE_VERIFICATION` (Vercel) y redespliega.
4. En Sitemaps, envía `https://oposaprueba.com/sitemap.xml`.
5. Con Inspección de URLs, pide la indexación de la portada y de las dos guías.

## 5. Bing Webmaster Tools (también alimenta Copilot y parte de ChatGPT)

1. Entra en https://www.bing.com/webmasters y elige **importar desde Search Console**. Es lo más rápido. También puedes poner el código `msvalidate.01` en `BING_SITE_VERIFICATION`.
2. Envía el sitemap.
3. IndexNow es automático: la GitHub Action `indexnow.yml` envía el sitemap después de cada push a `main`. Para lanzarlo a mano: `SITE_URL=https://www.oposaprueba.com node scripts/seo/indexnow.mjs`.

## 6. Analítica de captación (`/admin/trafico`)

- El proxy (`src/proxy.ts`) clasifica solo las cargas de página completas. No cuenta los prefetch ni las navegaciones internas.
  - Por **origen**: `utm_source` o, si no hay, el dominio del `Referer`. Los canales son buscador, IA, red social, otra web o directo.
  - Por **rastreador**: según el User-Agent.
- Guarda contadores diarios en `traffic_daily` mediante `track_traffic` (solo service_role) y en segundo plano (`waitUntil`). Si falla, la navegación no se entera.
- No guarda cookies, IP, URL de origen completa ni identificadores, así que no requiere consentimiento.
- Limitaciones:
  - Las visitas desde AI Overviews o el modo IA de Google llegan como `google`.
  - Las apps de IA que no envían origen cuentan como `direct`.
  - ChatGPT suele añadir `utm_source=chatgpt.com`, que sí se reconoce.
- Se desactiva con `TRAFFIC_ANALYTICS=off`.

## 7. Comprobaciones

`npm run test` (seo, traffic), `npm run test:db` (traffic) y `npx playwright test tests/e2e/seo.spec.ts`. Tras publicar, revisa estas herramientas:

- Prueba de resultados enriquecidos de Google.
- Validador de Schema.org.
- PageSpeed Insights.
- Inspección de URL de Search Console.

## 8. Revisión semanal (Search Console)

Cada semana, con el Chrome de joel (propiedad de dominio `oposaprueba.com`):

1. Rendimiento → últimos 28 días → pestañas Consultas y Páginas. Anota clics, impresiones, CTR y posición media de las 20 primeras consultas.
2. Consultas con muchas impresiones y CTR bajo (posición 5–20): mejorar el `seoTitle`/`seoDescription` de esa página (en `exam-guides.ts`, `psycho-guides.ts` o `messages/*/seo.sample`).
3. Consultas que no tienen página propia (p. ej. «temario X», «psicotécnicos X»): proponer guía nueva, siempre con datos oficiales verificados.
4. Indexación → Páginas: revisar las «No indexadas» y pedir indexación de las páginas nuevas.
5. Apuntar el resultado en la memoria del proyecto (`seo-geo-oposaprueba`) con la fecha.

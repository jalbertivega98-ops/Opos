# Registro de decisiones (ADR)

## ADR-001 · Stack principal (2026-11-02)

**Decisión:** Next.js 16 (App Router) + TypeScript + Tailwind 4 + Supabase (Postgres/Auth/RLS) + Zod + next-intl + Vitest + Playwright; Stripe en Hito 5.
**Motivo:** stack preferido por joel; un solo lenguaje; Supabase da auth + BD + RLS gestionados, ideal para una persona.
**Consecuencias:** autorización en BD (RLS) como fuente de verdad.

## ADR-002 · Marca provisional "Aprobia" (2026-11-02)

**Decisión:** nombre neutro derivado de "aprobar", logo monograma sin simbología policial ni institucional.
**Pendiente:** comprobar disponibilidad de marca (OEPM/EUIPO) y dominio antes del lanzamiento (requiere a joel).

## ADR-003 · Pila local compatible con Supabase sin Docker (2026-11-02)

**Contexto:** en el contenedor cloud Docker funciona pero no puede descargar imágenes (Docker Hub 429, ECR/GHCR 403), así que `supabase start` no es viable. Sí se pueden descargar binarios de GitHub Releases.
**Decisión:** `scripts/stack/` con PostgreSQL 16 del sistema + binarios oficiales de GoTrue (supabase/auth v2.180.0), PostgREST v13.0.4 y Mailpit v1.27.10, más una pasarela Node que reproduce las rutas `/auth/v1` y `/rest/v1`. `bootstrap.sql` crea roles de Supabase (anon, authenticated, service_role, authenticator, supabase_auth_admin).
**Consecuencias:** E2E reales (emails incluidos) sin servicios externos. Las migraciones siguen siendo compatibles con Supabase CLI. Diferencias: sin Storage/Realtime/Edge Functions locales (no se usan aún).

## ADR-004 · Middleware en `src/proxy.ts` (2026-11-02)

Next 16 renombra `middleware` a `proxy` (runtime Node). Combina next-intl y el refresco de sesión de Supabase.

## ADR-005 · Componentes estilo shadcn escritos a mano (2026-11-02)

El registro `ui.shadcn.com` está bloqueado por la política de red del entorno. Se replican los patrones (Radix + CVA + `cn`) en `src/components/ui`. `npx shadcn add` puede usarse más adelante en un entorno con acceso.

## ADR-006 · i18n con prefijo solo para catalán (2026-11-02)

`localePrefix: "as-needed"`: castellano en `/`, catalán en `/ca`. Slugs en castellano en ambos idiomas por ahora (I18N-002 para localizarlos).

## ADR-007 · Cache Components desactivado (2026-11-02)

El scaffold de Next 16.4 activa `cacheComponents`. Casi todas las páginas dependen de cookies (sesión) y la integración con next-intl añade complejidad. Se desactiva y se reevaluará antes de Next 17 (tarea PERF-002).

## ADR-008 · Respuestas correctas solo en servidor (2026-11-02)

Alumnos y anon no tienen acceso a `questions`/`question_options`; el consumo se hace mediante funciones SECURITY DEFINER que omiten `is_correct` y corrigen en servidor.

## ADR-009 · Publicación solo con revisión humana, garantizada en BD (2026-11-02)

Trigger de transición de estados + `reviewed_by` obligatorio para publicar. Cumple la regla "contenido IA nunca se publica automáticamente como verificado".

## ADR-010 · Seed sin datos de convocatorias (2026-11-02)

El seed solo incluye nombres de organismos y cuerpos públicos; todas las oposiciones como `coming_soon`. Fechas, plazas, requisitos y URLs se añadirán con fuentes verificadas.

## ADR-011 · Integraciones MCP (2026-11-02)

Evaluadas: GitHub (ya disponible en el entorno, sin repositorio asignado a este proyecto), Supabase MCP (requiere cuenta → autorización), Stripe MCP (requiere cuenta → autorización), Playwright (se usa la librería directamente; MCP innecesario). No se añade `.mcp.json` hasta que joel autorice conectar cuentas.

## ADR-012 · Psicotécnicos generados con semilla y corrección por regeneración (2026-11-02)

**Decisión:** los generadores son funciones puras `generate(seed, difficulty)`. El cliente recibe solo la vista pública (términos y opciones); el servidor corrige regenerando el ítem desde la semilla.
**Motivo:** respuesta nunca expuesta antes de contestar, sin almacenar ítems, reproducible para auditoría y tests de propiedades (5.000 semillas verificadas sin ambigüedad).
**Consecuencias:** cuando exista historial (LRN-001) se guardará `(tipo, seed, difficulty, elección, acierto, tiempo)`.

## ADR-013 · Funciones de administración sobre auth.users (2026-11-02)

El email del alumno vive en `auth.users`, no expuesto por la API. El panel lo consulta mediante funciones SECURITY DEFINER (`admin_list_users`, `admin_get_user`, `admin_set_user_status`) que exigen `is_admin()` y registran en `audit_log`. Sin service role en la app.

## ADR-014 · Resultados de práctica escritos solo por el servidor (2026-11-02)

**Decisión:** el alumno solo lee sus resultados (RLS). Las escrituras pasan por funciones SQL ejecutables solo por `service_role`, llamadas desde Server Actions después de corregir regenerando el ítem desde la semilla y comprobar que lo mostrado coincide (`samePresentation`). El tiempo lo mide la BD.
**Motivo:** con escritura directa o RPC accesible al alumno se podrían falsear aciertos y tiempos (y en el futuro rankings).
**Consecuencias:** primer uso del cliente service role (`src/lib/supabase/service.ts`, `server-only`), limitado a esas dos funciones. Los resultados anónimos de la demo nunca se guardan ni se asocian a una cuenta.

## ADR-015 · La titular aprueba el contenido (DEC-002) (2026-11-02)

Aprobar, rechazar, publicar y archivar exigen rol `owner` en la base de datos, no solo en la interfaz. Editores y admins redactan, importan (siempre como borrador) y envían a revisión. Los generadores de psicotécnicos no pasan por este flujo porque su solución es verificable automáticamente (ADR-012).

## ADR-016 · Tienda basada en concesiones de acceso (2026-11-02)

**Decisión:** todo acceso a contenido de pago se resuelve con `has_product_access()` sobre `access_grants` y `subscriptions`. Compras (Stripe, cuando se autorice), suscripción Premium y concesiones manuales crean concesiones; la app no conoce la pasarela.
**Motivo:** un único punto de control, pruebas sin pagos reales y cambio de pasarela sin tocar el contenido. Un único banco de preguntas alimenta packs, simulacros y PDF (`product_items`).
**Consecuencias:** los pedidos se conservan sin datos personales al borrar la cuenta (obligaciones contables). Los precios se guardan en céntimos con histórico.

## ADR-017 · Registro de generadores de psicotécnicos (2026-11-02)

Contrato común `PsychoGenerator { generate, verify }` con presentación genérica (`sequence`, `text`, `analogy`, `matrix`, `figure`, `grid`) y tokens (`w:` palabra traducible, `g:` figura SVG, `p:` pieza). Siete tipos: series, letras (27 letras con Ñ), numérico, analogías (vocabulario curado es/ca), matrices (reglas por atributo con detección de ambigüedad), espacial (piezas quirales sin simetría) y atención. Cada verificador recalcula la solución y rechaza ítems ambiguos u opciones duplicadas; los tests manipulan soluciones para comprobar que se detectan.

## ADR-018 · Identidad visual «cuaderno con método» y panel en dos niveles (2026-11-03)

**Decisión:** a petición de joel, rediseño de portada y panel del alumno sin dependencias nuevas: tokens `highlight` (marcador) e `ink` (franjas marinas), fondo cuadriculado, componentes `Section`/`SectionHeader`, `IconBadge`, `ProgressRing`/`Meter`/`DayBars` y `AppNav`. El panel prioriza «Continuar practicando», progreso y repaso de errores; lo demás pasa a «Más opciones». El turquesa se oscurece a #0A7A70 para cumplir AA.
**Motivo:** todo eran tarjetas iguales con texto; no quedaba claro dónde mirar ni qué hacer.
**Consecuencias:** las demás pantallas se migrarán al mismo sistema tras la revisión de joel. La rama del rediseño no se despliega sola en Vercel (`vercel.json`, `git.deploymentEnabled` para `claude/**`). La portada no muestra testimonios ni cifras; los valores de ejemplo van marcados como tales.

## ADR-019 · Fichas de estudio literales por tema (2026-11-03)

**Decisión:** cada tema tiene una ficha (`topic_notes`) con el índice, las «Idees força», el glosario y las esmenes oficiales, **copiados literalmente** de la Guia d'estudi con sus páginas. Se extraen con `scripts/content/extract-topic-notes.mjs` y se comprueban contra el texto con `verify-excerpts.mjs`. No hay redacción propia, salvo el texto de las esmenes, que resume el PDF oficial de correcciones. Entran en borrador y solo la titular las aprueba y publica (`review_topic_notes`, también dentro de «Aprobar y publicar todo»). Cualquier cambio de contenido en una ficha aprobada o publicada la devuelve a revisión. Las publicadas son gratuitas para cualquier alumno registrado (`/app/temario`).
**Motivo:** el alumnado solo tenía preguntas y nada para estudiar. Copiar el resumen oficial no inventa nada y se verifica de forma automática.
**Consecuencias:** las fichas muestran el texto en catalán (`lang="ca"`). Si joel quiere ponerlas de pago, basta con cambiar la política RLS por `has_product_access`. La guía completa no se reproduce: la ficha enlaza al PDF oficial con la página exacta.

## ADR-020 · Segunda oposición: Auxiliar Administrativo del Estado con fuentes del BOE (2026-11-04)

**Decisión:** tras Mossos, se abre **Auxiliar Administrativo del Estado** (ingreso libre, C2). Es la de más demanda estable entre las candidatas (46.798-54.136 convocados al año frente a 27.614 de Guardia Civil y ~37.000 solicitudes de Policía Nacional). Correos junta más gente cuando convoca, pero no convoca desde 2022 y su temario es material interno, difícil de verificar. Además, el examen incluye 30 psicotécnicas y el temario son leyes del BOE, citables literalmente. Fuentes y cifras en `docs/research/auxiliar-estado-fuentes.md`.
Como `boe.es` no es accesible desde el contenedor, el texto consolidado se toma de la réplica `legalize-dev/legalize-es` (API de datos abiertos del BOE). Cada pregunta y cada ficha enlazan al texto oficial `boe.es/buscar/act.php?id=…`. El formato compacto, `build.py` (que comprueba las citas literales) y las leyes están en `/mnt/project-files/aprobia/fuentes-oficiales/auxiliar-estado/`. Los slugs de los temas son `age-aux-b1-NN-…` (Bloque II: `age-aux-b2-`), así los packs y simulacros filtran por prefijo.
Los simulacros entrenan la parte 1 del ejercicio único por separado (30 Bloque I y 30 psicotécnicas, −1/3, 25 min cada uno). `config.item_types` limita los tipos de psicotécnico al formato de cada oposición.
**Publicación:** joel pidió expresamente publicarlo («súbelos y publícalos»). `supabase/preview/15-publicar-auxiliar-estado.sql` hace lo mismo que el botón de lotes, a nombre de la titular y con auditoría, y deja fuera las dudosas.
**Consecuencias:** faltan los temas 6 y 10 y el Bloque II (CNT-013). Las fichas de la AGE son artículos literales sin glosario. La pantalla de temario agrupa por «Bloque» fuera de Mossos.

## ADR-021 · Fuentes web oficiales para la ofimática y la UE (2026-11-04)

**Decisión:** el Bloque II (Windows 11 y Microsoft 365) y el tema de la UE no tienen texto en el BOE. Se usan solo páginas oficiales: soporte de Microsoft en español (support.microsoft.com/es-es y learn.microsoft.com/es-es), EUR-Lex (TUE y TFUE consolidados, DOUE C 202 de 2016) y la página de la ONU sobre los ODS. Se registran en `fuentes-web.json` y se citan literalmente, igual que las leyes (`build.py --check`).
**Límite conocido:** el contenedor no puede descargar esas webs. La herramienta de lectura solo devuelve fragmentos literales cortos, así que `web/<CLAVE>.md` guarda extractos, no la página entera. La comprobación garantiza que cada cita coincide con lo capturado, pero no sustituye a cotejarla con la página. Las preguntas que dependen de la versión, del idioma del teclado o de datos de los Tratados ya cambiados llevan nota y no se publican sin revisión.
**Consecuencias:** las preguntas de ofimática evitan los atajos con letra, que cambian con el idioma, y preguntan por cintas, menús, conceptos y teclas de función. Cuando Microsoft cambie una página, hay que capturarla de nuevo y regenerar con `build.py`.

## ADR-022 · Calibración con los exámenes reales del INAP y simulacro por partes (2026-11-04)

**Decisión:** se leyeron los exámenes de ingreso libre 2025 y 2024 en el Chrome de joel. El análisis está en `docs/research/auxiliar-estado-examenes.md`. Las psicotécnicas reales no se parecían a nuestro simulacro: había verbales (sinónimos, antónimos, ortografía), numéricas con importes (porcentajes, ecuaciones, probabilidad, series, códigos binarios) y 12 de tablas. Por eso:
(1) Se añaden 5 generadores: `percentages`, `equations`, `probability`, `codes` y `tables`. Con ellos llega la presentación `table`, opciones con coma decimal y tests con los casos del examen real.
(2) `config.item_types` admite un objeto `{tipo: cantidad}`: bloques por tipo, dificultad creciente dentro de cada bloque y orden fijo del registro, porque jsonb no conserva el orden de las claves. Sin `item_types`, los simulacros siguen con los 7 tipos generales (Mossos no cambia).
(3) Nuevo `mock_exam` con `kind: "sections"`. Recibe `config.parts` (banco por prefijo de temas o psicotécnicos generados) y `config.cutoffs`. Se abre con `mock_start_sections` y `mock_submit` guarda `part_results`: directa, corte y calificación de 0 a 50 según la fórmula del INAP. Se supera si cada parte llega a su corte.
**Consecuencias:** el pack de Auxiliar incluye el simulacro completo del ejercicio único (110 preguntas, 90 min, cortes de 2025: 29 y 21,33). Los cortes cambian cada año, así que hay que actualizarlos en el producto. Siguen pendientes las verbales, que necesitan un banco revisado con el DLE en el Chrome de joel.

## ADR-023 · Marca OPOSAPRUEBA y titulares con serifa (2026-11-04)

**Decisión:** a petición de joel, la marca pasa de «Aprobia» a **OPOSAPRUEBA** en la interfaz, los títulos, los metadatos, el manifiesto, los correos locales y la documentación activa. Se mantienen los identificadores técnicos (`package.json`, el proyecto `aprobia-preview` de Supabase, los correos `@aprobia.test`, el dominio de Vercel y las migraciones). Los titulares pasan a Source Serif 4 para un formato más serio. El diseño de ADR-018 se mantiene.
**Motivo:** joel probó una portada más interactiva y prefirió el diseño anterior; solo quería el nombre nuevo y una letra más seria.
**Consecuencias:** el nombre del remitente y las plantillas de correo de Supabase cloud se cambian en su panel, fuera del repositorio. Queda pendiente verificar el registro de marca y el dominio (DEC-005).

## ADR-024 · Portada a todo el ancho con apariciones al desplazarse (2026-11-04)

**Decisión:** a petición de joel, la web usa un contenedor ancho (`.wrap`, hasta 1600 px). La portada anima cada sección al bajar con efectos variados, inspirados en speak.com. Se usa IntersectionObserver para las apariciones y scroll-driven animations para la deriva y el crecimiento de la franja. El diseño y el contenido de ADR-018 no cambian.
**Motivo:** que la página no se vea siempre igual al recorrerla y aproveche las pantallas grandes.
**Consecuencias:** `html` y `body` llevan `overflow-x: clip` para que los efectos laterales no generen scroll horizontal. Todo queda estático con «reducir movimiento».

## ADR-025 · SEO y GEO: rastreable solo en producción y con datos oficiales verificados (2026-11-04)

**Decisión:** a petición de joel, la web se prepara para buscadores y asistentes de IA (ChatGPT, Gemini, Perplexity) sin cambiar funciones existentes:
(1) `robots.txt`, `sitemap.xml` (con hreflang es/ca) y etiquetas `robots` dependen de `isIndexable()`: solo se indexa en producción, con `https` y **sin** `PREVIEW_PASSWORD`. Mientras haya contraseña, robots.txt bloquea todo y todas las páginas son `noindex`, así que al quitarla (y redesplegar) se abre sola.
(2) Cada página pública tiene canonical, hreflang (es, ca, x-default), Open Graph e imagen para compartir. Zonas privadas, acceso, legales en borrador, búsquedas del catálogo y fichas «próximamente» sin guía son `noindex`.
(3) Guías públicas en `/oposiciones/[slug]` (Mossos y Auxiliar del Estado) y 12 páginas `/psicotecnicos/[tipo]` con entrenador gratuito, método y preguntas frecuentes. Los datos de examen salen de `docs/research/` (fuentes oficiales leídas el 03-04/11/2026) y llevan fecha de verificación y enlaces. El contenido largo vive en `src/lib/seo/*.ts` con sus dos idiomas; las etiquetas de la interfaz, en `messages`.
(4) Schema.org: EducationalOrganization, WebSite, FAQPage, BreadcrumbList, WebPage con `citation` y LearningResource/Quiz. Sin valoraciones, testimonios, precios ni cifras de alumnos.
(5) `/llms.txt` resume la academia para asistentes de IA.
(6) Analítica propia de captación: el proxy clasifica la página de entrada por origen (buscador, IA, red social, otra web, directo) y los rastreadores por User-Agent, y suma contadores diarios en `traffic_daily` con la clave de servicio (`track_traffic`, solo service_role). Sin cookies, IP ni identificadores: no requiere consentimiento. Se consulta en `/admin/trafico`.
(7) Verificación de Google Search Console y Bing por variables de entorno (`GOOGLE_SITE_VERIFICATION`, `BING_SITE_VERIFICATION`) e IndexNow (`INDEXNOW_KEY`, `/indexnow.txt`, `scripts/seo/indexnow.mjs`).
**Motivo:** aumentar la visibilidad orgánica y las opciones de aparecer como fuente citada por asistentes de IA, sin inventar nada (CONTENT_POLICY) y sin exponer la preview privada.
**Consecuencias:** al cambiar una convocatoria hay que actualizar `src/lib/seo/exam-guides.ts` y su documento de investigación. Los rastreadores de entrenamiento (GPTBot, ClaudeBot, CCBot, Google-Extended) están permitidos por la regla general: bloquearlos es una decisión de negocio pendiente de joel. Google no distingue en el origen las visitas de AI Overviews o del modo IA.

## ADR-026 · Dominio oposaprueba.com y correos con Resend (2026-11-04)

**Decisión:** joel conectó `oposaprueba.com` (Cloudflare, DNS en gris) a Vercel y cambió `NEXT_PUBLIC_SITE_URL` y las URLs de Supabase Auth. Los correos de la web (confirmación, contraseña, enlaces) saldrán de `no-responder@oposaprueba.com` mediante el SMTP de Resend (gratis hasta 3.000 al mes, región UE). Las plantillas con la marca están en `supabase/email-templates/` y se pegan en el panel de Supabase. Los enlaces usan `/auth/confirm` con `token_hash`. Para el contacto, `hola@oposaprueba.com` reenvía a un Gmail con Cloudflare Email Routing.
**Motivo:** el SMTP de serie de Supabase solo envía unos pocos correos por hora a direcciones del equipo, así que no sirve para alumnos reales.
**Consecuencias:** los correos de promoción solo se enviarán a quien lo acepte de forma explícita y siempre con enlace de baja (LSSI y RGPD). La casilla de consentimiento ya existe en _Mi perfil_ (`marketing_consent`); el envío de promociones está pendiente. Las plantillas se generan con `scripts/email/build-templates.mjs` y llevan el logo `public/brand/email-logo.png`. _Mi perfil_ permite cambiar la contraseña y el correo; ambos piden la contraseña actual y el cambio de correo se confirma por enlace.

## ADR-027 · Cobros con Stripe Checkout y webhook idempotente (2026-11-03)

**Decisión:** a petición de joel («¿puedes hacerlo tú todo?»), pagos en modo de pruebas con Stripe Checkout alojado y `price_data` (el importe sale de `product_prices`; no hay que crear productos en Stripe). El acceso lo dan el webhook firmado y la confirmación al volver de Stripe, ambos idempotentes, mediante funciones `billing_*` ejecutables solo por `service_role`. Las suscripciones se releen en Stripe en cada aviso. Portal de clientes de Stripe para tarjeta, facturas y baja. Casilla obligatoria de acceso inmediato y renuncia al desistimiento.
**Motivo:** la tarjeta nunca toca Aprobia (fuera de PCI), un único sitio donde se fija el precio (el panel) y pruebas completas sin cuenta de Stripe.
**Consecuencias:** sin `STRIPE_SECRET_KEY` todo sigue desactivado. Una clave `sk_live_` se ignora salvo `STRIPE_LIVE_ENABLED=true` (DEC-003: cobros reales solo con autorización). Las compras únicas dan acceso sin caducidad (`ends_at` nulo) mientras joel no decida otra cosa. Pasos de joel en docs/PAGOS.md.

## ADR-028 · Administrativo del Estado, Justicia y Policía Nacional con el flujo de Auxiliar (2026-11-04)

**Decisión:** a petición de joel («ves buscando temarios de otras opos, para ir preparando, verificando y publicando» y «Revisa y rellenas todas las opos posibles»), se abren tres oposiciones más con el mismo flujo que Auxiliar (ADR-020): preguntas originales con artículo y cita literal comprobada por `build.py --check`, fichas literales y publicación por SQL de la preview.
(1) **Administrativo del Estado** (BOE-A-2025-26262, Anexo III, 2.512 plazas): solo se redactan los temas propios (`age-adm-*`, bloques III-V); los temas de Auxiliar (`age-aux-*`) se enlazan a esta oposición (`exam_body_topics` y `question_exam_bodies`), porque el programa los incluye.
(2) **Auxilio Judicial y Tramitación Procesal** (Orden PJC/1549/2025, BOE-A-2025-27053): un banco común `jus-*` para las dos (`meta.also_exams`, nuevo en `to-sql`, `notes-to-sql` y `load-questions`) y `justra-24-recursos` solo para Tramitación; la ofimática de Tramitación (temas 32-37) es la de Auxiliar.
(3) **Policía Nacional, Escala Básica** (BOE-A-2026-15055): temas 1-26 (Ciencias Jurídicas) con preguntas de **3 opciones** y error −1/2, como el examen. Ciencias Sociales y Técnico-Científicas quedan pendientes hasta tener una fuente oficial citable.
**Motivo:** son las oposiciones con más aspirantes que reutilizan las leyes ya preparadas. Guardia Civil va después porque su examen de 2026 ya se hizo.
**Consecuencias:** las convocatorias se leyeron en el Chrome de joel (WebFetch corta el BOE a ~100.000 caracteres y `boe.es` no es accesible desde el contenedor). Programas literales en `docs/research/*-programa.md`; leyes y formato compacto en `/mnt/project-files/aprobia/fuentes-oficiales/{administrativo-estado,justicia,policia-nacional}/`. Los simulacros por partes admiten 9 bloques de temas como máximo.

## ADR-029 · Guardia Civil con el mismo flujo de fuentes oficiales (2026-11-05)

**Decisión:** a petición de joel («Sigue», tras «Sube todo y verifica las dudosas»), Guardia Civil (Escala de Cabos y Guardias) se prepara como las anteriores: convocatoria leída en el BOE (Resolución 160/38243/2026, BOE-A-2026-9982) y temario oficial de la web de la Guardia Civil (actualizado 2024), 25 bloques (`gc-*`) con preguntas de **4 opciones** y cita literal de 41 normas del BOE (réplica legalize-es) comprobada por `build.py --check`. Productos: pack de test, simulacro de 100 preguntas (90 min, −1/3, nota 0-100, aprobado 50) y pack completo; `33-` publica.
**Motivo:** es la oposición con más plazas pendiente (3.240) y reutiliza buena parte de las leyes ya preparadas.
**Consecuencias:** la penalización −1/3 se deduce de la fórmula oficial (variables A, E y N=4; la fórmula es una imagen en el BOE). Los temas sin norma oficial publicada (instituciones internacionales, topografía, historia, CCN-CERT, inglés y lengua) y las normas que no están en el BOE consolidado quedan fuera y se anuncian así en el pack. Las pruebas E2E de ficha «próximamente» pasan a Guardia Urbana de Barcelona.

## ADR-030 · Guardia Civil: todo el temario, también lo que no está en el BOE consolidado (2026-11-05)

**Decisión:** a petición de joel («No dejes fuera nada que pueda entrar en examen»), se cubren todos los apartados del temario oficial 2024 (PDF de la web de la Guardia Civil) con fuentes oficiales no consolidadas: BOE diario (Convención contra la tortura, Protocolo, Estatuto del Consejo de Europa, Tratado del Atlántico Norte, RD 421/2004), EUR-Lex (TUE, TFUE, Carta de Derechos Fundamentales, Directiva 2012/27/UE, Reglamento 952/2013 en los títulos que fija el temario), webs oficiales (ONU, ACNUDH, organismos internacionales, guardiacivil.es, CCN-CERT, IGN) y la RAE (DPD). Cada fuente web se guarda con texto literal en `web/CLAVE.md` + `web/CLAVE.json` y `build.py --check` comprueba las citas. 22 bloques nuevos (+430 preguntas; 928 de Guardia Civil en la BD).
**Motivo:** el examen puede preguntar cualquier apartado del temario; dejarlo fuera restaba valor al pack.
**Consecuencias:** inglés, ortografía y gramática son pruebas aparte y usan el prefijo `gcl-` (no entran en el simulacro de conocimientos `gc-`); tienen su pack y un simulacro de inglés de 20 preguntas (mínimo 8). Las preguntas de inglés no tienen norma que citar (`excerpt_status = sin_cita`); explican la regla. Avisos de vigencia en las explicaciones: la Directiva 2012/27/UE está derogada desde el 12/10/2025 por la 2023/1791, el Reglamento 952/2013 vale hasta el 20/09/2027, y de la Orden PRE/422/2013 y del RD 1649/1998 solo se pregunta lo que sigue vigente tras el RD 207/2024 y la LO 12/1995. Sin fuente oficial abierta: unidades centesimales y milésimas, y planos acotados como sistema (solo puntos acotados).

## ADR-031 · Psicotécnicos solo donde la convocatoria los incluye (2026-11-05)

**Decisión:** joel vio psicotécnicos en Auxilio Judicial, que no tiene esa prueba. La lista `examHasPsycho` (src/lib/catalog/exam-format.ts) marca las oposiciones con prueba psicotécnica oficial (Mossos, Auxiliar del Estado, Policía Nacional, Guardia Civil y policías locales). En las demás, el plan semanal pasa ese tiempo al temario y no propone sesiones ni simulacros de psicotécnicos, y la ficha de la oposición no los anuncia.
**Motivo:** no prometer ni planificar pruebas que el examen real no tiene.
**Consecuencias:** al añadir una oposición hay que decidir si va en la lista según su convocatoria. La sección general /psicotecnicos sigue abierta para todos.

## ADR-032 · Prisiones de Cataluña: oposición autonómica en catalán (2026-11-05)

**Decisión:** a petición de joel («Hazla tambn y añade la»), se añade el cos tècnic d'especialistes, escala de serveis penitenciaris de la Generalitat (C1), con la convocatoria JU033 (Resolució JUS/2335/2025, DOGC 9439) como referencia. No es Ayudantes de II.PP. del Estado: en Cataluña las prisiones están transferidas. Las preguntas y fichas se redactan en **catalán** (locale `ca`), como el examen; la cita `X:` queda literal en el idioma de la norma (castellano en el BOE, catalán en DOGC y circulares). Prefijos `pcat-` (test de coneixements, 25 temas) y `pcatsup-` (supòsit pràctic, 3 bloques de casos). 595 preguntas y 25 fichas; 4 con nota de duda quedan en borrador.
**Motivo:** el examen real es en catalán y mezcla normativa estatal (LOGP, RP, CP, LECrim) con la propia de la Generalitat (Decret 329/2006, circulares de Justícia, RisCanvi).
**Consecuencias:** dos simulacros con el formato oficial: 60 preguntas (−1/4, nota 0-15, mínimo 7,5) y 25 de supuesto (−1/4, nota 0-20, mínimo 10). No hay psicotécnico puntuable, así que no entra en `examHasPsycho`. El simulacro de 60 reparte 15 preguntas de la parte general y 45 de la específica con `config.quotas` (ADR-033). Las webs de gencat bloquean robots: se leyeron en el Chrome de joel.

## ADR-033 · Simulacros calcados a los exámenes reales: cupos por tema y cortes reales (2026-11-05)

**Decisión:** joel pidió revisar «oposición por oposición… lo que realmente ha entrado» para que los alumnos practiquen con eso. Se leyeron los exámenes oficiales publicados de cada oposición (informes en `/mnt/project-files/aprobia/examenes-reales/`) y:

- Nuevo `config.quotas` en los simulacros normales (`[{topic_prefix, questions}]`, migración `20261105000100_mock_quotas`): saca de cada tema el número de preguntas del examen real, sin repetir, y baraja el orden. Los simulacros por partes admiten hasta 60 entradas para repartir tema a tema.
- Cortes reales donde el nuestro engañaba: Policía Nacional 7 sobre 10 (corte 2026: 7,05) y Administrativo parte 1, 23 sobre 50.
- Simulacros nuevos: segunda parte de Administrativo (tipo supuesto, corte 33/50), ofimática de Tramitación (tercer ejercicio, 20 preguntas, mínimo 10) y completo de Policía Nacional (temas 1-45).
  **Motivo:** el sorteo uniforme por prefijo sobrerrepresentaba temas que apenas caen (p. ej. organización en Tramitación) y un aprobado en 5 daba falsa seguridad.
  **Consecuencias:** los repartos son la media de los exámenes publicados (en Guardia Civil y Policía Nacional, una estimación porque no se publican los cuadernillos) y hay que revisarlos con cada convocatoria. Cada cupo exige preguntas publicadas suficientes (`mock_quotas_ready`). No se reproducen los casos prácticos con enunciado común, las rejillas de ortografía de Guardia Civil ni las preguntas de reserva.

## ADR-034 · Exámenes réplica en lugar de reproducir los cuadernillos oficiales (2026-11-05)

**Decisión:** joel pidió poder practicar con «test reales de exámenes anteriores o algunos hechos pero que sean iguales». Los cuadernillos no se reproducen (el tribunal de Mossos los declara sujetos a propiedad intelectual y la regla del proyecto es redacción original): se hace una **réplica pregunta a pregunta** de cada examen oficial publicado (misma norma, mismo artículo, mismo tipo y orden, redacción y distractores propios; si la norma cambió, la versión vigente) en un tema propio (`*-examen-*`), con un simulacro que saca todas sus preguntas publicadas con el formato y los cortes reales (ajustados en proporción si alguna réplica sigue en revisión) y enlaza el examen oficial.
**Motivo:** practicar con lo mismo que cayó sin copiar texto protegido.
**Consecuencias:** cada convocatoria nueva con cuestionario publicado pide su réplica. Policía Nacional y Guardia Civil no publican cuestionarios: siguen con el simulacro por reparto. Un prefijo de tema no puede ser prefijo de otro tema que no deba entrar en el mismo cupo (por eso `jus-examen-2026-auxilio-test` y `justra-examen-2026-test`). La actualidad de Mossos (`mossos-d-actualitat`) caduca y hay que renovarla cada trimestre.

## ADR-035 · Premium por oposición, 3 temas gratis y packs de intentos (2026-11-05)

**Decisión:** joel vio que el alumno gratis no podía probar ni una pregunta de test y pidió «de cada oposición dejar 3 temas gratuitos», «solo una suscripción por oposición» y productos sueltos «rollo pack de 10 psicotécnicos» o más exámenes de una oposición concreta. Migración `20261105000200_exam_premium` (preview `47-`):

- **Premium por oposición:** una suscripción con `exam_body_id` da acceso solo a lo `included_in_premium` de esa oposición. El Premium global antiguo (`premium`, sin oposición) se archiva y deja de venderse, pero quien lo tenga conserva el acceso a todo.
- **3 temas gratis:** un pack `is_free` por oposición (`<prefijo>-temas-gratis`) con `config.topic_slugs`; `product_question_ids` reparte las preguntas publicadas de esos temas, también las que se publiquen después. Son los 3 primeros temas del programa oficial. El plan semanal los pone primero y los abre sin candado.
- **Packs de intentos:** un bundle con `config.attempts = N` (`<prefijo>-10-simulacros`, `<prefijo>-10-psicotecnicos`) da N intentos compartidos entre sus simulacros (`mock_credits_left`). Cada intento empezado cuenta; agotados, no hay acceso por esa vía. Se puede comprar otra vez y suma. No da acceso ilimitado a sus hijos como un pack normal.
- Se retiran los precios de pago único anteriores (pack completo de Mossos 59 €, àmbits 19 € y simulacros 9 €): los productos siguen existiendo como contenido del Premium.

**Motivo:** que el alumno pruebe el producto (el test con explicación y fuente) antes de pagar, y una oferta fácil de entender: una suscripción por oposición más packs sueltos de simulacros.
**Consecuencias:** precios confirmados por joel (Premium 12,99 €/mes, 10 simulacros 9,99 €, 10 de psicotécnicos 6,99 €); se cobran desde la base de datos (Checkout con `price_data`), sin crear nada en Stripe. Los psicotécnicos de práctica siguen gratis e ilimitados; lo que se vende es el simulacro con formato oficial (solo Mossos y Auxiliar lo tienen). Quien prepara dos oposiciones que comparten temario paga dos suscripciones. Un intento hecho con Premium activo también gasta intentos de un pack comprado antes.

## ADR-036 · El plan lleva directo al test del tema, calendario de estudio y adiós a «Mis productos» (2026-11-05)

**Decisión:** joel vio que, tras configurar sus horas, «Comenzar primer test» del plan le mandaba a «Mis productos». Pidió que le lleve directamente a los tests de ese tema, quitar la pestaña de productos («productos como tal no son») y un calendario en el panel con lo hecho, cuándo, cómo y lo pendiente. Migración `20261105000300_topic_practice_calendar` (preview `48-`):

- **Test por tema:** `practice_start_topic(user, tema, n)` saca preguntas publicadas del tema de entre los packs de preguntas a los que el alumno tiene acceso (`accessible_topic_questions`, que reutiliza `has_product_access`: 3 temas gratis, Premium de su oposición o pack comprado). `my_open_topics` dice qué temas puede practicar. Sin acceso, error 42501 y el plan los muestra con candado hacia la ficha de la oposición.
- **Tareas del plan:** cada tema lleva «Ficha» (si está publicada) y «Empezar test» con las preguntas que le quedan esta semana; psicotécnicos a «Práctica» y simulacros a «Simulacros». El panel ofrece la siguiente tarea sin terminar.
- **Calendario:** `my_study_log(desde, hasta)` devuelve prácticas y simulacros propios con tema y resultado. El panel muestra la semana de lunes a domingo (hora peninsular), resumen, tareas del plan pendientes y semanas anteriores (`?semana=-N`). El avance de cada tarea se calcula con lo hecho en la semana natural.
- **Sin «Mis productos»:** la pestaña pasa a ser «Simulacros» (empezar, historial y packs de intentos a la venta) y la suscripción, la gestión del pago y las compras van a «Mi perfil». `/app/productos` redirige conservando la consulta. Stripe vuelve tras pagar a la página de la zona del alumno desde la que se compró (o al perfil).

**Motivo:** el plan es el camino del alumno; tiene que llevar a estudiar, no a una tienda.
**Consecuencias:** ya no se practica un producto entero (la acción `startProductPracticeAction` desaparece; su función SQL se queda). El plan no guarda el histórico de semanas pasadas: en semanas anteriores el calendario muestra lo hecho, no lo planificado. Las condiciones de venta cambian «Mis productos» por «Mi perfil».

## ADR-037 · Medir visitas y cuentas: Vercel Web Analytics y cifras en el panel (2026-11-05)

**Decisión:** joel quiere saber cuánta gente visita la web y cuántos han entrado. Dos piezas:

- **Vercel Web Analytics** (`@vercel/analytics`, componente `WebAnalytics` en el layout): páginas vistas, visitantes, países y dispositivos en la pestaña Analytics del proyecto en Vercel. No usa cookies ni guarda la IP. Solo se carga en Vercel (`process.env.VERCEL`), no en local ni en las pruebas. `beforeSend` quita los parámetros de la URL (códigos de acceso, `next`, correos) salvo los `utm_*`. Hay que activarlo una vez en Vercel → proyecto → Analytics → Enable.
- **Panel de administración:** `admin_audience_metrics()` (SECURITY DEFINER, solo `is_admin`) devuelve agregados de hoy, 7 y 30 días: visitas de `traffic_daily` (ADR-025), registros nuevos y personas que han entrado (inicio de sesión o sesión renovada en `auth.audit_log_entries`, solo cuentas que siguen existiendo), más el total de cuentas y las confirmadas. `admin_audience_daily(días)` da la serie por día (hora de Madrid, máx. 90) para tres gráficas de barras de 30 días en el panel (`components/admin/daily-chart.tsx`, sin dependencias, con tabla accesible). Migración `20261105000400_admin_audience_metrics` (preview `49-`).

**Motivo:** el contador propio solo cuenta la página de entrada y no las navegaciones internas, y «Activos (7 días)» depende de `last_active_at`, que hoy solo actualizan los simulacros. Vercel da la cifra completa de visitas sin montar nada más, y el registro de auditoría de Auth dice quién ha entrado de verdad cada día, también quien ya tenía la sesión abierta (`last_sign_in_at` solo guarda la última vez).
**Consecuencias:** «Han entrado» cuenta a cada persona una vez por periodo (o por día en la gráfica), no cada entrada; si algún día se desactiva el registro de auditoría de Auth, esa cifra se quedará en 0. La política de privacidad y la de cookies nombran a Vercel como proveedor de la estadística de visitas sin cookies. El plan gratuito de Vercel tiene un límite mensual de eventos.

## ADR-038 · Ficha completa del alumno: accesos, regalos, códigos promocionales y uso (2026-11-06)

**Decisión:** joel quiere ver en `/admin` la información de cada alumno: qué packs y Premium tiene, asignarle packs, aplicarle códigos promocionales y ver el tiempo que está dentro, entradas y salidas y lo que va haciendo. Todo en la ficha `/admin/alumnos/[id]`, con la migración `20261106000100_admin_user_insights` (preview `50-`):

- **Accesos:** `admin_user_insights()` (SECURITY DEFINER, solo `is_admin`, auditada como `user.insights_viewed`) devuelve suscripciones, concesiones, pedidos, códigos, entradas/salidas, tiempo dentro y tests/simulacros.
- **Asignar:** un pack usa `admin_grant_access` (ya existía); un Premium por oposición usa `admin_grant_premium()`, que crea una suscripción `provider = 'none'` (así todo lo que ya mira `subscriptions` lo reconoce). `admin_end_premium()` solo termina las regaladas; las de Stripe se cancelan en Stripe.
- **Códigos promocionales:** desde la ficha se crea en Stripe un cupón (porcentaje o importe; una vez, varios meses o siempre) y un código ligado al cliente de Stripe del alumno, de un solo uso y con caducidad opcional; se apunta en `admin_promo_codes`. El Checkout pasa a `allow_promotion_codes: true` (también sirven los códigos creados en el panel de Stripe) y una compra a 0 € (`no_payment_required`) también da acceso.
- **Tiempo dentro:** `PresenceBeacon` en la zona del alumno llama cada minuto a `/api/account/presence` → `track_presence()` si la pestaña está visible y hubo actividad en los últimos 5 minutos. Se guarda solo el total diario (`user_presence_daily`), 12 meses, sin páginas, IP ni dispositivo.
- **Entradas y salidas:** del registro de Auth (`login`, `logout`, registro, recuperación…), sin IP.

**Motivo:** reutilizar lo que ya existe (concesiones, suscripciones, registro de Auth, sesiones de práctica) y medir solo lo mínimo para dar soporte y regalos (RGPD: minimización, interés legítimo informado en la política de privacidad, incluido en la exportación de datos y borrado con la cuenta).
**Consecuencias:** con Stripe en modo real, los códigos creados desde la ficha son descuentos reales. La salida no siempre aparece (cerrar la pestaña no es «Salir»). El tiempo es aproximado (minutos de uso, no de estudio; el tiempo respondiendo sale de `practice_sessions.total_time_ms`).

## ADR-039 · Cuatro oposiciones nuevas: Guardia Urbana, policía local de Cataluña, Bombers y Ayudantes IIPP (2026-11-06)

**Decisión:** joel pidió completar las cuatro oposiciones que seguían en «próximamente» leyendo sus bases y sus exámenes anteriores: temario completo con test por tema, simulacro con el formato real y psicotécnicos solo donde los haya. Para cada una: fuentes, `build.py` e `INFORME.md` en `/mnt/project-files/aprobia/fuentes-oficiales/<carpeta>/` y contenido en `content/<carpeta>` (preview `51-` a `54-`), productos en `55-` y publicación en `56-` (dudosas en borrador).

- **Guardia Urbana de Barcelona** (`gub-`, catalán): convocatoria 29/2025, 38 temas; simulacro de la parte de temario (54 preguntas, 63 min, −1/4, 0-21) y réplicas de 2025, 2023 y 2022. Psicotécnico sí (base 4.2).
- **Policía local de Cataluña** (`plcat-`, catalán): no hay convocatoria única. Temario tipo de 23 temas con lo que se repite en Terrassa, Mataró, Sabadell y Badalona sobre el marco de la Ley 16/1991 y el Decreto 233/2002; simulacro como la parte teórica de Terrassa (50, 60 min, −1/4, 0-12) y réplicas de Terrassa 2025/2026 y Badalona 2022. Psicotécnico sí (art. 18.1.a).
- **Bombers de la Generalitat** (`bomb-`, catalán): desde la 81/23 se entra como bombero/a de primera (C1); temario nuevo de 34 temas (ISP/2428/2026) con los manuales oficiales de la guía de estudio; simulacro de 70 preguntas en 80 min (−1/4, 0-8). Réplica parcial de la 81/25 (solo materias que siguen). Sin psicotécnico: la evaluación psicológica es de competencias.
- **Ayudantes de Instituciones Penitenciarias** (`iipp-`, castellano): BOE-A-2026-13226; bloques A, B y C (D, conducta humana, sin fuente oficial citable); simulacro de 120 preguntas con el reparto de 2026 (37/31/52, −1/3, corte 67 puntos directos), supuestos (`iippsup-`) y réplica del examen de 2026 (test y supuestos, cortes reales ajustados). Sin psicotécnico (base 6.3).
- Los temas réplica de estas oposiciones se llaman `<prefijo>examen-…` (sin guion intermedio): el programa de la ficha y el plan de estudio excluyen ahora cualquier slug con `examen-`.
- Modelo de venta de ADR-035 para las cuatro: Premium de la oposición, 3 primeros temas gratis y pack de 10 simulacros.

**Motivo:** que cada oposición publicada explique y practique lo que de verdad entra en su examen.
**Consecuencias:** cultura general y actualidad (Guardia Urbana, policía local), conocimiento de Barcelona, el bloque D de IIPP y las partes de desarrollo no se pueden practicar. La policía local depende de las bases de cada ayuntamiento: la ficha lo dice. Todo el contenido es redacción propia con cita literal de la fuente y lo puede revisar joel desde `/admin`.

## ADR-040 · Entrar con Google (2026-11-06)

**Decisión:** joel propuso que los alumnos puedan entrar con su cuenta de Google. Se usa el proveedor Google de Supabase Auth (OAuth con PKCE), sin librerías nuevas:

- **Botón «Continuar con Google»** en `/entrar` y `/registro` (`GoogleSignIn`, `googleSignInAction`). La acción pide a Supabase la URL de Google (`signInWithOAuth`, `skipBrowserRedirect`, `prompt=select_account`) y redirige; el verificador PKCE queda en una cookie. Google vuelve a `/auth/callback?via=google&next=…`, que canjea el código, registra `auth.sign_in` y, si la cuenta no ha hecho el onboarding, guarda el idioma con el que llegó y la manda a `/app/onboarding`.
- **El botón solo aparece si Google está activado en Supabase** (`isGoogleAuthEnabled()` lee `/auth/v1/settings`, caché 5 min, se oculta ante cualquier fallo). No hace falta variable de entorno: al activar el proveedor en Supabase aparece solo.
- **Alta:** si el correo no existe se crea la cuenta; el aviso bajo el botón dice que se aceptan condiciones y privacidad. Migración `20261106000200_google_display_name` (preview `57-`): el perfil toma `full_name`/`name` de Google si no hay `display_name`. Si el correo ya existía con contraseña, Supabase enlaza las dos identidades (el correo de Google está verificado).
- **Cuentas solo Google (sin contraseña, `hasPassword()`):** «Mi perfil» oculta cambiar contraseña y correo (se gestionan en Google) y borrar la cuenta no pide contraseña sino haber entrado hace ≤ 10 minutos (`signedInRecently()`).
- **Errores:** si el alumno cancela en Google o el código no vale, vuelve a `/entrar?error=oauth` con un aviso propio.
- Privacidad: Google como proveedor de identificación y datos que nos da (correo, nombre, enlace a la foto).
- Pila local: GoTrue con Google activado y credenciales falsas; el e2e comprueba el salto a Google, no el login completo.

**Motivo:** menos fricción en el registro (sin contraseña ni correo de confirmación) usando lo que Supabase ya trae.
**Consecuencias:** joel tiene que crear el cliente OAuth en Google Cloud y activarlo en Supabase (pasos en `docs/DEPLOYMENT.md`). La pantalla de Google muestra el dominio `tnenqdecvenfbqjgubbf.supabase.co` salvo que se contrate un dominio propio en Supabase (de pago). Para mostrar el logo en la pantalla de consentimiento Google pide verificar la marca.

## ADR-041 · Test gratis sin registro por oposición (2026-11-07)

**Decisión:** para posicionar en búsquedas genéricas como «test oposiciones Mossos», cada oposición con preguntas gratis tiene una página pública `/oposiciones/<slug>/test` (es y ca) con un test que se hace sin cuenta:

- **Qué preguntas:** solo publicadas (`status = 'published'`, `is_test = false`) de los temas gratis de la oposición (los de su pack gratuito, `config.topic_slugs`). Es contenido que ya es gratis con cuenta; no se abre nada de pago.
- **Muestra del día:** 10 preguntas ordenadas por `md5(id || fecha de Madrid)`; cambian cada día y son estables durante el día.
- **Sin solución en la página:** `exam_sample_questions` (SECURITY DEFINER, anon) devuelve enunciado, opciones, referencia, idioma y tema. `check_exam_sample_answer` corrige una pregunta de esa muestra posible y devuelve la buena y la explicación. No se guarda nada; la cuenta de aciertos vive en el navegador (como la demo de psicotécnicos).
- **SEO:** título «Test <oposición> gratis online: N preguntas con solución», Quiz/LearningResource en JSON-LD, migas, enlace desde la ficha y entrada en el sitemap (`changeFrequency: daily`). Con menos de 5 preguntas la página es `noindex` y no sale en la ficha ni en el sitemap; sin preguntas, 404.
- Al acabar invita a crear cuenta gratis (3 temas completos, progreso y repaso de fallos).

Migración `20261107000100_public_sample_test` (preview `58-`).

**Motivo:** quien busca «test <oposición>» quiere hacer un test ya; si hay que registrarse antes, Google prefiere otras páginas.
**Consecuencias:** cualquiera puede ir viendo, día a día, las preguntas de los temas gratis con su solución. Es asumible porque ya eran gratis con una cuenta.

## ADR-042 · Lo que no se podía practicar: cultura general, actualidad, Barcelona y conducta humana (2026-11-06)

**Decisión:** joel pidió preparar «algo similar o muy parecido» para lo que ADR-039 dejaba fuera. Preview `59-` a `62-`:

- **Cultura general y actualidad** (Guardia Urbana y policía local, en catalán): temas compartidos `cultcat-01` a `cultcat-09` (historia, geografía, arte, literatura, lengua, ciencias, matemáticas, instituciones y economía) y `actcat-01-actualitat` (40 hechos de los últimos 12 meses con notas de prensa oficiales). Solo fuentes oficiales (Generalitat, IEC, Idescat, Ajuntament, Moncloa, UE, ONU, UNESCO; la Fundación Nobel se anota como excepción). Packs `gub-` y `plcat-cultura-actualitat-2026` con `config.topic_slugs`.
- **Simulacros completos:** Guardia Urbana, la primera prueba entera (54 + 18 + 18, 105 min, 0-21); policía local, las dos partes de Terrassa (50 + 50, 120 min, 0-24, aprobado 12); las réplicas de Guardia Urbana y Terrassa incluyen ya la parte cultural (la actualidad antigua se cambia por un hecho reciente del mismo tipo).
- **Conocimiento de Barcelona** (`gub-t39`), Convivència consolidada y Pla d'igualtat: la réplica de 2022 queda completa.
- **Ayudantes IIPP:** bloque D con los documentos oficiales de la SGIP (Documentos Penitenciarios 16, 17 y 22 y el manual de Módulos de Respeto), simulacro de test con el reparto real 37/31/48/4, supuestos ampliados a 60 con simulacro de 40 (corte 26,67) y réplica de 2026 con las 123 preguntas.

**Motivo:** que el alumno practique todas las partes tipo test de su examen.
**Consecuencias:** `actcat-01-actualitat` caduca: hay que renovarlo cada trimestre (como `mossos-d`). Las preguntas que sustituyen un concepto sin fuente oficial llevan nota y quedan en borrador. La réplica de 2025 de IIPP queda pendiente porque el cuadernillo oficial es un PDF escaneado.

## ADR-043 · Psicotécnicos verbales de la AGE: sinónimos, antónimos y ortografía desde el DLE (2026-11-06)

**Decisión:** tres generadores nuevos (`spelling`, `synonyms`, `antonyms`, en `src/lib/learning/psycho/verbal.ts`) sobre un banco comprobado en dle.rae.es desde el Chrome de joel (`verbal-bank.ts`): 171 entradas con sus listas de sinónimos y antónimos del DLE y 70 pares de ortografía (cada forma correcta existe en el DLE y cada errónea da «no está en el Diccionario»).

- La respuesta es uno de los primeros sinónimos/antónimos del DLE (sentido principal; más hondos con la dificultad). Los distractores no tienen relación en el DLE con la palabra ni con sus sinónimos/antónimos; como en el examen, uno es del sentido contrario. Al corregir se comprueba que solo la respuesta está en la lista del DLE.
- Lista de exclusión para acepciones raras o regionales (p. ej. «manso» → «finca») y palabras de los exámenes reales del INAP fuera del banco.
- El simulacro de psicotécnicos de la AGE pasa al reparto real: ortografía 3, sinónimos 3, antónimos 3, series 2, porcentajes 3, ecuaciones 2, probabilidad 1, codificación 1 y tablas 12 (preview `63-`). El simulacro completo y las réplicas siguen con las 8 verbales del tema `age-aux-psicotecnicos-verbales` (ADR de las réplicas).
- Guías públicas `/psicotecnicos/ortografia`, `/sinonimos` y `/antonimos`. En catalán el enunciado se traduce y las palabras siguen en castellano (el examen es en castellano).

**Motivo:** cubrir las ~9 de 30 psicotécnicas verbales del examen real con variedad ilimitada y sin inventar: todo sale del diccionario de la RAE.
**Consecuencias:** el banco es estático; ampliarlo exige volver a consultar el DLE. Las preguntas de uso (sino/si no, DPD) siguen solo en el tema de preguntas fijas.

## ADR-044 · Conversión: registro con la oposición elegida y test gratis que engancha (2026-11-09)

**Decisión:** tras la auditoría del 9/11/2026 (959 visitas y 8 registros en 6 días), cambios pequeños en el embudo:

- `src/proxy.ts`: sin sesión, `/app/onboarding` lleva a `/registro` (no a `/entrar`) y el `next` conserva la consulta (`?exam=`). `/registro` acepta `?exam=` o lo saca de `next` (`examFromNext`) y lo pasa al formulario y a Google; tras confirmar el correo se llega al onboarding con la oposición elegida. Los «Crear cuenta» de la ficha y del test gratis usan `signUpPath(slug)`. Solo se aceptan slugs `[a-z0-9-]` y el destino pasa por `safeNextPath`.
- Test gratis: al terminar muestra la nota sobre 10 y el repaso de las preguntas falladas (tu respuesta, la correcta, explicación y referencia), sin pedir nada más al servidor.
- Portada: bloque «Haz un test gratis de tu oposición» con todas las oposiciones disponibles.
- Ficha: la oferta (gratis, Premium y packs) va justo después de «Cómo es el examen» (`#oferta`), el temario va plegado y en móvil hay una barra fija con «Test gratis» y «Ver precios».
- /admin: «Han entrado» contaba solo `auth.audit_log_entries`, que en Supabase Cloud llegaba vacío. Ahora une auditoría, `last_sign_in_at`, el latido (`user_presence_daily`) y `activity_events` (`admin_login_days`, preview `64-`). Se quita el aviso «se activarán con Stripe (Hito 5)».
- `/otros` (indexada por Google, daba 404) redirige a `/oposiciones`.

**Motivo:** el botón principal de la ficha mandaba al visitante nuevo a «Entrar» y perdía la oposición; el test gratis acababa sin nada que enganchara; la oferta estaba al final de una ficha de ~7 pantallas en móvil.
**Consecuencias:** quien ya tiene cuenta y pulsa «Preparar esta oposición» sin sesión ve «Crear cuenta» con el enlace «Entra», que conserva el destino. Medir el registro (objetivo 3 %) con UTM en redes antes de cambiar más.

## ADR-045 · Test por tema sin repeticiones (2026-11-10)

**Decisión:** una alumna de Prisiones de Cataluña se quejó (vía joel) de que el test de un tema repetía siempre las mismas preguntas. `practice_start_topic` ya sorteaba, pero con unas 20 preguntas por tema dos tests de 10 compartían la mitad. Ahora ordena: 1) las que el alumno nunca ha respondido; 2) las que falló la última vez; 3) el resto, por la que respondió hace más tiempo; al azar dentro de cada grupo. Las preguntas de un test que se deja a medias y no se contestan siguen contando como nuevas.
**Motivo:** que cada test aporte preguntas nuevas hasta agotar el tema y que los fallos vuelvan antes que los aciertos.
**Consecuencias:** índice nuevo `practice_items (user_id, question_id)`. No sustituye a tener más preguntas por tema: con 20, al tercer test ya se repiten. Por eso Prisiones de Cataluña pasa a 50 preguntas por tema (+730, preview `66-` y `67-`): cinco tests de 10 seguidos no repiten ninguna.

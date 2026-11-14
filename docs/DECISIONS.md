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

## ADR-046 · Apuntes por tema y tests de tema en tandas de 10 (2026-11-10)

**Decisión:** joel pidió que quien va directo a los test tenga de dónde estudiar y que el test de un tema salga siempre de 10, con «otras 10» hasta dominarlo.

- `topic_notes.lessons` (jsonb): apuntes por apartados del epígrafe oficial. Cada párrafo es texto propio y lleva al menos una cita literal de la norma (`ref`, `law`, `url`, `quote`), comprobada por `build.py` contra el texto oficial. Se muestran en la ficha del tema, antes del resumen.
- Muro de pago por columna: `authenticated` ya no puede leer `lessons` directamente; solo `topic_lessons(slug)` (SECURITY DEFINER), que los devuelve al personal o a quien puede practicar el tema (`accessible_topic_questions`). Los gratuitos ven los apuntes de los 3 primeros temas.
- El cambio de `lessons` cuenta como cambio de contenido en `tg_topic_note_guard` (vuelve a revisión).
- Plan semanal: el test de tema pide como mucho 10 preguntas (`TOPIC_BATCH`); antes pedía todo lo que quedaba de la cuota (hasta 40).
- Resultado de un test de un solo tema (`my_session_topic`): progreso en el tema (respondidas, % de acierto, publicadas), objetivo de dominio (15 respuestas y 70 %, `TOPIC_DONE`), botón «Otras 10 preguntas de este tema» y enlace a los apuntes.
- Prisiones de Cataluña: apuntes de los 25 temas en catalán (preview `70-`, que vuelve a publicar las fichas como titular). Formato fuente en `fuente-apunts/*.txt` (ver APUNTS.md en la carpeta de fuentes).
- Cultura general y actualidad de Cataluña (bloque compartido de Policía local de Cataluña y Guardia Urbana de Barcelona, 2026-11-11): apuntes de los 10 temas `cultcat-01…09` y `actcat-01` en catalán (preview `81-`). Fuentes solo las oficiales ya cargadas en `cultura-cat/web/` (DIEC, Generalitat, Ajuntament, Idescat, BOE, UE, ONU, UNESCO…), sin red para añadir más: C05 (literatura) queda en ~1.300 palabras en vez de 1.500 para no inventar; huecos en `cultura-cat/fuente-apunts/DUBTES-*.md`. Son temas de pago (pack de cultura y actualidad): ningún alumno gratuito ve estos apuntes. A01 caduca: revisar cada trimestre.
- Auxiliar Administrativo del Estado (2026-11-11): apuntes de los 29 temas con ficha (16 del Bloque I, 12 del Bloque II y psicotécnicos verbales), en castellano, con citas del BOE consolidado y de las fuentes web oficiales de la carpeta (Microsoft, EUR-Lex, INCIBE, RAE). Preview `72-`. Formato en `APUNTES.md` de `fuentes-oficiales/auxiliar-estado/`; huecos de fuentes en `DUDAS-APUNTES.md` de esa carpeta.
- Policía local de Cataluña (2026-11-11): apuntes de los 23 temas tipo (`plcat-t01` … `t23`) en catalán, preview `78-`. Las réplicas de examen no tienen ficha ni apuntes. Huecos y normas desactualizadas señalados en el propio texto (Decret 179/2015, LO 9/1983 y LO 4/1981 no están en las fuentes; Llei 4/2003, 16/1991 y 19/2020 marcadas «Desactualizado» en el BOE).
- Ayudantes de Instituciones Penitenciarias (2026-11-11): apuntes de los 50 temas con ficha (A01-A17, B01-B10, C01-C20, D01-D03) en castellano, unas 91.000 palabras, preview `73-`. Formato en `fuentes-oficiales/ayudantes-iipp/APUNTES.md`; huecos de fuentes en `INFORME-APUNTES.md` de esa carpeta (p. ej. Tratados de la UE, LOTC, RD 33/1986, Reglamento de extranjería, contabilidad de los centros y gran parte del bloque D de conducta humana). Se corrigieron dos referencias de ficha (C03: deberes en el art. 4 LOGP; C17: art. 278.3 RP).
- Bombers de la Generalitat (2026-11-11): apuntes de los 34 temas en catalán (preview `74-`, filtra `bomb-t%`). Temas 1-6 con las leyes completas (unas 2.200 palabras); temas 7-34 solo con los extractos de los manuales oficiales que hay en la carpeta (800-1.600 palabras), sin rellenar: cada hueco del epígrafe se dice en el texto y remite al manual. Ampliación (2026-11-11, preview `83-`): joel pidió leer los PDF completos en su Chrome; el texto de los 27 manuales se añadió a `web/MANxx.md` (y el D276 consolidado) y los temas 7-34 se reescribieron con 1.500-2.200 palabras, misma regla de cita literal. Lo que en el PDF es imagen (fórmulas, tablas de valores) no se cita y se dice en el texto; dudas en `bombers/DUDAS-APUNTES.md`.
- Policía Nacional, Escala Básica: apuntes de los 45 temas (P01-P45) en castellano (preview `79-`, filtro `pn-%`). build.py de la carpeta lleva el mismo `parse_lessons`. Huecos de fuentes (RD 2/2006, RD 67/2010, Reglamento de extranjería y de Seguridad Privada, teoría de Ciencias Sociales, partes de gramática y redes) se dicen en el texto y están en `DUDAS-APUNTES.md` de la carpeta de fuentes.
- Justicia (Auxilio Judicial y Tramitación Procesal, 2026-11-11): apuntes de los 35 temas con ficha (J01-J35: los 26 comunes `jus-*` y los 9 solo de Tramitación `justra-*`) en castellano, preview `77-`. Mismo formato; `build.py` de la carpeta `justicia` comprueba cada cita y ahora quita también los asteriscos sueltos del markdown al comparar. Las denominaciones antiguas que la LEC, la LECrim, la LJCA, la LRJS y otras aún no han adaptado a la LO 1/2025 se avisan en el propio texto. Huecos de fuentes (p. ej. Tribunal de Cuentas europeo, Secretaría de Estado de Justicia, Código de Conducta informático) quedan para revisión de joel.
- Mossos d'Esquadra (2026-11-11): apuntes de los 21 temas (A.1–C.5 y D) en catalán (preview `80-`). Aquí la fuente de cada cita es la Guia d'estudi de junio de 2026 (la referencia del examen), sus esmenes de septiembre o, en D, las notas de prensa del Govern; `contenido-mossos/build.py` comprueba que cada cita es literal, calcula su página y solo reescribe el campo `lessons` de las fichas. Dudas de fuentes en `contenido-mossos/DUDAS-APUNTS.md`.
- Administrativo del Estado (2026-11-11): apuntes de los 26 temas propios (`age-adm-*`) en castellano, preview `71-`. Los temas comunes con Auxiliar (`age-aux-*`, entre ellos los 3 gratuitos) reciben sus apuntes con la preview `72-` de Auxiliar (PR #42): con las dos fusionadas, un alumno gratis de Administrativo ve los apuntes de sus 3 temas gratis.
- Guardia Civil (2026-11-11): apuntes de los 42 temas con ficha en castellano (`gc-*` y `gcl-*`, ~75.800 palabras; G24 inglés no tiene ficha), preview `75-`. Formato en `fuentes-oficiales/guardia-civil/APUNTES.md`; las normas desfasadas se avisan con «Ojo» en el texto.
- Guardia Urbana de Barcelona (2026-11-11): apuntes de los 39 temas (T01-T39) en catalán, preview `76-` (vuelve a publicar las fichas `gub-t*` como titular). Dudas de fuentes en `DUDAS-APUNTS.md` de la carpeta de fuentes.

**Motivo:** estudiar sin temario era el bloqueo principal; los tests de 40 cansaban y no daban sensación de avance.
**Consecuencias:** migración `20261110000200` y preview `69-`. Los apuntes de otras oposiciones se pueden añadir con el mismo formato. Huecos de fuentes señalados en el texto (p. ej. seguridad estática y dinámica en E14) quedan para revisión de joel.

## ADR-047 · Embudo de conversión en el panel (2026-11-11)

**Decisión:** la auditoría (ADR-044, punto 5) pedía ver dónde se pierde la gente. El panel `/admin` tiene ahora una sección «Embudo de conversión» con 7 pasos y periodo de 7 o 30 días (`?embudo=7|30`):

1. Visitas (`traffic_daily`, sin robots).
2. Empiezan el test gratis y 3. lo terminan: tabla nueva `funnel_daily (day, step, exam, hits)`, solo contadores diarios por oposición, sin IP, cookies ni usuario (como ADR-025, sin consentimiento). La escribe `track_funnel()` (solo `service_role`) desde la acción `trackSampleStepAction`, con límite de 40 pasos por IP cada 10 minutos. El reproductor la llama al responder la primera pregunta y al ver el resultado.
3. Crean cuenta, 5. completan la bienvenida, 6. practican (sesión con alguna respuesta o simulacro) y 7. pagan (pedido pagado o suscripción con `provider = 'stripe'`; los regalos `none` no cuentan). Los pasos 4–7 son de la cohorte de cuentas creadas en el periodo, para que los porcentajes no pasen del 100 %.

Cada paso muestra el % respecto al anterior, salvo «Crean cuenta», que se compara con las visitas porque registrarse no exige el test. Se marca la mayor caída y se listan las 10 oposiciones con más tests gratis. `admin_funnel(p_days)` es SECURITY DEFINER con `is_admin()`.

**Motivo:** saber qué paso mejorar primero con datos y no a ojo.
**Consecuencias:** migración `20261111000100` y preview `83-`. El test gratis solo se cuenta desde el despliegue; antes sale 0 (se avisa en el panel). Con varias instancias el límite por IP es por instancia (SEC-004).

## ADR-048 · Mejoras de la oferta por oposición (2026-11-11)

**Decisión:** tras revisar qué es gratis y qué de pago en cada oposición, joel aprobó:

1. **Simulacro de psicotécnicos y pack de 10 (6,99 €)** también en Guardia Civil, Policía Nacional, Guardia Urbana y Policía local (lista `examHasPsychoMock`). Guardia Civil con el formato oficial (BOE-A-2026-9982, bases 7.3 y 7.6: 80 preguntas, 55 min, 0–30, mínimo 12, error −1/3). Las otras tres no publican preguntas ni tiempo: **formato orientativo** (60 ejercicios, 30 min, sin penalización; Guardia Urbana puntúa 0–21 con mínimo 10,50 por la base 4.2), con `config.orientative` y aviso en la ficha. Bombers no: su base 6.1.4 es una evaluación de competencias, no un test de aptitudes (ADR-031). Los de GC y PN entran también en su pack completo.
2. **Plan anual de Premium: 79,99 € al año** (6,67 €/mes, un 49 % menos que 12 meses). `product_prices` con `billing_interval = 'year'`; `exam_offer` devuelve `premium.price` (mensual) y `premium.price_year`; la compra lleva `interval` (`month` por defecto) y la ficha y «Mi perfil» dejan elegir.
3. **Primer simulacro gratis por oposición:** `mock_trial_available(producto, alumno)` y `has_product_access` lo abren si el alumno no ha hecho ningún simulacro de esa oposición (o si es el que tiene en curso, para retomarlo). `my_library` lo lista con `source = 'trial'` y «Simulacros» lo explica.
4. **Packs de 10 simulacros solo con simulacros que cambian:** se quitan las réplicas de exámenes (`slug` con `-examen-`), que repiten siempre las mismas preguntas, siempre que el pack conserve otro simulacro. Las réplicas siguen en Premium.
5. **Fichas:** `exam_offer` no cuenta como temas los exámenes réplica (Administrativo decía 58 temas y son 54; Mossos 23 y 21). Mossos avisa de que la primera prueba de la 46/26 ya se hizo y que se prepara la próxima convocatoria.

Más preguntas y simulacros (réplicas oficiales de PN y GC, examen de Bombers 2025 completo, ~40 preguntas por tema en Bombers, Policía local y Auxiliar) van en hilos de contenido aparte, con preview desde `85-`.

**Motivo:** las oposiciones policiales tienen un psicotécnico eliminatorio sin simulacro; quien prepara un año pagaba más aquí que en la competencia (OpositaTest anual 7,99 €/mes); ver la nota de un simulacro es lo que más engancha; un pack de 10 intentos de una réplica fija no tenía sentido.
**Consecuencias:** migración `20261111000200`, preview `84-`. Quien ya tuviera un pack de 10 simulacros pierde con él el acceso a las réplicas (se comprueba en /admin antes de fusionar). El precio anual se cobra desde la BD como el mensual (price_data); se cambia en /admin/productos.

## ADR-049 · Simulacros de examen de Guardia Civil y Policía Nacional (2026-11-11)

**Decisión:** joel aprobó «más simulacros» en Policía Nacional y Guardia Civil (ADR-048: «solo tenemos que generar preguntas y simulacros nosotros. dale adelante»).

- **Guardia Civil sí publica sus cuadernillos** (ADR-034 decía lo contrario): la Jefatura de Enseñanza tiene en web.guardiacivil.es el de 2026 (modelos A y B, con plantilla definitiva) y los tres ejercicios de 2022; el de 2025 ya da 404. Se hace una **réplica pregunta a pregunta** de los cuatro, como en ADR-034: misma norma, mismo artículo y mismo tipo, redacción propia y la versión vigente de la norma. Temas `gcexamen-2026`, `gcexamen-2022-1/2/3` (sin `gc-` delante para no entrar en el simulacro por reparto); mapas sin enunciados en `fuentes-oficiales/guardia-civil/replicas/`. Las preguntas de 2022 de materias que ya no están en el temario de 2024 (historia general, literatura, ciencias, estadística) se cambian por el punto más cercano del temario actual. Un script compara cada réplica con el cuadernillo: ninguna línea comparte frases que no vengan de la propia norma.
- **Policía Nacional no publica cuestionarios**: 2 **exámenes tipo** de 100 preguntas NUEVAS (no repiten las del banco ni entre sí) con el formato real (3 opciones, −1/2, 50 min) y el reparto del temario: 2 por tema y 3 en los 10 de más peso. Temas `pnexamen-tipo-1/2`. Se anuncian como no oficiales.
- Productos `gc-simulacro-examen-2026`, `gc-simulacro-examen-2022-1/2/3` (90 min, −1/3, 0-100, aprobado 50) y `pn-simulacro-examen-tipo-1/2` (50 min, −1/2, 0-10, aprobado 7), con todas las preguntas publicadas de su tema. Entran en el Premium; no en el pack de 10 simulacros, porque son fijos (ADR-048, punto 4).

**Motivo:** las dos oposiciones con más demanda tenían 2 simulacros por reparto y ningún examen real.
**Consecuencias:** preview `87-` (preguntas) y `88-` (publicación y productos). Siguen en borrador 7 dudosas: GC 2026 n.º 72-73 (la Orden PRE/422/2013 de la carpeta no tiene la estructura de Servicios Centrales que da por supuesta el cuadernillo), 2022-2 n.º 85-86 y 2022-3 n.º 83-84 (Directiva 2012/27/UE, derogada por la 2023/1791 y aún en el temario) y PN tipo 2 n.º 77 (dato de la encuesta EDADES). Cada convocatoria nueva de Guardia Civil pide su réplica (el cuadernillo se publica tras la prueba).

## ADR-050 · Más alcance en buscadores: enlaces internos, ejemplos resueltos e IndexNow automático (2026-11-10)

**Contexto.** A los 6 días de abrir la web, Search Console marcaba 21 apariciones y 2 visitas en 28 días, de media en la 3.ª página. Las búsquedas que ya asoman son de psicotécnicos («test psicotécnicos gratis», «psicotécnicos online»). Auditoría de las 58 URL del sitemap: títulos, descripciones y h1 correctos, pero las fichas de oposición solo recibían 12 enlaces internos, las páginas de psicotécnico tenían 220-370 palabras y Bing seguía sin alta (IndexNow dependía de una variable en Vercel).

**Decisión.**

- El pie de todas las páginas enlaza las 11 fichas de oposición y los 15 tipos de psicotécnico (nombre corto con `examShortName`, sacado del h1 verificado).
- Cada página `/psicotecnicos/<tipo>` muestra tres **ejemplos resueltos** con semillas fijas (contenido estable en el HTML) generados por el mismo motor determinista: enunciado, opciones, solución y explicación. Son ítems distintos de los del entrenador, que siguen sin enviar la solución al cliente.
- Títulos de los tipos con «gratis» (lo que se busca), sin pasar de ~60 caracteres.
- «Oposiciones en las que se trabaja» usa el nombre de cada oposición; antes mostraba el slug en 9 de 11.
- IndexNow sin depender de Vercel: clave pública por defecto en `/indexnow.txt` y GitHub Action `indexnow.yml` que envía el sitemap tras cada push a `main` (espera 4 min al despliegue).

**Consecuencias.** Bing, Yandex y Seznam reciben las URL en cada publicación sin pasos manuales. No se añade ningún dato de examen nuevo: solo se reutiliza contenido verificado y ejercicios generados.

## ADR-051 · Fichas con oferta siempre visible: mock_pool rápido y arreglos de la auditoría del 12/11 (2026-11-12)

**Contexto.** Auditoría del 12/11/2026 en producción: sin sesión, 11 de las 12 fichas de oposición salían **sin «Qué incluye» ni precios** y tardaban 3,6-4,2 s; con sesión, 5-9 s, y Mi panel, Mi plan, Simulacros y Perfil 7-8 s. Reproducido en local con todo el contenido de la preview (13.138 preguntas): `exam_offer` tardaba 3-3,7 s, por encima del `statement_timeout` del rol `anon` en Supabase (3 s), y `examOffer` ignoraba el error. La causa era `mock_pool`: calculaba `mock_config(p.config)` dentro del JOIN y Postgres la reevaluaba por cada tema y pregunta candidata (un simulacro de 920 preguntas, 1,5 s). `exam_offer` y `my_library` cuentan las preguntas de cada producto con `product_question_ids`, que llama a `mock_pool`.

**Decisión.**

- `mock_pool` calcula la configuración una vez en CTE materializadas (migración `20261112000100`, preview `89-`). Resultado idéntico al anterior, comprobado producto a producto (13.717 filas). `exam_offer` pasa de ~3,5 s a ~20 ms y `my_library` de 2,7 s a ~70 ms; también se aceleran `mock_start` y el resto de usos.
- `examOffer` registra en los logs el error de la RPC (antes la ficha salía sin oferta en silencio).
- Ficha de Guardia Civil: ya no dice que no se publican los cuestionarios (hay réplicas de los cuadernillos de 2026 y 2022 desde ADR-049); se añade el cuadernillo de 2026 a las fuentes.
- Catálogo: el filtro solo ofrece categorías con alguna oposición publicada.
- Títulos y descripciones más cortos en el test gratis, la portada, el catálogo y psicotécnicos (que pasa a decir 15 tipos).

**Consecuencias.** La oferta vuelve a verse sin cuenta. No se cachean todavía las fichas (siguen siendo dinámicas); si vuelven a crecer los tiempos, el siguiente paso es guardar los recuentos por producto.

## ADR-052 · Guía de la prueba física con baremos oficiales y calculadora (2026-11-12)

**Contexto.** Mossos 46/26 publica los resultados de la 1.ª prueba el 17/11/2026 y hace la prueba física del 23/11 al 21/12. Es lo que buscarán miles de aspirantes esas semanas, y la web no tenía nada sobre ella (pendiente 3 de Mossos desde el 3/11).

**Decisión.**

- Página `/oposiciones/<slug>/prueba-fisica` (es/ca) solo para las oposiciones con guía en `src/lib/seo/physical-tests.ts`. Primera: Mossos, con la base 6.1.2 y el anexo 2 de la Resolución ISP/1763/2026 leídos en el DOGC el 12/11/2026 (copia en `fuentes-oficiales/mossos-prova-fisica-46-26.md`).
- Ejercicios, normas, intentos, baremos de hombres y mujeres tal cual, cómo se puntúa, qué viene después, FAQ (JSON-LD) y fuentes.
- Calculadora en cliente (`physicalScore`): puntos por ejercicio, media de los tres (33,33 % cada uno), mínimo 1 por ejercicio y 5 en total. Una marca entre dos filas se queda con la fila alcanzada; los «<» y «>» de la fila 10 son estrictos. Se avisa de que es orientativa.
- Enlace desde la ficha y entrada en el sitemap. Sin plan de entrenamiento: no hay fuente oficial para eso.

**Consecuencias.** Añadir otra oposición (Bombers, Guardia Urbana, PN, GC) es añadir su guía al módulo con datos verificados de sus bases.

## ADR-053 · Servidor de Vercel en Fráncfort y carga instantánea en la zona del alumno (2026-11-13)

**Contexto.** joel nota que algunos enlaces tardan. Medido el 13/11/2026 desde su navegador (Barcelona) en www.oposaprueba.com: páginas públicas 0,5-1 s (incluso `/legal/privacidad` o `/entrar`, que casi no consultan nada) y zona del alumno 0,7-1,8 s (Mi panel 1,75 s). La cabecera `x-vercel-id` (`cdg1::iad1::…`) muestra que las funciones de Vercel se ejecutan en **iad1 (Washington, EE. UU.)**, la región por defecto, mientras que Supabase está en **Fráncfort**. Cada consulta cruza el Atlántico dos veces (~90 ms ida y vuelta) y una página hace varias en serie: `getUser()` en el proxy, `getUser()` + perfil en la cabecera, y las de la página. Además, en `/app` solo Mi panel tenía `loading.tsx`: al pulsar Mi plan, Simulacros, Progreso, etc., la pantalla no reaccionaba hasta tener la página entera.

**Decisión.**

- `vercel.json` fija `"regions": ["fra1"]` (Fráncfort, junto a Supabase). Es una sola región (válido en el plan Hobby).
- `loading.tsx` genérico (`PageLoading`) en Mi plan, Temario, Práctica, Simulacros, Progreso, Perfil y Productos (y en Tráfico, Revisión y Compras de `/admin`): al pulsar el menú se ve el esqueleto al instante (el layout compartido ya está pintado). Mi panel conserva el suyo.
- Nunca por encima de una página que llame a `notFound()`: el esqueleto empieza a enviar la respuesta y el 404 pasaría a ser 200 (lo comprueba `practice.spec.ts`: la sesión de otra persona debe dar 404). Por eso las portadas de Temario, Práctica y Simulacros pasan a un grupo `(index)/` con su `loading.tsx`, y `[slug]`/`[id]` quedan fuera. Por lo mismo, tampoco en las páginas públicas (las fichas inexistentes deben seguir dando 404).

**Consecuencias.** Tras desplegar, `x-vercel-id` debe acabar en `::fra1::`. Si Supabase estuviera en otra región, cambiar `fra1` por la más cercana. Siguiente paso posible (PERF-001): sacar la sesión de la cabecera para que las páginas públicas puedan ser estáticas o cacheadas.

## ADR-054 · Programa de embajadoras: enlace propio y registros atribuidos sin cookies (2026-11-13)

**Contexto.** Casi todas las opositoras con seguidores en Instagram y TikTok llevan un código de afiliada de OpositaTest. joel aprobó el 13/11/2026 un programa de embajadoras con la opción A: la embajadora recibe gratis el Premium de su oposición (se regala a mano desde la ficha del alumno, 90 días renovables) a cambio de una mención al mes con su enlace; sin comisión de momento. Hacía falta saber cuántos registros trae cada una: /admin contaba visitas por origen, pero no de dónde venía cada cuenta.

**Decisión.**

- Tablas `ambassadors` (código único `^[a-z0-9-]{2,32}$`, nombre, red, cuenta, oposición, notas, activa), `ambassador_visits_daily` (contador diario agregado, como `traffic_daily`) y `ambassador_referrals` (cuenta → embajadora, se borra con la cuenta). RLS: solo admin lee; nadie escribe atribuciones directamente.
- Enlace `oposaprueba.com/r/<código>` (y `/ca/r/<código>`): lo resuelve el proxy, suma la visita con service_role (`track_ambassador_visit`, solo si el proxy la clasifica como visita, no las vistas previas de las redes) y redirige a `/registro?ref=<código>`. **Sin cookies**: el código viaja en la URL y en el formulario, así no hace falta banner de consentimiento.
- Registro: campo opcional «Código de invitación» (plegado, abierto si llega `?ref=`), útil también para quien lo ve en un reel y lo escribe a mano. Alta por correo: el código va en los metadatos y `handle_new_user` lo apunta con `record_referral`. Con Google: va en la URL de vuelta y `/auth/callback` llama a `claim_referral`, que solo vale para cuentas de menos de 24 h. Un código inexistente o pausado se ignora sin romper el alta.
- `/admin/embajadoras`: alta, pausar/reactivar y, por embajadora, visitas, registros y alumnos con Premium cobrado (Stripe; los regalados no cuentan), últimos 30 días / total (`admin_ambassador_stats`).
- Política de privacidad: se informa de que se guarda el código usado.

**Consecuencias.** Si más adelante se paga comisión (opción B), las altas de pago por embajadora ya se cuentan; faltaría el importe. El Premium de la embajadora sigue siendo manual («Regalar Premium»).

## ADR-055 · Tutorial de bienvenida la primera vez y vídeos cortos de ayuda (2026-11-13)

**Contexto.** joel quiere que quien entra por primera vez tenga un tutorial de uso, que «Cómo funciona» resuelva dudas con vídeos y que cada oposición tenga un vídeo con lo suyo (la academia es común, pero cada examen tiene sus cosas).

**Decisión.**

- **Tutorial** (`components/welcome-tour.tsx`): 8 pasos en Mi panel que resaltan cada sección del menú del alumno (`data-tour` en `AppNav`), con «Ahora no», Atrás/Siguiente, Escape y foco atrapado en el diálogo. Sale solo si `profiles.tour_completed_at` es null; al terminarlo o cerrarlo se llama a `complete_welcome_tour()` (SECURITY DEFINER, solo el perfil de `auth.uid()`; la columna no se puede escribir por la API). Se guarda en la BD, no en el navegador, para que no reaparezca en otro dispositivo. Los perfiles anteriores a la migración se marcan como vistos. «Mi perfil → Ver el tutorial otra vez» abre `/app?tutorial=1` sin guardar nada. Si la columna aún no existe (código antes que SQL), no se enseña.
- **Vídeos** (`lib/help/videos.ts`, `components/help`): verticales 720 × 1280 en `public/videos/ayuda/` (~1 MB cada uno, H.264 + AAC, `faststart`). Hasta que se pulsa solo se carga la portada. Cada vídeo lleva subtítulos incrustados y transcripción desplegable; en catalán se avisa de que el vídeo está en castellano.
  - Portada, sección «Cómo funciona»: 6 dudas comunes reutilizando vídeos ya aprobados por joel para redes (03, 04, 05, 06, 12 y 20).
  - Ficha de cada oposición con guía (11): vídeo nuevo de ~23 s con la voz de siempre (ElevenLabs «Sofia», eleven_v4, una toma, ~4.000 créditos en total) y datos tomados solo de `lib/seo/exam-guides.ts` (bases oficiales verificadas). Motor: `TIKTOK_OPOSAPRUEBA/_motor/motor-videos-5.tar.gz` (`video4.html?v=<slug>`, `build4.sh`).
  - Las 4 oposiciones catalanas (Mossos, Guardia Urbana, policía local, Bombers) van narradas en catalán por petición de joel (13/11): voz ElevenLabs «Ona - Atenció al Client Català Fluid», textos en pantalla en catalán (`v=<slug>-ca`). `HelpVideo.lang` marca el idioma; la ficha avisa «Vídeo en catalán» en es y «Vídeo en castellà» en ca cuando no coincide con el de la página.

**Consecuencias.** Si cambia una convocatoria, además de la guía hay que rehacer su vídeo (guion en `videos.ts`). Las fichas sin guía (Prisiones de Cataluña, Correos) no tienen vídeo todavía. El repositorio crece ~20 MB por los vídeos; si hicieran falta muchos más, moverlos a un almacenamiento externo (requiere autorización de joel).

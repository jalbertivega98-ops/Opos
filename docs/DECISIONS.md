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


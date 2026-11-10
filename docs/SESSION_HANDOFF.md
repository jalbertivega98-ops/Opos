# SESSION HANDOFF

**Última actualización:** 2026-11-07 · Sesión 3 (+ test gratis sin registro ADR-041) (+ entrar con Google ADR-040) (+ exámenes reales ADR-033 y Prisiones de Cataluña ADR-032)

## Estado exacto

- **Test por tema sin repeticiones (2026-11-10, LRN-006, ADR-045):** primero preguntas no respondidas, luego falladas. Migración `20261110000100` y preview `65-`. Prisiones de Cataluña ampliada a 50 preguntas por tema (+730; preview `66-` temario y `67-` publicación, que también las mete en el pack de test); 19 dudosas con N: en borrador.

### Conversión tras la auditoría (2026-11-09, rama `claude/project-thread-3xoxnz`, MKT-005, ADR-044)

- Auditoría completa en el Claude Doc «Auditoría OPOSAPRUEBA · noviembre 2026» (plan de 23 mejoras). Hechos los puntos 1–8: registro con la oposición elegida, repaso de fallos del test gratis, tests gratis en la portada, oferta arriba y barra fija en fichas, «Han entrado» con varias fuentes (preview `64-`), redirección de /otros.
- Pendiente: que joel diga «fusiona»; después, UTM en bio y enlaces (el tráfico ya los registra) y el resto del plan (P1: plan anual, correos automáticos, guías 2027).

### Psicotécnicos verbales de Auxiliar del Estado (2026-11-06, rama `claude/project-thread-mep42h`, ADR-043)

- Generadores `spelling`, `synonyms` y `antonyms` con el banco `verbal-bank.ts` comprobado en dle.rae.es (171 palabras, 70 pares de ortografía). Guías públicas nuevas.
- Simulacro de psicotécnicos de la AGE con el reparto real (9 verbales + 9 numéricos + 12 tablas), preview `63-`.
- Nota: en main, `tests/e2e/public.spec.ts` espera el título antiguo de Guardia Urbana (ya tiene contenido); no es de esta rama.

### Lo que no se podía practicar (2026-11-06, rama `claude/project-thread-fls9nq`, CNT-027, ADR-042)

- Cultura general y actualidad (`cultcat-*`, `actcat-01`, carpeta `cultura-cat`), conocimiento de Barcelona (`gub-t39`), bloque D y supuestos de IIPP. Preview `59-` a `62-`. Simulacros de Guardia Urbana y policía local con el examen completo.
- `actcat-01-actualitat` caduca: renovarlo cada trimestre. Pendiente: réplica IIPP 2025 (PDF escaneado) y que joel diga «fusiona».

### Test gratis sin registro (2026-11-07, rama `claude/project-thread-ovjh4r`, MKT-004, ADR-041)

- `/oposiciones/<slug>/test` (es y ca): 10 preguntas del día de los temas gratis, corrección al momento, sin cuenta y sin guardar nada. Enlace desde la ficha y entrada en el sitemap si hay ≥ 5 preguntas.
- Migración `20261107000100_public_sample_test` copiada en la preview `58-`. Revisión semanal de Search Console en `docs/SEO.md` §8.
- Pendiente: que joel lo pruebe en la vista previa y diga «fusiona»; después, pedir indexación de las páginas `/test` en Search Console.

### Entrar con Google (2026-11-06, rama `claude/project-thread-ncd6wh`, USR-012, ADR-040)

- Botón «Continuar con Google» en `/entrar` y `/registro`; solo aparece cuando Google está activado en Supabase. Callback con onboarding para cuentas nuevas; perfil sin contraseña para cuentas solo Google (borrar cuenta exige haber entrado hace ≤ 10 min).
- Migración `20261106000200_google_display_name` copiada en la preview `57-`.
- Pendiente: que joel cree el cliente OAuth y lo active en Supabase (`docs/DEPLOYMENT.md` → «Entrar con Google») y diga «fusiona».

### Cuatro oposiciones nuevas (2026-11-06, rama `claude/project-thread-fls9nq`, CNT-026, ADR-039)

- Guardia Urbana de Barcelona (889 preguntas), policía local de Cataluña (620), Bombers de la Generalitat (700) y Ayudantes IIPP (1.124), con fichas, réplicas de los exámenes publicados y simulacros con el formato real. Preview `51-` a `56-`; dudosas en borrador.
- Guías del examen en `src/lib/seo/exam-guides.ts`; psicotécnicos solo en Guardia Urbana y policía local. Fuentes e informes en `/mnt/project-files/aprobia/fuentes-oficiales/{guardia-urbana-bcn,policia-local-cat,bombers,ayudantes-iipp}/`.
- Pendiente: que joel diga «fusiona».

### Ficha completa del alumno (2026-11-06, rama `claude/project-thread-vkx2cm`, ADM-007, ADR-038)

- `/admin/alumnos/[id]`: accesos activos (Premium y packs) con historial, asignar pack o Premium (regalado sin Stripe, se puede quitar), códigos promocionales de Stripe de un uso ligados al alumno, tiempo dentro (hoy/7/30 días y por día), entradas y salidas (Auth, sin IP) y tests/simulacros hechos.
- Checkout con `allow_promotion_codes`; compras a 0 € con código del 100 % dan acceso.
- Latido de la zona del alumno (`/api/account/presence`, total diario, 12 meses). Privacidad y exportación actualizadas.
- Migración `20261106000100_admin_user_insights` copiada en la preview `50-`. Pendiente: que joel lo pruebe y diga «fusiona».

### Visitas y cuentas (2026-11-05, rama `claude/project-thread-is3q5b`, ADR-037)

- Vercel Web Analytics añadido (sin cookies, solo en Vercel). joel tiene que activarlo en Vercel → Analytics → Enable.
- Panel `/admin`: «Visitas y cuentas» con visitas, registros nuevos y cuentas que han entrado (hoy, 7 y 30 días) vía `admin_audience_metrics()`, y gráficas por día de 30 días (`admin_audience_daily`) que pidió joel. Migración `20261105000400` copiada en la preview `49-`.
- Privacidad y cookies mencionan Vercel Web Analytics. Pendiente: que joel diga «fusiona».

### Plan directo al test del tema y calendario (2026-11-05, rama `claude/project-thread-4mfgki`, USR-011, ADR-036)

- Las tareas del plan llevan a «Ficha» + «Empezar test» del tema (`practice_start_topic`); los temas sin acceso salen con candado hacia la ficha de la oposición.
- Calendario semanal en el panel (`my_study_log`): lo hecho cada día con hora y resultado, tareas pendientes y semanas anteriores.
- Pestaña «Mis productos» eliminada: «Simulacros» (nueva) y suscripción/compras en «Mi perfil». `/app/productos` redirige.
- Migración `20261105000300_topic_practice_calendar` copiada en la preview `48-`. Pendiente: que joel lo pruebe y diga «fusiona».

### Premium por oposición y 3 temas gratis (2026-11-05, rama `claude/project-thread-yutpbx`, BIZ-004, ADR-035)

- Inventario previo (Claude Doc «Material gratis y de pago por oposición»): el alumno gratis no tenía ni una pregunta de test.
- Nuevo modelo: Premium de cada oposición (`<prefijo>-premium`), pack gratis de 3 temas (`<prefijo>-temas-gratis`, `config.topic_slugs`) y packs de 10 intentos (`-10-simulacros`, `-10-psicotecnicos`, `config.attempts`). Migración `20261105000200_exam_premium` copiada en la preview `47-` con los productos y precios.
- Ficha de oposición, «Mis productos», plan, panel, portada y condiciones de venta adaptados.
- Precios confirmados por joel el 05/11/2026 (DEC-007): 12,99 €/mes, 9,99 € y 6,99 €. Se cobran desde la BD.

### Prisiones de Cataluña (2026-11-05, rama `claude/project-thread-xt6teb`, CNT-023, ADR-032)

- Cos tècnic d'especialistes, escala de serveis penitenciaris (C1), convocatoria JU033. Programa y fuentes en `docs/research/prisiones-catalunya-programa.md`; `build.py`, `FORMATO.md` y fuentes en `/mnt/project-files/aprobia/fuentes-oficiales/prisiones-cat/`.
- 595 preguntas en catalán y 25 fichas (`content/prisiones-cat`, temas `pcat-*` y supuestos `pcatsup-*`). Preview `37-` (oposición), `38-` (temario), `39-` (productos) y `40-` (publicación). 4 dudosas con nota quedan en borrador.
- Probado en local con todos los SQL de preview: la oposición queda disponible, 5 productos publicados y los simulacros arrancan con 60 y 25 preguntas.
- El simulacro de 60 reparte 15 de la parte general y 45 de la específica (`quotas`).
- Siguiente: precio del pack y guía SEO.

### Exámenes réplica y material completo (2026-11-05, CNT-025, ADR-034)

- Réplicas pregunta a pregunta y sus simulacros (`*-simulacro-examen-*`, `mossos-simulacre-examen-*`); mapas sin copiar enunciados en `/mnt/project-files/aprobia/fuentes-oficiales/*/replicas/`. Preview `44-` (temario), `45-` (publicación; quita la nota a las dudosas resueltas) y `46-` (simulacros réplica, verbales en Auxiliar, actualidad en Mossos, PN 28-29).
- Pendiente: renovar `mossos-d-actualitat` cada trimestre; réplicas de los supuestos II de Administrativo; dudosas que siguen en borrador (~40 en todo el banco).

### Exámenes reales: practicar con lo que cae (2026-11-05, CNT-024, ADR-033)

- Informes por oposición en `/mnt/project-files/aprobia/examenes-reales/` (exámenes oficiales, reparto por tema, huecos, simulacro recomendado) y resumen en el Claude Doc «Lo que cae en cada oposición».
- Huecos cubiertos con ~1.170 preguntas nuevas (fuentes en `/mnt/project-files/aprobia/fuentes-oficiales/*/`): preview `41-` (temario), `42-` (publicación; 9 dudosas con N: quedan en borrador) y `43-` (simulacros con `quotas`, cortes reales y 3 simulacros nuevos).
- Pendiente de joel: fuente para la actualidad de Mossos (àmbit D), casos prácticos con enunciado común, temas 28-29 de Policía Nacional (sin fuente oficial), psicotécnicos verbales.

- **Psicotécnicos (CNT-022, ADR-031):** solo se ofrecen en las oposiciones cuya convocatoria los incluye (`examHasPsycho`).

### Guardia Civil (2026-11-05, rama `claude/project-thread-fls9nq`, CNT-020, ADR-029)

- Convocatoria BOE-A-2026-9982 (3.240 plazas; 100 preguntas de 4 opciones, mínimo 50 de 100). Temario oficial 2024 en `docs/research/guardia-civil-programa.md`.
- 500 preguntas y 25 fichas (`content/guardia-civil`, temas `gc-*`); fuentes y `build.py` en `/mnt/project-files/aprobia/fuentes-oficiales/guardia-civil/`.
- Preview `31-` (temario), `32-` (productos) y `33-` (publicación). Las 3 dudas de los redactores se verificaron contra el BOE antes de publicar.
- **Ampliación (CNT-021, ADR-030):** todo el temario oficial cubierto, +430 preguntas y 17 fichas (fuentes web en `web/`, reparto en `AMPLIACION.md` de la carpeta de fuentes). Preview `34-` (temario), `35-` (pack de lengua y simulacro de inglés, `gcl-`) y `36-` (publicación).
- Falta: Policía Nacional temas 27-45.

### Nuevas oposiciones: Administrativo del Estado, Justicia y Policía Nacional (2026-11-05, rama `claude/project-thread-fls9nq`, CNT-015 a CNT-017, ADR-028)

- joel pidió «ves buscando temarios de otras opos, para ir preparando, verificando y publicando» y «Revisa y rellenas todas las opos posibles». Programas literales del BOE en `docs/research/*-programa.md` (leídos en el Chrome de joel: boe.es bloquea al contenedor).
- **Contenido** (todo con cita literal comprobada por `build.py --check` en `/mnt/project-files/aprobia/fuentes-oficiales/{administrativo-estado,justicia,policia-nacional}/`):
  - Administrativo del Estado: 340 preguntas y 17 fichas (`age-adm-*`); lo común reutiliza `age-aux-*`.
  - Auxilio Judicial y Tramitación Procesal: 540 preguntas y 27 fichas (`jus-*`, `justra-*`), compartidas con `meta.also_exams`.
  - Policía Nacional: 520 preguntas de 3 opciones y 26 fichas (`pn-*`), temas 1-26.
- **Preview:** `25-`, `26-`, `27-` (temario), `28-` (productos) y `29-` (publicación por petición de joel; las dudosas con N: quedan en borrador). Se aplican al fusionar el PR.
- **Dudosas (05/11):** las 23 se verificaron contra el BOE y se publican con `30-` (petición de joel «Sube todo y verifica las dudosas»).
- **Probado en local:** las cuatro oposiciones quedan disponibles, 14 productos publicados y los simulacros arrancan con su tamaño.
- **Siguiente:** Guardia Civil, Policía temas 27-45 y las normas sin fuente (ver CNT-015 a CNT-018); guías SEO de las nuevas oposiciones.

### Pagos con Stripe en modo de pruebas (2026-11-03, rama `claude/project-thread-tdwb1x`, STO-008)

- joel pidió que Claude lo hiciera todo. Código hecho y probado **sin cuenta de Stripe**. Todo en `docs/PAGOS.md` y ADR-027.
- Migración `20261103000900_billing.sql` (+ `supabase/preview/11-pagos-stripe.sql`), `src/lib/billing/*`, `/api/stripe/webhook`, botones en `/oposiciones/[slug]` y `/app/productos`, portal «Gestionar suscripción».
- Pendiente de joel: crear la cuenta de Stripe (modo de pruebas), poner `STRIPE_SECRET_KEY` y `STRIPE_WEBHOOK_SECRET` en Vercel, guardar el portal de clientes, fijar precios y publicar Premium en `/admin/productos`.
- Cobros reales: NO. Requieren autorización expresa, datos fiscales del titular (DEC-004) y textos legales revisados.

### SEO y GEO (2026-11-04, rama `claude/project-thread-h5od90`, MKT-002, ADR-025)

- joel pidió una auditoría SEO/GEO completa sin cambiar funciones. Guía de mantenimiento en `docs/SEO.md`.
- **Hecho:**
  - `robots.txt`, `sitemap.xml` y `llms.txt`. Canonical, hreflang, Open Graph e imagen social. `noindex` en zonas privadas.
  - Todo depende de `isIndexable()`: con `PREVIEW_PASSWORD` nada es indexable. **Hoy ningún rastreador puede entrar.**
  - Guías por oposición (`src/lib/seo/exam-guides.ts`, solo datos de `docs/research/`) y 12 páginas `/psicotecnicos/[tipo]`.
  - Schema.org (Organization, WebSite, FAQPage, BreadcrumbList, WebPage, Quiz).
  - Analítica de captación sin cookies: migración `20261104000200_traffic_analytics.sql`, preview `22-` y panel `/admin/trafico`.
  - Verificación de Search Console y Bing, e IndexNow, por variables de entorno.
- **Siguiente (requiere a joel):**
  - Quitar la contraseña cuando quiera abrir la web y redesplegar.
  - Dar de alta Search Console (TXT en Cloudflare) y Bing, y enviar el sitemap.
  - Decidir si se bloquean los rastreadores de entrenamiento (GPTBot, ClaudeBot…).
  - Decidir si se publica una muestra gratuita del temario.
  - Revisar el contenido de las guías.

### Marca OPOSAPRUEBA y letra seria (2026-11-04, rama `claude/project-thread-0diwv3`, ADR-023)

- La marca pasa a **OPOSAPRUEBA** en la interfaz, los metadatos, el manifiesto, los correos locales y la documentación. Los titulares usan Source Serif 4.
- Se probó una portada interactiva inspirada en speak.com (selector de psicotécnicos reales y pestañas del producto). joel prefirió el diseño anterior, así que se descartó: está en el commit f86e21e por si se recupera algo.
- Falta cambiar el remitente y las plantillas de correo de Supabase cloud en su panel.

### Segunda oposición: Auxiliar Administrativo del Estado (2026-11-04, rama `claude/project-thread-mep42h`, CNT-012, ADR-020)

- joel pidió la siguiente oposición con más clientes potenciales, hecha igual que Mossos, y **publicarla** cuando estuviera. Elegida por demanda estable y por encaje: 46.798-54.136 convocados al año, examen con 30 psicotécnicas y temario del BOE. Cifras y fuentes en `docs/research/auxiliar-estado-fuentes.md`.
- Convocatoria verificada: BOE-A-2025-26262, Anexo I, 1.700 plazas. Ejercicio único de 90 min: parte 1 = 30 preguntas del Bloque I + 30 psicotécnicas; parte 2 = 50 del Bloque II. Cada error resta 1/3.
- **Contenido:**
  - 290 preguntas en castellano (`content/auxiliar-estado/*.json`), 14 de los 16 temas del Bloque I.
  - 14 fichas con artículos literales (`content/auxiliar-estado/fichas/`).
  - El formato compacto, las leyes del BOE (réplica legalize-es) y `build.py` están en `/mnt/project-files/aprobia/fuentes-oficiales/auxiliar-estado/`. `build.py --check` comprueba todas las citas (0 errores).
  - Regenerar: `python3 -I build.py /home/claude/opos` y después los comandos de las cabeceras de `supabase/preview/12-` y `13-`.
- **Productos** (`14-`): `age-aux-bloque-1-boe-2026` (pack), `age-aux-simulacro-bloque-1-2026` (30 preguntas, −1/3, 25 min), `age-aux-simulacro-psicotecnicos-2026` (psico, `config.item_types`) y `age-aux-pack-completo-2026` (bundle).
- **Publicación** (`15-`, por orden de joel): publica preguntas, fichas y productos `age-aux-*` a nombre de la titular, con auditoría. Las 4 dudosas quedan en borrador. La oposición pasa a «disponible». Probado en local: 286 publicadas, idempotente, simulacro con 30 preguntas de 14 temas.
- **Ampliación (CNT-013, ADR-021, mismo día, «Sigue y sube todo»):**
  - Temas I.6 y I.10 y el Bloque II completo (U01-U12). En total hay 549 preguntas (537 publicadas y 12 dudosas en borrador) y 28 fichas.
  - Ofimática y UE con fuentes web oficiales (`fuentes-web.json`, `web/`).
  - Productos nuevos en `16-`: pack Bloque II y simulacro de la parte 2 (50 preguntas, 40 min), añadidos al pack completo.
  - `17-` publica todo `age-aux-*` como `15-`.
  - Los archivos de contenido se llaman ahora `b1-NN-…` / `b2-NN-…`.
- **Dudosas:** joel pidió publicarlas («Súbelas»). Se aclararon en su explicación (`18-`) y se publicaron (`19-`): ya están publicadas las 549.
- **Calibración con los exámenes reales (CNT-014, ADR-022):**
  - Se leyeron en el Chrome de joel el examen de 2025 (23/05/2026) y el de 2024 del INAP, con sus plantillas, criterios y cortes. Análisis en `docs/research/auxiliar-estado-examenes.md`.
  - 5 generadores nuevos de psicotécnicos con el formato AGE (`percentages`, `equations`, `probability`, `codes`, `tables`) y `item_types` con cantidades por tipo.
  - Simulacro completo por partes (`age-aux-simulacro-completo-2026`, `kind: "sections"`, migración `20261104000100_sectioned_mock.sql`): 110 preguntas en 90 min, con nota por partes y los cortes de 2025 (29 y 21,33).
  - 13 preguntas de seguridad y redes del glosario del INCIBE (562 en total).
  - Preview: `20-` (migración + productos) y `21-` (preguntas nuevas publicadas).
- **Siguiente:**
  - Que joel fije el precio del pack.
  - Banco verbal (sinónimos, antónimos y ortografía, unas 10 de 30 psicotécnicas) comprobado con el DLE en el Chrome de joel.
  - Actualizar los cortes cuando salga una convocatoria nueva.
  - Cotejar con la página original las fuentes web capturadas por fragmentos (ADR-021).

### Fichas de estudio de Mossos (2026-11-03, rama `claude/project-thread-rp6zo4`, CNT-011, ADR-027)

- joel preguntó qué más se podía añadir a Mossos antes de abrir otras oposiciones. Lista priorizada que se le propuso:
  1. Fichas de estudio (hecho).
  2. Guía de la convocatoria (calendario, fases, puntuación, solo con datos verificados).
  3. Prueba física, del 23/11 al 21/12/2026.
  4. Idiomas, que da hasta 3 de 23 puntos.
  5. MOC-002 y más simulacros.
  6. Àmbit D (actualidad), que necesita una fuente oficial.
  7. Médico, entrevista y personalidad, solo con lo que digan las bases.
- Los puntos 3, 4 y 7 requieren leer las bases ISP/1763/2026 en el Chrome de joel, porque la web de la Generalitat bloquea a Claude.
- **Hecho:**
  - 20 fichas (`content/mossos/fichas/*.json`) con índice, «Idees força», glosario y esmenes. Son texto literal de la guía y lo extrae `scripts/content/extract-topic-notes.mjs <guia-2026> content/mossos content/mossos/fichas`. 963/963 fragmentos comprobados con `verify-excerpts.mjs`.
  - Migración `20261103000900_topic_notes.sql`: tabla, guardián de estados, RLS (solo publicadas para el alumnado), `review_topic_notes` (solo owner), `exam_topic_notes`. `review_all_batch` también publica las fichas.
  - Admin en `/admin/revision/fichas`. Alumnado en `/app/temario` y `/app/temario/[slug]` (nueva pestaña «Temario»).
  - Preview: `supabase/preview/11-fichas-mossos.sql` (idempotente; se aplica sola al mergear a `main`). Generar con `node scripts/content/notes-to-sql.mjs content/mossos/fichas/*.json`.
  - Capturas en `/mnt/project-files/aprobia/fichas-estudio/` (`scripts/design/shots-notes.mjs`).
- **Siguiente:** que joel revise y publique las fichas; después, el punto 2 (guía de la convocatoria) y, cuando joel esté en su PC, leer las bases para la prueba física y la de idiomas.

### Rediseño visual: portada y panel del alumno (2026-11-03, rama `claude/project-thread-0diwv3`, UX-001)

- Petición de joel: más personalidad, secciones diferenciadas, elementos visuales útiles, navegación simple; empezar por portada y panel, enseñar capturas antes/después **antes de extenderlo** y antes de sustituir la web.
- **No se ha mergeado a `main`** (Vercel publica `main` en la preview). `vercel.json` desactiva los despliegues automáticos de ramas `claude/**`. El workflow de BD solo corre en `main` y el rediseño no toca BD.
- Sistema y decisiones en `docs/DESIGN_SYSTEM.md` (sección «Identidad visual») y ADR-018.
- Capturas: `node scripts/design/setup-demo.mjs <estado>` (publica en LOCAL el temario de `supabase/preview` y crea alumnas de demo) y `node scripts/design/shots.mjs <estado> <salida> [--dark]`. Ojo: `setup-demo` deja Mossos «disponible» en local y rompe `public.spec.ts`; hacer `npm run db:reset` antes de los E2E.
- Siguiente: según el visto bueno de joel, UX-002 (resto de pantallas).

### Temario completo de Mossos y aprobación por lotes (2026-11-03)

- **402 preguntas en catalán** que cubren los 20 temas de la Guia d'estudi 2026 (A.1–A.7, B.1–B.8, C.1–C.5): 20 por tema, salvo B.1 (30) y C.5 (12, porque el tema ocupa dos páginas). Están en `content/mossos/<tema>.json`, todas en **borrador**. Siguen el estilo del examen («Segons la Guia d'estudi…», 4 opciones). La correcta está repartida al 25 % por posición. Cada pregunta cita literalmente la guía y la cita se comprueba con `node scripts/content/verify-excerpts.mjs <lote> <guia.txt>` (402/402).
- **Fuente de redacción:** formato compacto `q/<T>.txt` y `build.py`, en `/mnt/project-files/aprobia/fuentes-oficiales/fuente-preguntas/`. El texto de la guía, separado por temas, está en `…/fuentes-oficiales/guia-2026/`.
- **Criterios aplicados:**
  - No se pregunta por datos que contradicen las esmenes de setembre 2026: comarques, presidents, eurodiputats.
  - Tampoco por datos que la guía tiene desfasados, como el nombre de reformas de la CE o el detalle de elección del CGPJ.
  - Se evitan preguntas casi iguales a las del Model 01.
  - Las que tienen nota de revisión son las dudosas.
- **CNT-010 (aprobación por lotes):** en `/admin/revision/fuentes?tema=<slug>` aparece el panel «Aprobar por lotes». Funciona así:
  - Solo la titular puede usarlo y tiene que confirmar con una casilla.
  - «Aprobar lote» pasa a aprobadas las preguntas del tema.
  - «Publicar las aprobadas» las publica.
  - Las dudosas quedan fuera salvo que se marquen.
  - La RPC es `review_topic_batch` (migración `20261103000200_batch_review.sql`). Cada pregunta pasa por el guardián de estados y deja auditoría.
- **Packs por àmbit** (`supabase/preview/6-packs-mossos-ca.sql`): `mossos-ambit-{a,b,c}-guia-2026`, en borrador. Al publicar un lote, sus preguntas entran solas en el pack (`config.topic_prefix` y trigger `questions_autopack`). Para que el alumnado los vea, el pack se publica desde `/admin/productos` y se da acceso (Premium o concesión manual).
- **Preview:** ejecutar en el SQL Editor, en orden, `4-aprobacion-por-lotes.sql`, `5a`, `5b` y `5c-temario-…`, `6-packs-mossos-ca.sql` y `7-simulacros.sql` (con `3-b1-guia-ca.sql` ya ejecutado). Todo está probado en local y es idempotente.
- **Simulacro (MOC-001, hecho):** migración `20261103000300_mock_exams.sql` (`mock_attempts`, `mock_attempt_items`, `mock_start`/`mock_save_answer`/`mock_submit`, solo service_role). Formato en `products.config` del `mock_exam`; selección: una pregunta publicada por tema y el resto al azar; plazo controlado por la BD (+15 s de margen); nota = max(0, aciertos − fallos·¼)·10/válidas. Pantalla `/app/simulacros/[id]` (cronómetro, navegador, dejar en blanco, entrega con confirmación, corrección) y botón en `/app/productos`. Preview: `7-simulacros.sql` crea `mossos-simulacre-coneixements-2026` en borrador. Contenido E2E: `content/test/simulacro-prueba.json`.
- **Publicar todo de un clic** (petición de joel): `review_all_batch` (migración `20261103000400`) y panel en `/admin/revision/fuentes` sin tema elegido. Aprueba y publica todas las preguntas reales pendientes (opción de incluir dudosas, marcada por defecto) y publica los packs y simulacros en borrador que ya tienen contenido. Los packs respetan `config.locale`. Preview: `8-publicar-todo.sql`.
- **Pack completo (2026-11-03):** migraciones `0500` (simulacro de psicotécnicos: `mock_start_generated`, clave en `mock_attempt_keys` sin permisos para el alumno), `0600` (plan: `user_exam_targets.target_date`, `my_topic_progress`) y `0700` (`my_library` incluye lo que da un bundle; `exam_offer` pública solo con agregados). Producto `mossos-pack-complet-2026` (bundle con 3 packs + 2 simulacros) y `mossos-simulacre-aptituds-2026`, en borrador con `config.publish_with_content`. Ficha `/oposiciones/mossos-esquadra` con «Qué incluye». Precio del pack: sin fijar (lo pone joel en /admin/productos); si no hay, se muestra el de Premium o «por confirmar». Preview: `9-pack-completo.sql`.
- **Siguiente:** MOC-002 (evolución de notas y repetir errores del simulacro) y simulacro de psicotécnicos (80 ítems, 35 min, sin penalización, mínimo 5).

### Fuentes oficiales y lote B.1 al estilo del examen (2026-11-03)

- **SRC-001 verificado:** bases ISP/1763/2026, calendario, Guia d'estudi juny 2026, esmenes, Model 01 y plantillas leídos en el Chrome de joel (a petición suya). Formato oficial: 30 preguntas, 4 opciones, −1/4, 35 min, mínimo 4. Todo en `docs/research/mossos-46-26-fuentes.md`, que incluye el análisis de estilo del examen.
- **Nuevo lote** `content/mossos/b1-estatut-ca.json`: 30 preguntas en catalán con el formato «Segons la Guia d'estudi…». Cada una lleva un extracto literal de la guía (págs. 97-106), comprobado automáticamente contra el PDF, y está en borrador. Una está marcada DUBTOSA.
- El lote anterior (castellano, BOE) queda sustituido.
- Preview: `supabase/preview/3-b1-guia-ca.sql`.
- **Cómo leer la guía:** abrir el PDF en el Chrome de joel, extraer el texto con pdf.js, volcar las páginas del tema en un `<article>` y leerlas con `get_page_text`.

### Sesión 3 (2026-11-03): primer módulo Mossos revisable

- **Fuentes** (`docs/research/mossos-46-26-fuentes.md`): convocatoria 46/26 y temario documentados con enlaces y fechas. **Ninguna página oficial de la Generalitat/DOGC se pudo abrir** (bloqueo robots.txt para el acceso automatizado; no se eludió): todos los datos de la convocatoria están marcados «sin verificar» (4 webs de terceros coinciden). Fuente oficial leída: Estatut (LO 6/2006) consolidado en el BOE, arts. 1–11, 29, 55–57, 61, 62, 64, 67, 68, 70, 71.
- **30 preguntas originales del tema B.1** (`content/mossos/b1-estatut.json`), 4 opciones, explicación, artículo concreto y extracto literal. Cargadas como **borrador** (`scripts/content/load-questions.mjs`, idempotente; se niega a publicar contenido real). 3 marcadas «extracto parcial». En castellano (versión catalana pendiente).
- **Revisión con fuente:** `/admin/revision/fuentes` (pregunta + extracto + nota + botones del flujo; aprobar/publicar solo la titular).
- **Práctica con preguntas del banco (LRN-003, STO-006 parcial):** migración `20261103000100_question_practice.sql` (`source_ref`, `source_excerpt`, `review_note`, `is_test`; `practice_start_product`, `practice_answer_question`, `practice_start_question_review`; corrección en SQL; `has_product_access`). «Mis productos» → Practicar; resultados con explicación y referencia; repaso de preguntas falladas separado del de psicotécnicos.
- **Contenido de prueba separado:** `content/test/pack-prueba.json` (`is_test`, producto «[PRUEBA] Pack de demostración»). Un producto de prueba no admite preguntas reales y viceversa (trigger).
- **Capturas:** `node scripts/screenshots.mjs <carpeta>` (pila + servidor en :3000).

### Preview privada (2026-11-03, autorizada por joel)

- https://opos-indol.vercel.app (Vercel, despliega `main` de Opos) + Supabase cloud `aprobia-preview` (UE, plan Free). Protegida con `PREVIEW_PASSWORD` y `noindex`. Cuentas de prueba `admin@aprobia.test` (titular) y `alumna@aprobia.test`. joel probó el recorrido completo: OK. Pasos en `docs/PREVIEW.md`.
- Cada push a `main` redepliega la preview. Los cambios de BD hay que aplicarlos a mano en el SQL Editor de Supabase (la red de Claude no llega a supabase.co ni a vercel.app).

### Sesión 2

- **Hitos 0 y 1** completados. **Hito 2** casi completo (faltan USR-004/005/010, ADM-004).
- **P1 hecho (LRN-001, LRN-005):** la práctica de psicotécnicos de alumnos registrados se guarda (sesiones, respuestas, acierto, tiempo medido en BD, tipo, dificultad). `/app/practica` (nueva práctica y repaso de fallos), `/app/practica/[id]` (continúa donde se dejó; resumen con detalle y explicaciones), `/app/progreso` (KPIs, actividad diaria, por tipo y dificultad, fallos pendientes). El panel principal y el admin muestran datos reales. Cada alumno solo ve lo suyo (RLS + E2E). La demo `/psicotecnicos` sigue anónima, no guarda nada e invita a registrarse.
- **P2 hecho:** 7 tipos de psicotécnicos verificables (series, letras con Ñ, numérico, analogías es/ca, matrices, espacial, atención). Tests de manipulación de soluciones, duplicados, reparto de posiciones y textos es/ca.
- **P3 hecho (arquitectura + base):** tienda sin pagos reales: productos, precios, contenido desde el banco, pedidos, suscripciones, concesiones de acceso, «Mis productos», gestión de productos y compras en admin, concesión manual auditada. Premium 14,99 €/mes en borrador.
- **P4 hecho:** editor de preguntas, cola de revisión (aprobar/rechazar/publicar/archivar solo la titular), importación CSV/JSON validada (todo como borrador), duplicados detectados.
- **Repositorio:** `https://github.com/jalbertivega98-ops/Opos` (rama `main`). Copia también en `/mnt/project-files/aprobia/` y en el PC de joel (`C:\Users\34644\Desktop\Claude\OPOS`).

## Cómo reanudar

```bash
git clone https://github.com/jalbertivega98-ops/Opos.git academia && cd academia
npm ci && npm run stack:setup
npm run stack:start -- --seed
node scripts/stack/keys.mjs   # crear .env.local según .env.example (+ AUTH_RATE_LIMIT_MAX=1000 para E2E)
npm run dev
npm run admin:grant -- tu@email.test owner
```

Contenedor cloud: E2E con `PW_CHROMIUM_PATH=/opt/pw-browsers/chromium npx playwright test`. Si un servicio de la pila queda colgado: `pkill -x postgrest` / `pkill -x auth`, borrar su `.local-stack/*.pid` y `npm run stack:start`. **No usar `pkill -f`** (mata la propia shell).

## Pruebas (último run, sesión 3)

typecheck ✅ · lint ✅ · unitarias 82/82 ✅ · BD 74/74 ✅ · E2E 34/34 ✅ (rama Auxiliar del Estado, 2026-11-04)

## Bloqueos (TASKS.md › Bloqueos)

- DEC-003: Supabase cloud, Stripe test, despliegue, SMTP y dominio requieren autorización específica (preparado en DEPLOYMENT.md).
- DEC-004: datos legales del titular pendientes (no inventar).
- DEC-005: "Aprobia" provisional.

## Cómo cargar contenido

```bash
node scripts/content/load-questions.mjs content/mossos/b1-estatut-ca.json         # reales → borrador
npm run admin:grant -- titular@x.test owner
node scripts/content/load-questions.mjs content/test/pack-prueba.json --test --publish-as titular@x.test  # prueba
```

## Siguiente fase

1. **joel:** revisar el lote B.1 en catalán en `/admin/revision/fuentes` (CNT-010: aprobación por lotes).
2. Generar el resto de temas (A.1–C.5) desde la Guia d'estudi con el mismo método; producto real «Mossos · B.1 Estatut».
3. **STO-006 / MOC-001** simulacros (`mode = mock`, 30 preguntas/35 min/−1/4/mínimo 4, verificado).
4. **STO-005** PDF de un pack desde el banco; **STO-007** tienda pública.
5. **STO-008** Stripe test (con autorización).
6. Mejoras: pausa en el entrenador (PSY-005), cambio de rol en UI (ADM-004), SM-2 para preguntas (LRN-004).

## Notas técnicas

- Next 16: middleware = `src/proxy.ts`; leer `node_modules/next/dist/docs` antes de usar APIs nuevas.
- next-intl no admite puntos en claves de mensajes.
- jsonb reordena claves: comparar presentaciones con `canonical()` (types.ts).
- En tests de BD, un error dentro de la transacción la aborta: usar `savepoint` (helper `fails`).
- Archivos "use server" solo exportan funciones async (esquemas en archivos aparte); `hash.ts` usa `node:crypto` y es server-only.

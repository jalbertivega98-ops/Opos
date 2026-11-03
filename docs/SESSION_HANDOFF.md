# SESSION HANDOFF

**Última actualización:** 2026-11-03 · Sesión 3 (+ temario completo de Mossos y aprobación por lotes)

## Estado exacto

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
- **Preview:** ejecutar en el SQL Editor, en orden, `4-aprobacion-por-lotes.sql`, `5a`, `5b` y `5c-temario-…`, y `6-packs-mossos-ca.sql` (con `3-b1-guia-ca.sql` ya ejecutado). Todo está probado en local y es idempotente.
- **Siguiente:** MOC-001, el simulacro con formato oficial (30 preguntas mezcladas, 35 min, −1/4, mínimo 4).

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

typecheck ✅ · lint ✅ · build ✅ · unitarias 70/70 ✅ · BD 55/55 ✅ · E2E 30/30 ✅ (escritorio + móvil)

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

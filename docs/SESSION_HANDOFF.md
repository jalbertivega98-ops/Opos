# SESSION HANDOFF

**Última actualización:** 2026-11-03 · Sesión 3

## Estado exacto

### Sesión 3 (2026-11-03): primer módulo Mossos revisable

- **Fuentes** (`docs/research/mossos-46-26-fuentes.md`): convocatoria 46/26 y temario documentados con enlaces y fechas. **Ninguna página oficial de la Generalitat/DOGC se pudo abrir** (bloqueo robots.txt para el acceso automatizado; no se eludió): todos los datos de la convocatoria están marcados «sin verificar» (4 webs de terceros coinciden). Fuente oficial leída: Estatut (LO 6/2006) consolidado en el BOE, arts. 1–11, 29, 55–57, 61, 62, 64, 67, 68, 70, 71.
- **30 preguntas originales del tema B.1** (`content/mossos/b1-estatut.json`), 4 opciones, explicación, artículo concreto y extracto literal. Cargadas como **borrador** (`scripts/content/load-questions.mjs`, idempotente; se niega a publicar contenido real). 3 marcadas «extracto parcial». En castellano (versión catalana pendiente).
- **Revisión con fuente:** `/admin/revision/fuentes` (pregunta + extracto + nota + botones del flujo; aprobar/publicar solo la titular).
- **Práctica con preguntas del banco (LRN-003, STO-006 parcial):** migración `20261103000100_question_practice.sql` (`source_ref`, `source_excerpt`, `review_note`, `is_test`; `practice_start_product`, `practice_answer_question`, `practice_start_question_review`; corrección en SQL; `has_product_access`). «Mis productos» → Practicar; resultados con explicación y referencia; repaso de preguntas falladas separado del de psicotécnicos.
- **Contenido de prueba separado:** `content/test/pack-prueba.json` (`is_test`, producto «[PRUEBA] Pack de demostración»). Un producto de prueba no admite preguntas reales y viceversa (trigger).
- **Capturas:** `node scripts/screenshots.mjs <carpeta>` (pila + servidor en :3000).

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
node scripts/content/load-questions.mjs content/mossos/b1-estatut.json            # reales → borrador
npm run admin:grant -- titular@x.test owner
node scripts/content/load-questions.mjs content/test/pack-prueba.json --test --publish-as titular@x.test  # prueba
```

## Siguiente fase

1. **joel:** revisar las 30 preguntas B.1 en `/admin/revision/fuentes` y subir los PDF oficiales (bases DOGC 9681, guía juny 2026, esmenes) para verificar SRC-001.
2. Tras su aprobación: producto real «Mossos · B.1 Estatut» (pack) y versión catalana; ampliar a B.2–B.8 con los artículos que falten (152, 164… no leídos).
3. **STO-006 / MOC-001** simulacros (`mode = mock`, 30 preguntas/35 min/−1/4 cuando se verifique la convocatoria).
4. **STO-005** PDF de un pack desde el banco; **STO-007** tienda pública.
5. **STO-008** Stripe test (con autorización).
6. Mejoras: pausa en el entrenador (PSY-005), cambio de rol en UI (ADM-004), SM-2 para preguntas (LRN-004).

## Notas técnicas

- Next 16: middleware = `src/proxy.ts`; leer `node_modules/next/dist/docs` antes de usar APIs nuevas.
- next-intl no admite puntos en claves de mensajes.
- jsonb reordena claves: comparar presentaciones con `canonical()` (types.ts).
- En tests de BD, un error dentro de la transacción la aborta: usar `savepoint` (helper `fails`).
- Archivos "use server" solo exportan funciones async (esquemas en archivos aparte); `hash.ts` usa `node:crypto` y es server-only.

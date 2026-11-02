# TASKS · Backlog

Estados: `BACKLOG → READY → IN_PROGRESS → REVIEW → TESTING → DONE`. Prioridad: P0 (camino crítico) · P1 · P2.
Una tarea solo pasa a DONE con criterios de aceptación cumplidos y pruebas en verde. Pruebas: U = unitaria, DB = RLS/SQL, E2E = Playwright.
Formato de cada fila: **ID** · descripción · P · dependencias · estado · criterios de aceptación · archivos · pruebas.

## Camino crítico

`USR-007/008/009 (RGPD)` → `ADM-001..004` → `CNT-001..004` → `LRN-001..004` → `PSY-001..003` → `MOC-001..002` → `BIZ-001..005` → `QA/SEC` → `LAU`

## Bloqueos y decisiones pendientes (requieren a joel)

- **DEC-001** Oposición piloto para el primer contenido revisado (propuesta: Mossos d'Esquadra o Auxiliar Administrativo del Estado).
- **DEC-002** ¿Quién revisa el contenido educativo? (rol `editor`).
- **DEC-003** Autorizar cuentas: Supabase cloud (región UE), Stripe test, proveedor de despliegue, SMTP, dominio, repositorio GitHub.
- **DEC-004** Datos del titular para textos legales y asesoría legal.
- **DEC-005** Confirmar nombre comercial (comprobar marca y dominio).

---

## Épica E0 · Preparación (Hito 0) — DONE

| ID      | Descripción                                                      | P   | Dep. | Estado | Criterios de aceptación                                         | Archivos                             | Pruebas |
| ------- | ---------------------------------------------------------------- | --- | ---- | ------ | --------------------------------------------------------------- | ------------------------------------ | ------- |
| ORG-001 | Inspección del entorno y capacidades                             | P0  | —    | DONE   | Versiones y limitaciones documentadas (ADR-003, ADR-005)        | docs/DECISIONS.md                    | —       |
| ORG-002 | CLAUDE.md conciso                                                | P0  | —    | DONE   | Objetivos, arquitectura, convenciones, seguridad, procedimiento | CLAUDE.md                            | —       |
| ORG-003 | 8 subagentes con herramientas mínimas                            | P0  | —    | DONE   | Frontmatter válido, responsabilidades y entregables             | .claude/agents/*                     | —       |
| ORG-004 | 11 skills de proyecto                                            | P0  | —    | DONE   | Cuándo/entradas/procedimiento/validación/resultado/fin          | .claude/skills/*                     | —       |
| ORG-005 | Hooks (formato, secretos, bash-guard, inicio, cierre) + permisos | P0  | —    | DONE   | Hooks probados con entradas de ejemplo                          | .claude/settings.json, .claude/hooks | manual  |
| ORG-006 | Documentación base y backlog                                     | P0  | —    | DONE   | 12 documentos + TASKS.md                                        | docs/, TASKS.md                      | —       |

## Épica E1 · Fundación (Hito 1) — DONE

| ID      | Descripción                                                   | P   | Dep.    | Estado | Criterios de aceptación                                                       | Archivos                           | Pruebas     |
| ------- | ------------------------------------------------------------- | --- | ------- | ------ | ----------------------------------------------------------------------------- | ---------------------------------- | ----------- |
| FND-001 | Proyecto Next.js 16 + TS + Tailwind + Git                     | P0  | —       | DONE   | build, lint y typecheck en verde                                              | package.json, next.config.ts       | build       |
| FND-002 | Pila local Supabase sin Docker                                | P0  | —       | DONE   | start/stop idempotentes; signup envía email a Mailpit                         | scripts/stack/*                    | E2E         |
| FND-003 | Migración identidad (perfiles, roles, auditoría, actividad)   | P0  | FND-002 | DONE   | RLS; trigger de perfil; anti-escalada de rol                                  | supabase/migrations/0100           | DB          |
| FND-004 | Migración catálogo multioposición + seed honesto              | P0  | FND-003 | DONE   | 12 oposiciones `coming_soon` sin datos inventados                             | 0200, seed.sql                     | DB, E2E     |
| FND-005 | Migración banco de preguntas + flujo de revisión              | P0  | FND-003 | DONE   | Transiciones válidas; 1 correcta; publicar exige revisión; alumnos sin acceso | 0300                               | DB          |
| FND-006 | Sistema de diseño + modo oscuro                               | P0  | FND-001 | DONE   | Tokens, componentes base, capturas móvil/escritorio                           | globals.css, components/ui         | E2E @mobile |
| FND-007 | i18n es/ca                                                    | P0  | FND-001 | DONE   | Cambio de idioma conserva ruta; `lang` correcto                               | src/i18n, messages                 | E2E         |
| FND-008 | Auth: registro+verificación, login, recuperación, logout      | P0  | FND-003 | DONE   | Sin enumeración; rate limit; redirect seguro                                  | src/lib/auth, app/(auth), app/auth | U, E2E      |
| FND-009 | Navegación, landing, catálogo, ficha, 404, legales (borrador) | P0  | FND-006 | DONE   | Responsive; estados vacíos                                                    | app/[locale]/(site)                | E2E         |
| FND-010 | Cabeceras de seguridad, PWA manifest                          | P1  | FND-001 | DONE   | Cabeceras presentes                                                           | next.config.ts, manifest.ts        | E2E         |

## Épica E2 · Usuarios (Hito 2)

| ID      | Descripción                                                               | P   | Dep.             | Estado  | Criterios de aceptación                                            | Archivos                       | Pruebas |
| ------- | ------------------------------------------------------------------------- | --- | ---------------- | ------- | ------------------------------------------------------------------ | ------------------------------ | ------- |
| USR-001 | Onboarding (oposición, nivel, horas, objetivos, aviso con consentimiento) | P0  | FND-008          | DONE    | Guarda objetivo principal; `follow_only` si próximamente           | lib/onboarding, app/onboarding | U, E2E  |
| USR-002 | Dashboard base con actividad real                                         | P0  | USR-001          | DONE    | Muestra oposiciones, actividad; sin datos falsos                   | app/(site)/app/page.tsx        | E2E     |
| USR-003 | Panel admin base con KPIs reales                                          | P0  | FND-003          | DONE    | Solo admin; métricas desde BD                                      | lib/admin, admin/page.tsx      | E2E, DB |
| USR-004 | Generar plan inicial a partir del onboarding                              | P1  | USR-001, LRN-001 | BACKLOG | Plan semanal según horas/nivel/objetivos                           | lib/learning/plan.ts           | U       |
| USR-005 | Gestionar varias oposiciones (añadir, cambiar principal, dejar de seguir) | P1  | USR-001          | READY   | Una sola principal; actividad registrada                           | app/app/oposiciones            | E2E     |
| USR-006 | Seleccionar convocatoria en onboarding si hay publicadas                  | P2  | CNT-002          | BACKLOG | Solo convocatorias publicadas                                      | onboarding-form.tsx            | E2E     |
| USR-007 | Perfil editable (nombre, idioma, consentimientos)                         | P0  | FND-008          | READY   | Cambios con validación; idioma aplica a la UI                      | app/app/perfil                 | E2E     |
| USR-008 | Exportar mis datos (JSON)                                                 | P0  | USR-007          | READY   | Incluye perfil, objetivos, actividad, resultados; solo los propios | route handler                  | E2E, DB |
| USR-009 | Eliminar cuenta (confirmación + borrado en cascada)                       | P0  | USR-007          | READY   | Reautenticación; borra auth.users; auditado                        | server-only con service role   | E2E, DB |
| USR-010 | Cambio de email y contraseña desde el perfil                              | P1  | USR-007          | BACKLOG | Verificación del nuevo email                                       | app/app/perfil                 | E2E     |
| ADM-001 | Listado de alumnos con búsqueda, filtros y paginación                     | P0  | USR-003          | READY   | Por email/nombre, estado, plan, oposición, fechas                  | app/admin/alumnos              | E2E     |
| ADM-002 | Ficha de alumno (perfil, actividad, oposiciones, suscripción)             | P0  | ADM-001          | BACKLOG | Sin datos de pago sensibles; acceso auditado                       | app/admin/alumnos/[id]         | E2E     |
| ADM-003 | Exportación CSV autorizada y auditada                                     | P1  | ADM-001          | BACKLOG | Solo admin; registro en audit_log; sin contraseñas                 | route handler                  | E2E, DB |
| ADM-004 | Suspender/reactivar cuenta y cambiar rol (owner)                          | P1  | ADM-002          | BACKLOG | Auditado; owner único gestiona admins                              | actions                        | DB, E2E |
| ADM-005 | Métricas de retención (cohortes) y tiempo de estudio                      | P1  | LRN-001          | BACKLOG | Desde datos reales                                                 | lib/admin                      | U       |

## Épica E3 · Contenido (Hito 3)

| ID      | Descripción                                                                                        | P   | Dep.                      | Estado  | Criterios de aceptación                        | Archivos              | Pruebas |
| ------- | -------------------------------------------------------------------------------------------------- | --- | ------------------------- | ------- | ---------------------------------------------- | --------------------- | ------- |
| CAT-001 | Catálogo público con filtros                                                                       | P0  | FND-004                   | DONE    | Búsqueda saneada, filtro por categoría, vacío  | oposiciones/          | U, E2E  |
| CAT-002 | Filtro por ámbito/territorio y organismo                                                           | P2  | CAT-001                   | BACKLOG | —                                              | oposiciones/          | E2E     |
| CAT-003 | Búsqueda insensible a acentos (unaccent)                                                           | P2  | CAT-001                   | BACKLOG | "policia" encuentra "Policía"                  | migración + queries   | DB      |
| CNT-001 | Editor de catálogo en admin (organismos, oposiciones, convocatorias, pruebas, requisitos, fuentes) | P0  | ADM-001                   | BACKLOG | Sin programar; validación; auditado            | app/admin/catalogo    | E2E     |
| CNT-002 | Editor de preguntas con opciones, vínculos y fuente                                                | P0  | FND-005                   | BACKLOG | Crea en draft; hash anti-duplicado             | app/admin/preguntas   | E2E, DB |
| CNT-003 | Cola de revisión (needs_review → approved → published)                                             | P0  | CNT-002                   | BACKLOG | Solo editor/admin; comentarios; historial      | app/admin/revision    | E2E, DB |
| CNT-004 | Importación CSV/JSON (skill importar-preguntas)                                                    | P0  | CNT-002                   | BACKLOG | Dry-run, informe, todo en draft                | lib/content/import.ts | U, DB   |
| CNT-005 | Temario: lecciones, esquemas, resúmenes (Markdown seguro)                                          | P1  | CNT-001                   | BACKLOG | Estados editoriales; referencias               | migración 0600        | DB, E2E |
| CNT-006 | Flashcards y favoritos                                                                             | P2  | CNT-005                   | BACKLOG | —                                              | —                     | E2E     |
| CNT-007 | Primer contenido piloto revisado                                                                   | P0  | DEC-001, DEC-002, CNT-003 | BACKLOG | Oposición piloto pasa a `partial` honestamente | contenido             | manual  |

## Épica E4 · Entrenamiento (Hito 4)

| ID      | Descripción                                            | P   | Dep.                       | Estado  | Criterios de aceptación                               | Archivos                     | Pruebas |
| ------- | ------------------------------------------------------ | --- | -------------------------- | ------- | ----------------------------------------------------- | ---------------------------- | ------- |
| LRN-001 | Migración práctica: sesiones, respuestas, estadísticas | P0  | FND-005                    | BACKLOG | RLS; corrección en servidor                           | migración 0400               | DB      |
| LRN-002 | Demo gratuita en la landing (get_demo_questions)       | P1  | LRN-001, CNT-007 o PSY-001 | BACKLOG | Sin registro; sin exponer respuesta                   | components/demo              | E2E     |
| LRN-003 | Test por tema con explicación tras responder           | P0  | LRN-001                    | BACKLOG | Flujo completo; registro de actividad                 | app/app/practica             | E2E     |
| LRN-004 | Repaso inteligente (SM-2) de errores                   | P1  | LRN-003                    | BACKLOG | Programación determinista testeada                    | lib/learning/srs.ts          | U       |
| LRN-005 | Estadísticas del alumno (aciertos, racha, tiempo)      | P1  | LRN-003                    | BACKLOG | Datos reales en dashboard                             | lib/learning/stats.ts        | U, E2E  |
| PSY-001 | Framework de generadores con semilla + verificador     | P0  | —                          | READY   | Propiedad: 1.000 semillas verifican                   | lib/learning/psycho          | U       |
| PSY-002 | Series numéricas y de letras                           | P0  | PSY-001                    | BACKLOG | Única respuesta                                       | psycho/series.ts             | U       |
| PSY-003 | Matrices/figuras (SVG), cubos y espaciales             | P1  | PSY-001                    | BACKLOG | Accesible + verificable                               | psycho/*                     | U       |
| PSY-004 | Verbales, atención y lógica                            | P1  | PSY-001                    | BACKLOG | —                                                     | psycho/*                     | U       |
| PSY-005 | UI de psicotécnicos con temporizador                   | P0  | PSY-002                    | BACKLOG | Móvil; pausa; accesible                               | app/app/psicotecnicos        | E2E     |
| MOC-001 | Simulacro con configuración de `exam_tests`            | P0  | LRN-003                    | BACKLOG | Tiempo, nº preguntas, penalización de la convocatoria | app/app/simulacros           | U, E2E  |
| MOC-002 | Historial, evolución y repetición de errores           | P1  | MOC-001                    | BACKLOG | —                                                     | —                            | E2E     |
| GAM-001 | Rachas, XP, niveles, logros, retos (sobrios)           | P2  | LRN-005                    | BACKLOG | Sin elementos infantiles                              | lib/learning/gamification.ts | U       |

## Épica E5 · Negocio (Hito 5)

| ID      | Descripción                                                             | P   | Dep.             | Estado  | Criterios de aceptación                | Archivos               | Pruebas    |
| ------- | ----------------------------------------------------------------------- | --- | ---------------- | ------- | -------------------------------------- | ---------------------- | ---------- |
| BIZ-001 | Migración planes/precios configurables/suscripciones/entitlements       | P0  | FND-003          | BACKLOG | `has_premium()` en servidor            | migración 0500         | DB         |
| BIZ-002 | Stripe test: checkout + portal                                          | P0  | BIZ-001, DEC-003 | BACKLOG | Solo claves test                       | lib/billing            | E2E (mock) |
| BIZ-003 | Webhooks firmados: alta, renovación, cancelación, pago fallido          | P0  | BIZ-002          | BACKLOG | Idempotentes                           | app/api/stripe/webhook | U          |
| BIZ-004 | Control de acceso Premium en servidor y límites del plan gratuito       | P0  | BIZ-001          | BACKLOG | Nada Premium accesible sin entitlement | lib/billing/access.ts  | DB, E2E    |
| BIZ-005 | Métricas comerciales en admin (Premium, MRR, conversión, cancelaciones) | P1  | BIZ-003          | BACKLOG | Reales                                 | lib/admin              | U          |
| BIZ-006 | Precio editable desde admin                                             | P1  | BIZ-001          | BACKLOG | Auditado                               | app/admin/precios      | E2E        |
| MKT-001 | Cupones y promociones                                                   | P2  | BIZ-002          | BACKLOG | —                                      | —                      | —          |
| MKT-002 | SEO: sitemap, robots, metadatos por idioma, datos estructurados         | P1  | FND-009          | BACKLOG | Lighthouse SEO ≥ 95                    | app/sitemap.ts         | E2E        |
| MKT-003 | Landing pages por oposición y recursos gratuitos                        | P2  | CNT-007          | BACKLOG | —                                      | —                      | —          |

## Épica E6 · Inteligencia (Hito 6)

| ID     | Descripción                                        | P   | Dep.             | Estado  | Criterios de aceptación                           | Archivos             | Pruebas |
| ------ | -------------------------------------------------- | --- | ---------------- | ------- | ------------------------------------------------- | -------------------- | ------- |
| AI-001 | Tutor IA con RAG sobre contenido publicado y citas | P1  | CNT-007, BIZ-004 | BACKLOG | No inventa; dice cuando no sabe; límites por plan | lib/ai               | U       |
| AI-002 | Registro de uso y límites (`ai_usage`)             | P1  | AI-001           | BACKLOG | —                                                 | migración 0700       | DB      |
| AI-003 | Plan adaptativo y recomendaciones                  | P1  | LRN-005          | BACKLOG | —                                                 | lib/learning/plan.ts | U       |
| AI-004 | Asistente de redacción de borradores para editores | P2  | CNT-002          | BACKLOG | Siempre draft + ai_generated                      | —                    | U       |

## Épica E7 · Calidad (Hito 7)

| ID       | Descripción                                         | P                  | Dep.           | Estado  | Criterios de aceptación               | Archivos              | Pruebas |
| -------- | --------------------------------------------------- | ------------------ | -------------- | ------- | ------------------------------------- | --------------------- | ------- |
| SEC-001  | CSP con nonces                                      | P1                 | —              | BACKLOG | Sin inline scripts no autorizados     | proxy.ts              | E2E     |
| SEC-002  | Rate limiting compartido (BD/Redis)                 | P1                 | —              | BACKLOG | Funciona con varias instancias        | lib/rate-limit.ts     | U       |
| SEC-003  | Consentimiento de cookies (si se añade analítica)   | P1                 | MKT-002        | BACKLOG | —                                     | —                     | E2E     |
| SEC-004  | Registro de errores sin PII                         | P1                 | —              | BACKLOG | —                                     | —                     | —       |
| SEC-005  | Backups y prueba de restauración                    | P1                 | DEC-003        | BACKLOG | Documentado                           | DEPLOYMENT.md         | manual  |
| SEC-006  | MFA para staff                                      | P2                 | —              | BACKLOG | —                                     | —                     | E2E     |
| QA-001   | CI (GitHub Actions): typecheck, lint, unit, db, e2e | P1                 | DEC-003 (repo) | BACKLOG | Verde en cada PR                      | .github/workflows     | —       |
| QA-002   | Rendimiento: Lighthouse móvil ≥ 90                  | P1                 | —              | BACKLOG | —                                     | —                     | —       |
| QA-003   | Pruebas E2E en catalán y modo oscuro                | P2                 | —              | BACKLOG | —                                     | tests/e2e             | E2E     |
| QA-004   | axe-core en Playwright                              | P1                 | —              | READY   | 0 violaciones serias en páginas clave | tests/e2e             | E2E     |
| I18N-001 | Formato de fechas/números por idioma revisado       | P2                 | —              | BACKLOG | —                                     | —                     | —       |
| I18N-002 | Rutas localizadas en catalán (pathnames)            | P2                 | —              | BACKLOG | /ca/oposicions                        | i18n/routing.ts       | E2E     |
| PERF-001 | Caché de catálogo (revalidación por etiqueta)       | P2                 | —              | BACKLOG | —                                     | —                     | —       |
| PERF-002 | Reevaluar Cache Components (Next 17)                | P2                 | —              | BACKLOG | ADR actualizado                       | next.config.ts        | build   |
| LEG-001  | Textos legales definitivos (revisión profesional)   | P0 antes de lanzar | DEC-004        | BLOCKED | Revisados por profesional             | docs/legal, app/legal | —       |
| LEG-002  | Páginas legales con contenido final                 | P1                 | LEG-001        | BACKLOG | —                                     | app/(site)/legal      | E2E     |

## Épica E8 · Lanzamiento (Hito 8)

| ID      | Descripción                    | P   | Dep.             | Estado  | Criterios de aceptación | Archivos      | Pruebas |
| ------- | ------------------------------ | --- | ---------------- | ------- | ----------------------- | ------------- | ------- |
| LAU-001 | Despliegue de prueba (preview) | P0  | DEC-003          | BLOCKED | Requiere autorización   | DEPLOYMENT.md | smoke   |
| LAU-002 | Usuarios piloto y feedback     | P1  | LAU-001          | BACKLOG | —                       | —             | —       |
| LAU-003 | Producción                     | P0  | LAU-002, LEG-001 | BLOCKED | Requiere autorización   | —             | smoke   |

---
name: nueva-funcionalidad
description: Implementa una funcionalidad completa de extremo a extremo (BD + servidor + UI + i18n + pruebas + docs) a partir de una tarea de TASKS.md.
argument-hint: "<ID de tarea, p. ej. USR-004>"
---

# Nueva funcionalidad end-to-end

**Cuándo usarla:** al empezar una tarea READY de TASKS.md que atraviesa varias capas.

**Entradas:** ID de la tarea ($ARGUMENTS). Criterios de aceptación de TASKS.md.

## Procedimiento
1. Lee la tarea en TASKS.md y pásala a IN_PROGRESS. Revisa dependencias (deben estar DONE).
2. Diseño breve: tablas/funciones, rutas, componentes, mensajes. Si hay decisión relevante, ADR en docs/DECISIONS.md.
3. Base de datos (si aplica): nueva migración en supabase/migrations con RLS → `npm run db:migrate` → tests en tests/db.
4. Servidor: lógica en src/lib/<dominio>/ (schema Zod en archivo aparte; actions con "use server" solo exportan funciones async).
5. UI: páginas en src/app/[locale]/(site)/..., componentes en src/components; textos en messages/es.json y messages/ca.json.
6. Estados de carga, vacío y error; responsive; accesibilidad.
7. Pruebas: unitarias de la lógica + E2E del flujo principal en tests/e2e.
8. Actualiza docs afectados (DATABASE, ARCHITECTURE, PRD) y SESSION_HANDOFF.

## Validaciones
`npm run check` · `npm run test:db` · `npx playwright test` (con la pila local en marcha).

## Resultado esperado y criterio de finalización
Todos los criterios de aceptación cumplidos y verificados, pruebas en verde, tarea en DONE con fecha, commit descriptivo.

---
name: pruebas-regresion
description: Ejecuta la batería completa de regresión (tipos, lint, unitarias, RLS, E2E escritorio y móvil) contra la pila local y resume resultados.
---

# Pruebas de regresión

**Cuándo usarla:** antes de mover tareas a DONE, antes de cerrar un hito o tras refactorizaciones.

## Procedimiento
1. `npm run stack:start` (si no está en marcha) y `npm run db:migrate`.
2. `npm run check` (typecheck + lint + unitarias).
3. `npm run test:db`.
4. `npx playwright test` (en el contenedor cloud: `PW_CHROMIUM_PATH=/opt/pw-browsers/chromium`).
5. Si algo falla: reproducir, encontrar causa raíz, corregir. Nunca saltar tests.
6. `npm run build` para verificar que la app compila para producción.

## Validaciones
Todo en verde; tiempos de E2E razonables (< 3 min).

## Resultado esperado y criterio de finalización
Resumen con recuentos por suite registrado en docs/SESSION_HANDOFF.md (sección Pruebas).

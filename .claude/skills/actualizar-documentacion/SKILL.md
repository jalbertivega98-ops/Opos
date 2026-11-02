---
name: actualizar-documentacion
description: Cierra un bloque de trabajo actualizando TASKS.md, SESSION_HANDOFF.md, DECISIONS.md y la documentación afectada para poder reanudar en otra sesión.
---

# Actualizar documentación y estado

**Cuándo usarla:** al terminar cada bloque de trabajo y siempre antes de detenerse.

## Procedimiento
1. TASKS.md: mover estados (solo DONE si criterios + pruebas cumplidos), añadir tareas descubiertas, registrar bloqueos.
2. docs/DECISIONS.md: ADR por cada decisión técnica tomada.
3. Docs afectados por los cambios (DATABASE, ARCHITECTURE, SECURITY, DEPLOYMENT, DESIGN_SYSTEM).
4. docs/SESSION_HANDOFF.md: fecha, estado exacto, últimos cambios (commits), resultados de pruebas, bloqueos, siguiente tarea concreta.
5. CLAUDE.md solo si cambian reglas o estructura (mantenerlo conciso).
6. Commit local descriptivo.

## Validaciones
Un lector sin contexto puede retomar el trabajo leyendo CLAUDE.md → SESSION_HANDOFF.md → TASKS.md.

## Resultado esperado y criterio de finalización
Docs al día y commit realizado.

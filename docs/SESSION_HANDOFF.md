# SESSION HANDOFF

**Última actualización:** 2026-11-02 · Sesión 1

## Estado exacto

- **Hito 0** (organización) y **Hito 1** (fundación): completados.
- **Hito 2** (usuarios): registro, onboarding, perfil, RGPD (exportar/borrar), dashboard base y admin de alumnos (búsqueda, filtros, ficha, suspensión, CSV auditado) hechos. Falta: gestionar varias oposiciones (USR-005), cambio de rol en UI (ADM-004), plan inicial (USR-004).
- **Hito 4** adelantado: generador de series numéricas verificable + demo pública `/psicotecnicos`.
- **Oposición piloto: Mossos d'Esquadra** (decisión de joel).
- Rama `main`, sin remoto. Copia en `/mnt/project-files/aprobia/` (`aprobia.bundle`, `aprobia-src.tar.gz`).

## Cómo reanudar

```bash
git clone /mnt/project-files/aprobia/aprobia.bundle academia && cd academia
npm ci && npm run stack:setup
npm run stack:start -- --seed
node scripts/stack/keys.mjs   # crear .env.local según .env.example (+ AUTH_RATE_LIMIT_MAX=1000 para E2E)
npm run dev
```

Contenedor cloud: E2E con `PW_CHROMIUM_PATH=/opt/pw-browsers/chromium npx playwright test`. Si un servicio de la pila queda colgado: `pkill -x postgrest` / `pkill -x auth`, borrar su `.local-stack/*.pid` y `npm run stack:start`. No usar `pkill -f "next dev"` (mata la propia shell).

## Últimos commits

- feat(admin): gestión de alumnos…
- feat(usuarios): perfil, exportación y eliminación (RGPD)
- docs: organización del proyecto (Hito 0)
- feat: fundación del proyecto (Hito 1)
- feat(psicotécnicos): series numéricas verificables + demo

## Pruebas (último run)

typecheck ✅ · lint ✅ · build ✅ · unitarias 40/40 ✅ · RLS 27/27 ✅ · E2E 19/19 ✅ (escritorio + móvil)

## Bloqueos (TASKS.md › Bloqueos)

DEC-002 revisor de contenido · DEC-003 cuentas externas (Supabase cloud, Stripe test, despliegue, repo GitHub) · DEC-004 datos legales · DEC-005 nombre comercial.

## Siguiente tarea

1. **LRN-001** migración de práctica (sesiones/respuestas) y guardar resultados de psicotécnicos de alumnos registrados → estadísticas reales en dashboard (LRN-005).
2. **PSY-003/004** más tipos de psicotécnicos (series de letras, matrices, espaciales) — relevantes para Mossos.
3. **content-researcher**: fuentes oficiales de la convocatoria vigente de Mossos (DOGC) → ficha con pruebas verificadas (skill `anadir-oposicion`).
4. **CNT-002/003** editor de preguntas y cola de revisión.

## Notas técnicas

- Next 16: middleware = `src/proxy.ts`; leer `node_modules/next/dist/docs` antes de usar APIs nuevas.
- next-intl no admite puntos en claves de mensajes.
- GoTrue local necesita `GOTRUE_JWT_DEFAULT_GROUP_NAME=authenticated` y `MAILER_URLPATHS_*=/auth/v1/verify`; PostgREST con `db-config=false`.
- Archivos "use server" solo exportan funciones async (esquemas en archivos aparte).

# SESSION HANDOFF

**Última actualización:** 2026-11-02 · Sesión 1 (Hito 0 + Hito 1 + parte del Hito 2)

## Estado exacto

- Hito 0 (organización) y Hito 1 (fundación) **completados**. Hito 2 iniciado: onboarding, dashboard base y panel admin base hechos.
- App ejecutable en local con auth real (emails en Mailpit), catálogo de 12 oposiciones (todas "Próximamente", sin datos inventados), onboarding, dashboard con actividad real y admin con KPIs reales.
- Rama `main`, sin repositorio remoto (joel no tiene repo para este proyecto aún). Copia de seguridad en `/mnt/project-files/aprobia/` (bundle Git + código).

## Cómo reanudar

```bash
# si el contenedor es nuevo: restaurar
git clone /mnt/project-files/aprobia/aprobia.bundle academia && cd academia
npm ci && npm run stack:setup
npm run stack:start -- --seed
node scripts/stack/keys.mjs   # crear .env.local según .env.example (+ AUTH_RATE_LIMIT_MAX=1000 para E2E)
npm run dev
```

En el contenedor cloud: E2E con `PW_CHROMIUM_PATH=/opt/pw-browsers/chromium npx playwright test`. Si la pila falla al reiniciar procesos, `pkill -x postgrest` / `pkill -x auth` y repetir `npm run stack:start`.

## Últimos cambios

- Proyecto Next.js 16.4 + pila local sin Docker (ADR-003).
- Migraciones 0100 identidad · 0200 catálogo · 0300 banco de preguntas (con RLS y reglas editoriales en BD).
- Auth completa, i18n es/ca, sistema de diseño, landing, catálogo, onboarding, dashboard, admin.
- `.claude/`: 8 agentes, 11 skills, 5 hooks, permisos. Documentación completa en `docs/`.

## Pruebas (último run)

- `npm run typecheck` ✅ · `npm run lint` ✅ · `npm run build` ✅
- Unitarias: 29/29 ✅ · RLS (`npm run test:db`): 18/18 ✅ · E2E Playwright: 14/14 ✅ (escritorio + móvil)

## Bloqueos

Ver TASKS.md › Bloqueos (DEC-001..005): oposición piloto, revisor de contenido, autorización de cuentas externas (Supabase cloud, Stripe test, despliegue, repo GitHub), datos legales del titular, nombre comercial.

## Siguiente tarea

1. **USR-007 → USR-008 → USR-009** (perfil, exportar datos, eliminar cuenta: RGPD, camino crítico).
2. **ADM-001** listado de alumnos con búsqueda/filtros.
3. En paralelo (independiente): **PSY-001/002** generadores de psicotécnicos verificables y **QA-004** axe-core.

## Notas técnicas

- Next 16: el middleware es `src/proxy.ts`; leer `node_modules/next/dist/docs` antes de usar APIs nuevas.
- next-intl no admite puntos en claves de mensajes (usa objetos anidados).
- GoTrue local necesita `GOTRUE_JWT_DEFAULT_GROUP_NAME=authenticated` y `MAILER_URLPATHS_*=/auth/v1/verify`; PostgREST con `db-config=false`.

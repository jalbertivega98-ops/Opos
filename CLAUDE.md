# OPOSAPRUEBA · Academia digital de oposiciones

Plataforma SaaS (marca OPOSAPRUEBA; antes «Aprobia», ADR-023) para preparar oposiciones en España, gestionada por una sola persona (joel) con ayuda de IA. Multioposición, freemium, es/ca.

@AGENTS.md

## Al empezar cada sesión

1. Lee `docs/SESSION_HANDOFF.md` (estado exacto y siguiente tarea) y `TASKS.md`.
2. `git status` / `git log -5`. Arranca la pila: `npm run stack:start` (y `npm run dev`).
3. Continúa con la siguiente tarea READY de mayor prioridad del camino crítico.

## Al terminar cada bloque

Pruebas en verde → `TASKS.md` → `docs/DECISIONS.md` (ADR) → `docs/SESSION_HANDOFF.md` → commit local. Skill: `actualizar-documentacion`.

## Arquitectura (detalle en docs/ARCHITECTURE.md)

- Next.js 16 App Router + TypeScript estricto + Tailwind 4 + componentes propios estilo shadcn (`src/components/ui`).
- Supabase: Postgres + Auth + RLS. Migraciones SQL en `supabase/migrations` (compatibles con Supabase CLI). Seed en `supabase/seed.sql`.
- Local sin Docker: `scripts/stack/*` (Postgres 16 + GoTrue + PostgREST + Mailpit + pasarela :54321).
- i18n: next-intl, rutas `/[locale]` con prefijo solo para `ca`. Textos en `messages/{es,ca}.json` (siempre ambos).
- Middleware = `src/proxy.ts` (Next 16): idioma + refresco de sesión + protección de `/app` y `/admin`.

## Convenciones

- Server Components por defecto. Mutaciones con Server Actions en `src/lib/<dominio>/actions.ts` ("use server": solo exporta funciones async); esquemas Zod en `schema(s).ts`.
- Toda entrada se valida con Zod en servidor. Sesión con `supabase.auth.getUser()`, nunca `getSession()` en servidor.
- Cambios de BD = migración nueva + RLS + test en `tests/db`. Nunca editar migraciones ya desplegadas.
- Nombres de código en inglés; textos de UI, docs y commits en castellano.
- Imports con `@/`. Sin `any`. Prettier + ESLint (el hook formatea al editar).

## Seguridad (docs/SECURITY.md)

- RLS en todas las tablas. Respuestas correctas solo vía funciones SECURITY DEFINER.
- `SUPABASE_SERVICE_ROLE_KEY` solo en módulos `server-only`. Ningún secreto en el repo (hook `secret-guard`).
- Redirecciones solo internas (`safeNextPath`). Rate limiting en formularios de auth.

## Diseño (docs/DESIGN_SYSTEM.md)

Azul marino + blanco + gris claro + turquesa, modo oscuro, mobile first, WCAG 2.2 AA. Sin logos oficiales ni sugerir vinculación institucional. Gamificación sobria.

## Contenido (docs/CONTENT_POLICY.md)

Solo fuentes oficiales. Nada se inventa. Lo generado por IA entra como `draft` y requiere revisión humana. No anunciar como disponible una oposición sin contenido revisado.

## Autonomía

Puedes programar, instalar dependencias confiables, testear, refactorizar, documentar y hacer commits locales sin preguntar.
**Pide autorización a joel antes de:** gastar dinero, cobros/suscripciones reales, producción, emails reales, conectar cuentas externas (Supabase cloud, Stripe, GitHub), modificar otros proyectos, borrar datos importantes o cualquier acción irreversible.

## Calidad (definición de DONE)

Funciona de extremo a extremo · validación · errores · seguridad · responsive · estados de carga/vacío · pruebas · docs. Antes de cerrar: `npm run check && npm run test:db && npx playwright test`.

## Comandos

`npm run dev` · `npm run stack:start|stop` · `npm run db:migrate` · `npm run db:reset` · `npm run check` · `npm run test:db` · `npx playwright test` · `npm run admin:grant -- <email> admin`

## Agentes y skills

Subagentes en `.claude/agents` (product-architect, frontend-designer, backend-engineer, learning-engineer, content-researcher, security-reviewer, qa-engineer, business-engineer). Skills en `.claude/skills`. Delegar en paralelo solo tareas independientes que no editen los mismos archivos.

## Documentación

`docs/`: PRODUCT_VISION, PRD, ARCHITECTURE, DATABASE, DESIGN_SYSTEM, ROADMAP, DECISIONS, CONTENT_POLICY, SECURITY, DEPLOYMENT, SESSION_HANDOFF, legal/. Tareas: `TASKS.md`.

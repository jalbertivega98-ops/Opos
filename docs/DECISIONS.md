# Registro de decisiones (ADR)

## ADR-001 · Stack principal (2026-11-02)

**Decisión:** Next.js 16 (App Router) + TypeScript + Tailwind 4 + Supabase (Postgres/Auth/RLS) + Zod + next-intl + Vitest + Playwright; Stripe en Hito 5.
**Motivo:** stack preferido por joel; un solo lenguaje; Supabase da auth + BD + RLS gestionados, ideal para una persona.
**Consecuencias:** autorización en BD (RLS) como fuente de verdad.

## ADR-002 · Marca provisional "Aprobia" (2026-11-02)

**Decisión:** nombre neutro derivado de "aprobar", logo monograma sin simbología policial ni institucional.
**Pendiente:** comprobar disponibilidad de marca (OEPM/EUIPO) y dominio antes del lanzamiento (requiere a joel).

## ADR-003 · Pila local compatible con Supabase sin Docker (2026-11-02)

**Contexto:** en el contenedor cloud Docker funciona pero no puede descargar imágenes (Docker Hub 429, ECR/GHCR 403), así que `supabase start` no es viable. Sí se pueden descargar binarios de GitHub Releases.
**Decisión:** `scripts/stack/` con PostgreSQL 16 del sistema + binarios oficiales de GoTrue (supabase/auth v2.180.0), PostgREST v13.0.4 y Mailpit v1.27.10, más una pasarela Node que reproduce las rutas `/auth/v1` y `/rest/v1`. `bootstrap.sql` crea roles de Supabase (anon, authenticated, service_role, authenticator, supabase_auth_admin).
**Consecuencias:** E2E reales (emails incluidos) sin servicios externos. Las migraciones siguen siendo compatibles con Supabase CLI. Diferencias: sin Storage/Realtime/Edge Functions locales (no se usan aún).

## ADR-004 · Middleware en `src/proxy.ts` (2026-11-02)

Next 16 renombra `middleware` a `proxy` (runtime Node). Combina next-intl y el refresco de sesión de Supabase.

## ADR-005 · Componentes estilo shadcn escritos a mano (2026-11-02)

El registro `ui.shadcn.com` está bloqueado por la política de red del entorno. Se replican los patrones (Radix + CVA + `cn`) en `src/components/ui`. `npx shadcn add` puede usarse más adelante en un entorno con acceso.

## ADR-006 · i18n con prefijo solo para catalán (2026-11-02)

`localePrefix: "as-needed"`: castellano en `/`, catalán en `/ca`. Slugs en castellano en ambos idiomas por ahora (I18N-002 para localizarlos).

## ADR-007 · Cache Components desactivado (2026-11-02)

El scaffold de Next 16.4 activa `cacheComponents`. Casi todas las páginas dependen de cookies (sesión) y la integración con next-intl añade complejidad. Se desactiva y se reevaluará antes de Next 17 (tarea PERF-002).

## ADR-008 · Respuestas correctas solo en servidor (2026-11-02)

Alumnos y anon no tienen acceso a `questions`/`question_options`; el consumo se hace mediante funciones SECURITY DEFINER que omiten `is_correct` y corrigen en servidor.

## ADR-009 · Publicación solo con revisión humana, garantizada en BD (2026-11-02)

Trigger de transición de estados + `reviewed_by` obligatorio para publicar. Cumple la regla "contenido IA nunca se publica automáticamente como verificado".

## ADR-010 · Seed sin datos de convocatorias (2026-11-02)

El seed solo incluye nombres de organismos y cuerpos públicos; todas las oposiciones como `coming_soon`. Fechas, plazas, requisitos y URLs se añadirán con fuentes verificadas.

## ADR-011 · Integraciones MCP (2026-11-02)

Evaluadas: GitHub (ya disponible en el entorno, sin repositorio asignado a este proyecto), Supabase MCP (requiere cuenta → autorización), Stripe MCP (requiere cuenta → autorización), Playwright (se usa la librería directamente; MCP innecesario). No se añade `.mcp.json` hasta que joel autorice conectar cuentas.

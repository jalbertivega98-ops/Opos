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

## ADR-012 · Psicotécnicos generados con semilla y corrección por regeneración (2026-11-02)

**Decisión:** los generadores son funciones puras `generate(seed, difficulty)`. El cliente recibe solo la vista pública (términos y opciones); el servidor corrige regenerando el ítem desde la semilla.
**Motivo:** respuesta nunca expuesta antes de contestar, sin almacenar ítems, reproducible para auditoría y tests de propiedades (5.000 semillas verificadas sin ambigüedad).
**Consecuencias:** cuando exista historial (LRN-001) se guardará `(tipo, seed, difficulty, elección, acierto, tiempo)`.

## ADR-013 · Funciones de administración sobre auth.users (2026-11-02)

El email del alumno vive en `auth.users`, no expuesto por la API. El panel lo consulta mediante funciones SECURITY DEFINER (`admin_list_users`, `admin_get_user`, `admin_set_user_status`) que exigen `is_admin()` y registran en `audit_log`. Sin service role en la app.

## ADR-014 · Resultados de práctica escritos solo por el servidor (2026-11-02)

**Decisión:** el alumno solo lee sus resultados (RLS). Las escrituras pasan por funciones SQL ejecutables solo por `service_role`, llamadas desde Server Actions después de corregir regenerando el ítem desde la semilla y comprobar que lo mostrado coincide (`samePresentation`). El tiempo lo mide la BD.
**Motivo:** con escritura directa o RPC accesible al alumno se podrían falsear aciertos y tiempos (y en el futuro rankings).
**Consecuencias:** primer uso del cliente service role (`src/lib/supabase/service.ts`, `server-only`), limitado a esas dos funciones. Los resultados anónimos de la demo nunca se guardan ni se asocian a una cuenta.

## ADR-015 · La titular aprueba el contenido (DEC-002) (2026-11-02)

Aprobar, rechazar, publicar y archivar exigen rol `owner` en la base de datos, no solo en la interfaz. Editores y admins redactan, importan (siempre como borrador) y envían a revisión. Los generadores de psicotécnicos no pasan por este flujo porque su solución es verificable automáticamente (ADR-012).

## ADR-016 · Tienda basada en concesiones de acceso (2026-11-02)

**Decisión:** todo acceso a contenido de pago se resuelve con `has_product_access()` sobre `access_grants` y `subscriptions`. Compras (Stripe, cuando se autorice), suscripción Premium y concesiones manuales crean concesiones; la app no conoce la pasarela.
**Motivo:** un único punto de control, pruebas sin pagos reales y cambio de pasarela sin tocar el contenido. Un único banco de preguntas alimenta packs, simulacros y PDF (`product_items`).
**Consecuencias:** los pedidos se conservan sin datos personales al borrar la cuenta (obligaciones contables). Los precios se guardan en céntimos con histórico.

## ADR-017 · Registro de generadores de psicotécnicos (2026-11-02)

Contrato común `PsychoGenerator { generate, verify }` con presentación genérica (`sequence`, `text`, `analogy`, `matrix`, `figure`, `grid`) y tokens (`w:` palabra traducible, `g:` figura SVG, `p:` pieza). Siete tipos: series, letras (27 letras con Ñ), numérico, analogías (vocabulario curado es/ca), matrices (reglas por atributo con detección de ambigüedad), espacial (piezas quirales sin simetría) y atención. Cada verificador recalcula la solución y rechaza ítems ambiguos u opciones duplicadas; los tests manipulan soluciones para comprobar que se detectan.

## ADR-018 · Identidad visual «cuaderno con método» y panel en dos niveles (2026-11-03)

**Decisión:** a petición de joel, rediseño de portada y panel del alumno sin dependencias nuevas: tokens `highlight` (marcador) e `ink` (franjas marinas), fondo cuadriculado, componentes `Section`/`SectionHeader`, `IconBadge`, `ProgressRing`/`Meter`/`DayBars` y `AppNav`. El panel prioriza «Continuar practicando», progreso y repaso de errores; lo demás pasa a «Más opciones». El turquesa se oscurece a #0A7A70 para cumplir AA.
**Motivo:** todo eran tarjetas iguales con texto; no quedaba claro dónde mirar ni qué hacer.
**Consecuencias:** las demás pantallas se migrarán al mismo sistema tras la revisión de joel. La rama del rediseño no se despliega sola en Vercel (`vercel.json`, `git.deploymentEnabled` para `claude/**`). La portada no muestra testimonios ni cifras; los valores de ejemplo van marcados como tales.

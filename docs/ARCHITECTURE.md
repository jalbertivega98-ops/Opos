# Arquitectura

## Vista general

```
Navegador (React 19, PWA)
   │  HTML/RSC + Server Actions
   ▼
Next.js 16 (App Router, Node runtime)
   ├─ src/proxy.ts ........ idioma (next-intl) + refresco de sesión Supabase + guarda de /app y /admin
   ├─ src/app/[locale]/(site)/...  páginas (Server Components)
   ├─ src/app/auth/{callback,confirm}  enlaces de email (PKCE / token_hash)
   └─ src/lib/<dominio>/  lógica de servidor (actions, queries, schemas Zod)
   │  supabase-js con la sesión del usuario (cookies) → RLS
   ▼
Supabase: GoTrue (Auth) · PostgREST · PostgreSQL (RLS, funciones SECURITY DEFINER)
   (futuro) Stripe webhooks · proveedor IA · email transaccional
```

## Decisiones clave

- **Servidor primero**: las páginas consultan datos en Server Components; las mutaciones son Server Actions validadas con Zod. El cliente solo hidrata formularios e interacción.
- **Autorización en la BD**: RLS es la fuente de verdad; las comprobaciones en servidor (`requireUser`, `requireAdmin`) son defensa en profundidad y mejor UX.
- **Sin service role por defecto**: todo con la sesión del usuario. La clave de servicio solo para webhooks/tareas de sistema (server-only).
- **Catálogo configurable**: añadir una oposición = filas en BD, sin código.
- **Contenido reutilizable**: `topics` y `questions` se vinculan a varias oposiciones/convocatorias mediante tablas puente.

## Estructura de carpetas

```
src/
  app/
    [locale]/layout.tsx           <html>, fuentes, tema, NextIntlClientProvider
    [locale]/(site)/layout.tsx    cabecera + pie
    [locale]/(site)/(auth)/...    entrar, registro, recuperar, restablecer, verifica-tu-correo
    [locale]/(site)/app/...       zona alumno (layout con requireUser)
    [locale]/(site)/admin/...     zona admin (requireAdmin)
    [locale]/(site)/oposiciones/  catálogo público
    auth/callback, auth/confirm   route handlers de Auth
  components/ui/                  primitivas del sistema de diseño
  components/                     componentes de producto
  i18n/                           routing, request, navigation (next-intl)
  lib/
    supabase/ server.ts · client.ts · session.ts (proxy)
    auth/ actions.ts · schemas.ts · session.ts
    catalog/ queries.ts · search.ts
    onboarding/ actions.ts · schema.ts
    admin/ metrics.ts
    paths.ts · rate-limit.ts · env.ts · utils.ts
messages/{es,ca}.json
supabase/migrations/*.sql · seed.sql
scripts/stack/                    pila local sin Docker
tests/unit · tests/db · tests/e2e
```

## Autenticación

- Email + contraseña con verificación obligatoria (GoTrue `MAILER_AUTOCONFIRM=false`).
- Flujo PKCE: `signUp`/`resetPasswordForEmail` con `emailRedirectTo=/auth/callback?next=...` → `exchangeCodeForSession`.
- Producción recomendada: plantillas de email con `/auth/confirm?token_hash=...&type=...` (funciona entre dispositivos).
- Sesión en cookies httpOnly gestionadas por `@supabase/ssr`; el proxy la refresca en cada petición.
- Perfil creado por trigger `handle_new_user` (idioma y nombre desde metadata).

## Internacionalización

next-intl 4 con `localePrefix: "as-needed"` (es sin prefijo, `/ca/...`). Rutas con slugs en castellano para ambos idiomas (pendiente: pathnames localizados, I18N-002). Contenido de BD con columnas `_ca` opcionales; el banco de preguntas usa `locale` por fila.

## Motor educativo (Hito 4)

- **Práctica** (`src/lib/learning/practice`): `startPracticeAction` genera los ítems en servidor y crea la sesión; `answerPracticeAction` lee el ítem con la sesión del alumno (RLS), regenera, comprueba que coincide con lo mostrado, corrige y registra con service role (ADR-014). Repaso de fallos: mismos ítems (misma semilla). Estadísticas con `my_practice_stats`.
- **Psicotécnicos** (`src/lib/learning/psycho`): registro de 7 generadores deterministas con verificador (ADR-017). UI genérica `components/psycho/{trainer,stem,token,review}.tsx`.
- **Rutas:** `/psicotecnicos` (demo anónima, no guarda nada), `/app/practica`, `/app/practica/[id]`, `/app/progreso`, `/app/productos`.
- Pendiente: práctica con preguntas del banco y simulacros (`mode = questions/mock`, corrección en SQL, configuración de `exam_tests.scoring`), SM-2 para preguntas.

## Contenido (Hito 3)

`src/lib/admin/content`: esquema Zod compartido, huella anti-duplicados, parser CSV/JSON (sin dependencias) y acciones. Panel: `/admin/preguntas` (lista y filtros), `/admin/preguntas/nueva|[id]` (editor + flujo + historial), `/admin/preguntas/importar`, `/admin/revision` (cola de la titular). Permisos reforzados en BD (ADR-015).

## Tienda (Hito 5, sin pagos reales)

`src/lib/store`: productos, precios (céntimos con histórico), contenido desde el banco, concesiones manuales y listado de compras. Panel: `/admin/productos`, `/admin/compras`. Alumno: `/app/productos` («Mis productos»).

Flujo previsto con Stripe test (STO-008, requiere autorización): checkout → webhook firmado e idempotente → `orders` + `access_grants` (o `subscriptions`) → `has_product_access()` decide. Los PDF se generarán desde las mismas preguntas del pack y se servirán con URL firmada de Storage privado.

## Entorno local

`scripts/stack/start.sh` levanta Postgres 16 (:54322), GoTrue (:9999), PostgREST (:3001), Mailpit (:54324/:54325) y una pasarela (:54321) que imita las rutas de Supabase. Motivo: en el entorno cloud Docker no puede descargar imágenes (ADR-003). Con Docker disponible, `supabase start` es equivalente (las migraciones son compatibles).

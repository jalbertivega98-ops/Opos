# Preview privada (Vercel + Supabase, planes gratuitos)

Para probar la app desde cualquier navegador **sin publicarla**: web protegida con contraseña (`PREVIEW_PASSWORD`), marcada `noindex`, solo con datos de prueba, sin Stripe ni emails reales. Autorizado por joel el 2026-11-03 (DEC-003, alcance: preview).

## 1. Supabase

1. supabase.com → Continue with GitHub → New project `aprobia-preview`, región Central EU (Frankfurt), plan Free.
2. SQL Editor → New query → pegar `supabase/preview/1-esquema-y-contenido.sql` → Run.
3. Authentication → Users → Add user → Create new user: `admin@aprobia.test` y `alumna@aprobia.test`, marcando **Auto Confirm User**.
4. SQL Editor → pegar `supabase/preview/2-cuentas.sql` → Run (debe decir «Listo: 6 preguntas de prueba publicadas; 30 preguntas reales en borrador.»).
5. Authentication → URL Configuration → Site URL = la URL de Vercel (paso 2).

## 2. Vercel

1. vercel.com → Continue with GitHub → Add New → Project → importar `Opos` (rama `main`).
2. Environment Variables:
   - `NEXT_PUBLIC_SUPABASE_URL` = Project URL
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = anon public
   - `SUPABASE_SERVICE_ROLE_KEY` = service_role (secreta: solo aquí)
   - `NEXT_PUBLIC_SITE_URL` = la URL que asigne Vercel (`https://….vercel.app`)
   - `PREVIEW_PASSWORD` = contraseña para entrar en la web
3. Deploy.

## 3. Contenido nuevo (después del paso 1)

En el SQL Editor, en este orden y una sola vez cada uno (todos son idempotentes): `3-b1-guia-ca.sql`, `4-aprobacion-por-lotes.sql`, `5a`, `5b` y `5c-temario-mossos-…`, `6-packs-mossos-ca.sql`, `7-simulacros.sql`, `8-publicar-todo.sql`. Después, con `admin@aprobia.test`, en `/admin/revision/fuentes` (sin elegir tema): marcar la confirmación y pulsar «Aprobar y publicar todo».

## Regenerar el SQL

`supabase/preview/1-esquema-y-contenido.sql` se genera a partir de `supabase/migrations`, `seed.sql` y `content/` con `scripts/content/to-sql.mjs` (ver historial de la sesión 3). No editar a mano.

## Cerrar la preview

Vercel → Project → Settings → Delete (o pausar) y Supabase → Project → Pause. No hay nada de pago activado.

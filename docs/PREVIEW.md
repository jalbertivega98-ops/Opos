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

## 3. Contenido nuevo: automático

Desde el 2026-11-03 los SQL de `supabase/preview/` del **3 en adelante** los aplica GitHub Actions (`.github/workflows/preview-db.yml` → `scripts/preview/apply-sql.mjs`) en cada push a `main` que los cambie. Se registran en `public.preview_sql_applied` y solo se repiten si cambia el archivo (todos son idempotentes). Los 1 y 2 siguen siendo manuales (arranque).

Configuración, una sola vez (la hace joel; la contraseña no pasa por Claude):

1. Supabase → proyecto `aprobia-preview` → botón **Connect** → **Session pooler** → copiar la URI y sustituir `[YOUR-PASSWORD]` por la contraseña de la base de datos (si no la recuerdas: Project Settings → Database → Reset database password).
2. GitHub → repo `Opos` → Settings → Secrets and variables → Actions → **New repository secret**: nombre `PREVIEW_DATABASE_URL`, valor la URI.
3. GitHub → Actions → «Base de datos de la preview» → **Run workflow** para la primera ejecución.

Sin el secreto, el workflow no hace nada (no falla). Para verificar el certificado TLS se puede añadir también el secreto `PREVIEW_DATABASE_CA` con el certificado que Supabase ofrece en Project Settings → Database → SSL.

Después de publicar con «Aprobar y publicar todo» (en `/admin/revision/fuentes`, sin elegir tema) el contenido queda visible.

## Regenerar el SQL

`supabase/preview/1-esquema-y-contenido.sql` se genera a partir de `supabase/migrations`, `seed.sql` y `content/` con `scripts/content/to-sql.mjs` (ver historial de la sesión 3). No editar a mano.

## Cerrar la preview

Vercel → Project → Settings → Delete (o pausar) y Supabase → Project → Pause. No hay nada de pago activado.

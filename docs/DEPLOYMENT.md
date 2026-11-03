# Despliegue y entornos

> Ningún despliegue, cuenta externa ni migración remota se ejecuta sin autorización explícita de joel.

## Entornos

| Entorno         | App                | Datos                                         | Estado                   |
| --------------- | ------------------ | --------------------------------------------- | ------------------------ |
| Local           | `npm run dev`      | Pila local sin Docker (`npm run stack:start`) | ✅                       |
| Preview/Staging | Vercel (propuesto) | Proyecto Supabase de pruebas                  | ⬜ requiere autorización |
| Producción      | Vercel             | Proyecto Supabase (región UE)                 | ⬜ requiere autorización |

## Local desde cero

```bash
npm ci
npm run stack:setup        # descarga GoTrue, PostgREST y Mailpit (una vez)
npm run stack:start -- --seed
node scripts/stack/keys.mjs   # claves de desarrollo → .env.local (ver .env.example)
npm run dev                # http://localhost:3000 · correos en http://127.0.0.1:54324
npm run admin:grant -- tu@email.test owner
```

Requisitos: Node ≥ 22, PostgreSQL 16 instalado (binarios en /usr/lib/postgresql). Con Docker: `npx supabase start` es equivalente (aplica las mismas migraciones y seed).

## Variables de entorno

| Variable                                     | Ámbito         | Descripción                                    |
| -------------------------------------------- | -------------- | ---------------------------------------------- |
| `NEXT_PUBLIC_SITE_URL`                       | público        | URL base (emails, metadatos)                   |
| `NEXT_PUBLIC_SUPABASE_URL`                   | público        | URL del proyecto Supabase                      |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY`              | público        | anon/publishable key (RLS protege)             |
| `SUPABASE_SERVICE_ROLE_KEY`                  | secreto        | solo server-only (webhooks, tareas de sistema) |
| `AUTH_RATE_LIMIT_MAX`                        | solo local/E2E | eleva el límite de intentos de auth            |
| `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET` | secreto        | Pagos (docs/PAGOS.md). Sin clave: desactivados |
| `STRIPE_LIVE_ENABLED`                        | secreto        | `true` solo con autorización para cobrar real  |
| `ANTHROPIC_API_KEY`                          | secreto        | Hito 6                                         |

## Checklist de despliegue (skill `preparar-despliegue`)

1. Regresión completa + `npm run build`.
2. Supabase: aplicar migraciones (`supabase db push`) — **autorización**.
3. Auth: Site URL, Redirect URLs (`https://dominio/auth/callback`, `/auth/confirm`), SMTP propio, plantillas de email con `{{ .SiteURL }}/auth/confirm?token_hash={{ .TokenHash }}&type=signup&next=/app/onboarding` (y `type=recovery&next=/restablecer`).
4. Variables en el proveedor; ningún secreto en el repo.
5. Asignar `owner` a joel por SQL.
6. Verificación post-despliegue: registro → email → onboarding → dashboard; login; recuperación; catálogo; admin.
7. Rollback: redeploy de la versión anterior; migraciones siempre aditivas.

## Integraciones preparadas (DEC-003)

| Servicio       | Estado                                                                                    | Qué falta (requiere autorización específica)                                                            |
| -------------- | ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| GitHub         | ✅ `jalbertivega98-ops/Opos`, rama `main`                                                 | Opcional: CI con GitHub Actions (typecheck, lint, unitarias)                                            |
| Supabase cloud | Migraciones 0100–0900 compatibles con `supabase db push`                                  | Crear proyecto (región UE), aplicar migraciones, configurar Auth y SMTP, `owner` para joel              |
| Stripe (test)  | Checkout, webhook y portal hechos (migración `20261103000900_billing.sql`, docs/PAGOS.md) | Cuenta Stripe en modo test, `STRIPE_SECRET_KEY` y `STRIPE_WEBHOOK_SECRET` en Vercel, precios publicados |
| Despliegue     | `npm run build` correcto                                                                  | Proyecto en el proveedor (p. ej. Vercel) y variables de entorno                                         |

Ninguna de estas cuentas se ha creado ni conectado.

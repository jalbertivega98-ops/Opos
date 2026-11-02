# Seguridad y protección de datos

## Garantías implementadas (Hito 1)

| Área                    | Medida                                                                                                                 | Dónde                                         |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| Autenticación           | Email+contraseña con verificación obligatoria; mínimo 8 caracteres con letra y número; flujo PKCE; cookies httpOnly    | GoTrue, `src/lib/auth`                        |
| Sesión                  | Refresco en cada petición y validación con `getUser()` (no solo cookie)                                                | `src/proxy.ts`, `src/lib/supabase/session.ts` |
| Autorización            | RLS en todas las tablas; comprobación de rol en servidor (`requireUser`, `requireAdmin`); trigger anti-escalada de rol | migraciones 0100–0300                         |
| Respuestas correctas    | Tablas de preguntas inaccesibles a alumnos; corrección vía funciones SECURITY DEFINER                                  | 0300                                          |
| Validación              | Zod en todas las Server Actions; búsqueda saneada para filtros PostgREST                                               | `schemas.ts`, `catalog/search.ts`             |
| Redirecciones           | Solo rutas internas (`safeNextPath`)                                                                                   | `src/lib/paths.ts`                            |
| Enumeración de usuarios | Respuestas idénticas en registro y recuperación                                                                        | `auth/actions.ts`                             |
| Rate limiting           | 10 intentos/10 min por IP y acción (memoria) + límites de GoTrue                                                       | `src/lib/rate-limit.ts`                       |
| Cabeceras               | X-Frame-Options DENY, nosniff, Referrer-Policy, Permissions-Policy, COOP, HSTS (prod), sin X-Powered-By                | `next.config.ts`                              |
| Auditoría               | `audit_log` para acciones de staff                                                                                     | 0100                                          |
| Secretos                | `.env*` ignorados; hook `secret-guard` bloquea claves en archivos versionables; service role solo server-only          | `.claude/hooks`                               |

## Pendiente (ver TASKS.md, prefijo SEC)

- SEC-001 CSP con nonces. SEC-002 Rate limiting compartido (BD/Redis) para varias instancias. SEC-003 Exportación y borrado de cuenta (RGPD). SEC-004 Registro de errores sin datos personales. SEC-005 Copias de seguridad (PITR en Supabase de pago) y prueba de restauración. SEC-006 MFA para staff. SEC-007 Escaneo de dependencias en CI.

## RGPD

- Minimización: email (en Auth), nombre opcional, idioma, preferencias de estudio. Sin teléfono, DNI, fecha de nacimiento ni dirección.
- Base jurídica: ejecución del contrato (cuenta y servicio); consentimiento separado y revocable para comunicaciones (`marketing_consent`, `notify_consent`).
- Derechos: acceso/portabilidad (exportación JSON), supresión (borrado en cascada desde `auth.users`), rectificación (perfil).
- Encargados previstos: Supabase (UE recomendada), Vercel, Stripe, proveedor de email, proveedor IA → documentar en la política de privacidad y firmar DPA.
- No se muestran contraseñas (nunca se almacenan en claro; las gestiona GoTrue con bcrypt) ni datos de tarjeta (solo en Stripe).

## Gestión de incidentes

1. Contener (rotar claves, revocar sesiones). 2. Evaluar alcance. 3. Notificar a la AEPD en 72 h si procede. 4. Informar a afectados. 5. Post-mortem en docs/.

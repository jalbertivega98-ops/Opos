# Plantillas de correo de Supabase Auth

Plantillas con la marca OPOSAPRUEBA para Supabase cloud. **No se editan a mano**: se generan con
`node scripts/email/build-templates.mjs` (textos es/ca y diseño en ese script). Se pegan en el panel:
**Authentication → Emails → Templates**. Cada plantilla elige castellano o catalán según
`user_metadata.locale` (lo guarda el registro) y usa castellano si no existe.

| Plantilla en Supabase | Archivo               | Asunto                                     |
| --------------------- | --------------------- | ------------------------------------------ |
| Confirm signup        | `confirm-signup.html` | Confirma tu correo · OPOSAPRUEBA           |
| Reset password        | `reset-password.html` | Cambia tu contraseña · OPOSAPRUEBA         |
| Magic link            | `magic-link.html`     | Tu enlace para entrar · OPOSAPRUEBA        |
| Change email address  | `change-email.html`   | Confirma el cambio de correo · OPOSAPRUEBA |
| Invite user           | `invite.html`         | Te han invitado a OPOSAPRUEBA              |

Los enlaces van a `{{ .SiteURL }}/auth/confirm?token_hash=…&type=…&next=…`
(`src/app/auth/confirm/route.ts`), que funciona aunque se abra en otro dispositivo.
Por eso **Site URL** debe ser `https://oposaprueba.com`.

## Envío (SMTP propio con Resend)

Authentication → Emails → SMTP Settings → Enable custom SMTP:

- Sender email `no-responder@oposaprueba.com` · Sender name `OPOSAPRUEBA`
- Host `smtp.resend.com` · Port `465` · Username `resend` · Password: API key de Resend
  (permiso _Sending access_). La clave nunca va al repositorio.

El dominio `oposaprueba.com` debe estar verificado en Resend (región UE, registros DNS en
Cloudflare con la nube en gris).

## Diseño

El logo es `public/brand/email-logo.png` (servido en `https://oposaprueba.com/brand/email-logo.png`,
fuera de la contraseña de la preview porque los archivos estáticos no pasan por `proxy.ts`).
Saludo con `user_metadata.display_name` si existe. Tablas y estilos en línea para que se vea
bien en Gmail, Outlook y móvil; modo claro forzado (`color-scheme: light`).

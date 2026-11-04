# Plantillas de correo de Supabase Auth

Plantillas con la marca OPOSAPRUEBA para Supabase cloud. Se pegan a mano en el panel:
**Authentication → Emails → Templates**. Cada plantilla elige castellano o catalán según
`user_metadata.locale` (lo guarda el registro) y usa castellano si no existe.

| Plantilla en Supabase | Archivo               | Asunto                                   |
| --------------------- | --------------------- | ---------------------------------------- |
| Confirm signup        | `confirm-signup.html` | Confirma tu correo · OPOSAPRUEBA         |
| Reset password        | `reset-password.html` | Cambia tu contraseña · OPOSAPRUEBA       |
| Magic link            | `magic-link.html`     | Tu enlace para entrar · OPOSAPRUEBA      |
| Change email address  | `change-email.html`   | Confirma tu nuevo correo · OPOSAPRUEBA   |
| Invite user           | `invite.html`         | Te han invitado a OPOSAPRUEBA            |

Los enlaces van a `{{ .SiteURL }}/auth/confirm?token_hash=…&type=…&next=…`
(`src/app/auth/confirm/route.ts`), que funciona aunque se abra en otro dispositivo.
Por eso **Site URL** debe ser `https://oposaprueba.com`.

## Envío (SMTP propio con Resend)

Authentication → Emails → SMTP Settings → Enable custom SMTP:

- Sender email `no-responder@oposaprueba.com` · Sender name `OPOSAPRUEBA`
- Host `smtp.resend.com` · Port `465` · Username `resend` · Password: API key de Resend
  (permiso *Sending access*). La clave nunca va al repositorio.

El dominio `oposaprueba.com` debe estar verificado en Resend (región UE, registros DNS en
Cloudflare con la nube en gris).

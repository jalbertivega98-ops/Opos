// Genera las plantillas de correo de Supabase Auth (supabase/email-templates/*.html).
// Uso: node scripts/email/build-templates.mjs  · Después, pegarlas en el panel de Supabase.
import { writeFileSync } from "node:fs";
import { join } from "node:path";

const OUT = join(import.meta.dirname, "../../supabase/email-templates");
const SITE = "https://oposaprueba.com";

const C = {
  navy: "#0b2545",
  teal: "#0a7a70",
  tealSoft: "#e3f6f3",
  marker: "#ffd166",
  text: "#1f2f46",
  muted: "#4a5a72",
  border: "#dde3ec",
  bg: "#eef2f7",
};
const SERIF = "Georgia,'Times New Roman',serif";
const SANS = "-apple-system,'Segoe UI',Roboto,Helvetica,Arial,sans-serif";

const TEMPLATES = [
  {
    file: "confirm-signup",
    type: "signup",
    next: "/app/onboarding",
    es: {
      preheader: "Un clic y empiezas a preparar tu oposición.",
      title: "Confirma tu correo",
      body: "Gracias por registrarte. Confirma tu correo y empieza a preparar tu oposición: temario, tests por temas y simulacros con el formato del examen real.",
      cta: "Confirmar mi correo",
      ignore:
        "Si no te has registrado en OPOSAPRUEBA, ignora este correo y no se creará ninguna cuenta.",
    },
    ca: {
      preheader: "Un clic i comences a preparar la teva oposició.",
      title: "Confirma el teu correu",
      body: "Gràcies per registrar-te. Confirma el teu correu i comença a preparar la teva oposició: temari, tests per temes i simulacres amb el format de l'examen real.",
      cta: "Confirmar el meu correu",
      ignore:
        "Si no t'has registrat a OPOSAPRUEBA, ignora aquest correu i no es crearà cap compte.",
    },
  },
  {
    file: "reset-password",
    type: "recovery",
    next: "/restablecer",
    es: {
      preheader: "Elige una contraseña nueva para tu cuenta.",
      title: "Cambia tu contraseña",
      body: "Hemos recibido una petición para cambiar la contraseña de tu cuenta. Pulsa el botón y elige una nueva.",
      cta: "Elegir nueva contraseña",
      ignore: "Si no lo has pedido tú, ignora este correo: tu contraseña actual sigue funcionando.",
    },
    ca: {
      preheader: "Tria una contrasenya nova per al teu compte.",
      title: "Canvia la teva contrasenya",
      body: "Hem rebut una petició per canviar la contrasenya del teu compte. Prem el botó i tria'n una de nova.",
      cta: "Triar nova contrasenya",
      ignore:
        "Si no ho has demanat tu, ignora aquest correu: la teva contrasenya actual continua funcionant.",
    },
  },
  {
    file: "magic-link",
    type: "email",
    next: "/app",
    es: {
      preheader: "Tu enlace para entrar sin contraseña.",
      title: "Tu enlace para entrar",
      body: "Pulsa el botón para entrar en tu cuenta sin contraseña.",
      cta: "Entrar en OPOSAPRUEBA",
      ignore: "Si no lo has pedido tú, ignora este correo.",
    },
    ca: {
      preheader: "El teu enllaç per entrar sense contrasenya.",
      title: "El teu enllaç per entrar",
      body: "Prem el botó per entrar al teu compte sense contrasenya.",
      cta: "Entrar a OPOSAPRUEBA",
      ignore: "Si no ho has demanat tu, ignora aquest correu.",
    },
  },
  {
    file: "change-email",
    type: "email_change",
    next: "/app/perfil",
    es: {
      preheader: "Confirma el cambio de correo de tu cuenta.",
      title: "Confirma el cambio de correo",
      body: "Has pedido cambiar el correo de tu cuenta de {{ .Email }} a {{ .NewEmail }}. Pulsa el botón para confirmarlo.",
      cta: "Confirmar el cambio",
      ignore: "Si no lo has pedido tú, ignora este correo y cambia tu contraseña desde Mi perfil.",
    },
    ca: {
      preheader: "Confirma el canvi de correu del teu compte.",
      title: "Confirma el canvi de correu",
      body: "Has demanat canviar el correu del teu compte de {{ .Email }} a {{ .NewEmail }}. Prem el botó per confirmar-ho.",
      cta: "Confirmar el canvi",
      ignore:
        "Si no ho has demanat tu, ignora aquest correu i canvia la contrasenya des del teu perfil.",
    },
  },
  {
    file: "invite",
    type: "invite",
    next: "/app/onboarding",
    es: {
      preheader: "Tienes una invitación para OPOSAPRUEBA.",
      title: "Te han invitado a OPOSAPRUEBA",
      body: "Tienes una invitación para crear tu cuenta y empezar a preparar tu oposición.",
      cta: "Aceptar invitación",
      ignore: "Si no esperabas esta invitación, ignora este correo.",
    },
    ca: {
      preheader: "Tens una invitació per a OPOSAPRUEBA.",
      title: "T'han convidat a OPOSAPRUEBA",
      body: "Tens una invitació per crear el teu compte i començar a preparar la teva oposició.",
      cta: "Acceptar la invitació",
      ignore: "Si no esperaves aquesta invitació, ignora aquest correu.",
    },
  },
];

const L = {
  es: {
    hello: "Hola",
    fallback: "¿El botón no funciona? Copia y pega este enlace en tu navegador:",
    footer: "Correo automático de OPOSAPRUEBA. No respondas a este mensaje.",
    help: "¿Dudas? Escríbenos a",
  },
  ca: {
    hello: "Hola",
    fallback: "El botó no funciona? Copia i enganxa aquest enllaç al navegador:",
    footer: "Correu automàtic d'OPOSAPRUEBA. No responguis aquest missatge.",
    help: "Dubtes? Escriu-nos a",
  },
};

function block(t, lang, url) {
  const s = t[lang];
  const l = L[lang];
  return `
<div style="display:none;max-height:0;overflow:hidden;opacity:0;color:transparent;">${s.preheader}</div>
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:${C.bg};">
<tr><td align="center" style="padding:32px 16px;">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;">
<tr><td style="padding:0 4px 16px;">
<a href="${SITE}" style="text-decoration:none;"><img src="${SITE}/brand/email-logo.png" width="214" height="32" alt="OPOSAPRUEBA" style="display:block;border:0;height:32px;width:214px;"></a>
</td></tr>
<tr><td style="background:#ffffff;border:1px solid ${C.border};border-radius:16px;overflow:hidden;">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0">
<tr><td style="height:6px;line-height:6px;font-size:0;background:${C.navy};border-radius:16px 16px 0 0;">&nbsp;</td></tr>
<tr><td style="padding:36px 36px 8px;font-family:${SANS};">
<p style="margin:0 0 6px;font-size:15px;color:${C.muted};">${l.hello}{{ with .Data.display_name }} {{ . }}{{ end }},</p>
<h1 style="margin:0 0 18px;font-family:${SERIF};font-size:28px;line-height:1.25;color:${C.navy};font-weight:bold;"><span style="background:linear-gradient(transparent 62%, ${C.marker} 62%);">${s.title}</span></h1>
<p style="margin:0 0 28px;font-size:16px;line-height:1.65;color:${C.text};">${s.body}</p>
<table role="presentation" cellpadding="0" cellspacing="0"><tr><td style="border-radius:10px;background:${C.teal};">
<a href="${url}" style="display:inline-block;padding:15px 28px;font-family:${SANS};font-size:16px;font-weight:bold;color:#ffffff;text-decoration:none;border-radius:10px;">${s.cta} &rarr;</a>
</td></tr></table>
</td></tr>
<tr><td style="padding:24px 36px 32px;font-family:${SANS};">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0"><tr><td style="background:${C.tealSoft};border-radius:10px;padding:14px 16px;font-size:13px;line-height:1.55;color:${C.text};">${s.ignore}</td></tr></table>
<p style="margin:20px 0 4px;font-size:12px;line-height:1.5;color:${C.muted};">${l.fallback}</p>
<p style="margin:0;font-size:12px;line-height:1.5;word-break:break-all;"><a href="${url}" style="color:${C.teal};">${url}</a></p>
</td></tr>
</table>
</td></tr>
<tr><td style="padding:20px 8px 0;font-family:${SANS};font-size:12px;line-height:1.6;color:${C.muted};text-align:center;">
${l.footer}<br>${l.help} <a href="mailto:hola@oposaprueba.com" style="color:${C.muted};">hola@oposaprueba.com</a> · <a href="${SITE}" style="color:${C.muted};">oposaprueba.com</a>
</td></tr>
</table>
</td></tr>
</table>`;
}

for (const t of TEMPLATES) {
  const url = (lang) =>
    `{{ .SiteURL }}/auth/confirm?token_hash={{ .TokenHash }}&amp;type=${t.type}&amp;next=${lang === "ca" ? "/ca" : ""}${t.next}`;
  const html = `<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="color-scheme" content="light">
<meta name="supported-color-schemes" content="light">
<title>OPOSAPRUEBA</title>
</head>
<body style="margin:0;padding:0;background:${C.bg};">
{{ if eq (printf "%v" .Data.locale) "ca" }}${block(t, "ca", url("ca"))}
{{ else }}${block(t, "es", url("es"))}
{{ end }}
</body>
</html>
`;
  writeFileSync(join(OUT, `${t.file}.html`), html);
  console.log(`✓ ${t.file}.html`);
}

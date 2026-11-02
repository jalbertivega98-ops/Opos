#!/usr/bin/env node
// PreToolUse (Edit|Write): bloquea la escritura de secretos en archivos versionables.
// Permite .env.local (ignorado por Git). Salida 2 = bloquear y explicar a Claude.
import { readFileSync } from "node:fs";
import { basename } from "node:path";

const input = JSON.parse(readFileSync(0, "utf8") || "{}");
const ti = input.tool_input ?? {};
const file = String(ti.file_path ?? "");
const content = [ti.content, ti.new_string].filter(Boolean).join("\n");
if (!content || /^\.env(\.local|\.development\.local|\.test\.local)?$/.test(basename(file))) process.exit(0);

const patterns = [
  [/sk_live_[0-9a-zA-Z]{10,}/, "clave secreta LIVE de Stripe"],
  [/rk_live_[0-9a-zA-Z]{10,}/, "clave restringida LIVE de Stripe"],
  [/sk_test_[0-9a-zA-Z]{20,}/, "clave secreta de Stripe (test)"],
  [/whsec_[0-9a-zA-Z]{20,}/, "secreto de webhook de Stripe"],
  [/sk-ant-[0-9a-zA-Z_-]{20,}/, "API key de Anthropic"],
  [/sb_secret_[0-9a-zA-Z_-]{10,}/, "secret key de Supabase"],
  [/-----BEGIN (RSA |EC )?PRIVATE KEY-----/, "clave privada"],
  [/gh[pousr]_[0-9a-zA-Z]{30,}/, "token de GitHub"],
  [/AKIA[0-9A-Z]{16}/, "access key de AWS"],
];
for (const [re, what] of patterns) {
  if (re.test(content)) {
    process.stderr.write(
      `Bloqueado: parece que vas a escribir una ${what} en ${file}. Los secretos van en .env.local (no versionado) o en el gestor de secretos del despliegue. Ver docs/SECURITY.md.`,
    );
    process.exit(2);
  }
}

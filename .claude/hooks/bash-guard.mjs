#!/usr/bin/env node
// PreToolUse (Bash): impide acciones irreversibles o con impacto externo que
// requieren autorización explícita de joel (CLAUDE.md › Autonomía).
import { readFileSync } from "node:fs";

const input = JSON.parse(readFileSync(0, "utf8") || "{}");
const cmd = String(input?.tool_input?.command ?? "");
const rules = [
  [/\bgit\s+push\b[^\n]*(--force|-f\b)/, "push forzado"],
  [/\bsupabase\s+(db\s+(push|reset)|link)\b[^\n]*(--linked|--project-ref|--db-url)|\bsupabase\s+link\b/, "operación sobre un proyecto Supabase remoto"],
  [/\bstripe\b[^\n]*--live\b/, "operación de Stripe en modo live"],
  [/\b(vercel|netlify)\b[^\n]*(--prod|deploy\s+--prod)/, "despliegue a producción"],
  [/\bdrop\s+database\b/i, "DROP DATABASE"],
];
for (const [re, what] of rules) {
  if (re.test(cmd)) {
    process.stderr.write(`Bloqueado (${what}): requiere autorización explícita de joel. Pídela en el hilo antes de ejecutarlo.`);
    process.exit(2);
  }
}

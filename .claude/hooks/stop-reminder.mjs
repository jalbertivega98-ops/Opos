#!/usr/bin/env node
// Stop: aviso (no bloqueante) si hay código cambiado sin actualizar SESSION_HANDOFF/TASKS.
import { execSync } from "node:child_process";

const root = process.env.CLAUDE_PROJECT_DIR ?? process.cwd();
let status = "";
try {
  status = execSync("git status --porcelain", { cwd: root, encoding: "utf8", timeout: 5000 });
} catch {
  process.exit(0);
}
const changed = status.split("\n").filter(Boolean).map((l) => l.slice(3));
const code = changed.some((f) => /^(src|supabase|tests)\//.test(f));
const docs = changed.some((f) => /SESSION_HANDOFF\.md|TASKS\.md/.test(f));
if (code && !docs) {
  process.stdout.write(
    JSON.stringify({
      systemMessage:
        "Hay cambios de código sin reflejar en docs/SESSION_HANDOFF.md ni TASKS.md. Actualízalos antes de cerrar el bloque de trabajo.",
    }),
  );
}

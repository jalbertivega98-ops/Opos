#!/usr/bin/env node
// SessionStart: recuerda el protocolo de reanudación y muestra el estado de Git.
import { execSync } from "node:child_process";

const root = process.env.CLAUDE_PROJECT_DIR ?? process.cwd();
const sh = (c) => {
  try {
    return execSync(c, { cwd: root, encoding: "utf8", timeout: 5000 }).trim();
  } catch {
    return "(no disponible)";
  }
};
const context = [
  "Protocolo de inicio (CLAUDE.md): lee docs/SESSION_HANDOFF.md y TASKS.md antes de trabajar.",
  `Rama: ${sh("git branch --show-current")} · Último commit: ${sh("git log -1 --format='%h %s'")}`,
  `Cambios sin commit:\n${sh("git status --short") || "(ninguno)"}`,
  "La pila local se arranca con `npm run stack:start` (ver docs/DEPLOYMENT.md).",
].join("\n");
process.stdout.write(
  JSON.stringify({ hookSpecificOutput: { hookEventName: "SessionStart", additionalContext: context } }),
);

#!/usr/bin/env node
// PostToolUse (Edit|Write): formatea con Prettier SOLO el archivo modificado. Rápido y no bloqueante.
import { execFileSync } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import { relative } from "node:path";

const input = JSON.parse(readFileSync(0, "utf8") || "{}");
const file = input?.tool_input?.file_path;
const root = process.env.CLAUDE_PROJECT_DIR ?? process.cwd();
if (!file || !existsSync(file)) process.exit(0);
const rel = relative(root, file);
if (rel.startsWith("..") || /(^|\/)(node_modules|\.next|\.local-stack)\//.test(rel)) process.exit(0);
if (!/\.(ts|tsx|mts|js|mjs|json|css|md)$/.test(file) || rel.startsWith("supabase/migrations/")) process.exit(0);
try {
  execFileSync(`${root}/node_modules/.bin/prettier`, ["--write", "--log-level", "warn", file], {
    cwd: root,
    stdio: "ignore",
    timeout: 15000,
  });
} catch {
  // Un fallo de formato nunca bloquea el trabajo.
}

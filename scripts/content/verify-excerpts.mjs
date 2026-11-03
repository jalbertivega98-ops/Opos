// Comprueba que el extracto ('excerpt') de cada pregunta aparece literalmente en el texto
// de la fuente (p. ej. la Guia d'estudi extraída a .txt). Ignora saltos de línea, guiones de
// corte de línea, cabeceras de página y diferencias de comillas.
//   node scripts/content/verify-excerpts.mjs <lote.json> <fuente.txt>
import { readFileSync } from "node:fs";

const [file, sourceFile] = process.argv.slice(2);
if (!file || !sourceFile) {
  console.error("Uso: node scripts/content/verify-excerpts.mjs <lote.json> <fuente.txt>");
  process.exit(1);
}
// Quita las 2 primeras líneas de cada página si son la cabecera de la guía.
const stripHeaders = (s) =>
  s
    .split(/\[\[p\.\d+\]\]\n/)
    .map((page) => {
      const lines = page.split("\n");
      return lines.slice(0, 2).some((l) => l.includes("Guia d’estudi per accedir"))
        ? lines.slice(2).join("\n")
        : page;
    })
    .join("\n");
const norm = (s) =>
  s
    .replace(/[“”«»"]/g, '"')
    .replace(/[‘’']/g, "’")
    .replace(/[–—-]/g, "-")
    .replace(/\s+/g, " ")
    .trim();
const source = norm(stripHeaders(readFileSync(sourceFile, "utf8")));
const data = JSON.parse(readFileSync(file, "utf8"));
const missing = [];
for (const [i, q] of data.questions.entries()) {
  const parts = String(q.excerpt ?? "").split(/\s*\[…\]\s*/);
  if (!q.excerpt || parts.some((p) => !source.includes(norm(p)))) missing.push(i + 1);
}
console.log(
  `${file}: ${data.questions.length - missing.length}/${data.questions.length} extractos encontrados en la fuente` +
    (missing.length ? ` · NO encontrados: ${missing.join(", ")}` : ""),
);
process.exit(missing.length ? 2 : 0);

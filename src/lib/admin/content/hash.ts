import "server-only";
import { createHash } from "node:crypto";
import { normalizeText, type QuestionInput } from "./schema";

/** Huella del contenido: enunciado + opciones (sin orden). Igual huella = duplicado. */
export function contentHash(q: Pick<QuestionInput, "stem" | "options">) {
  const parts = [normalizeText(q.stem), ...q.options.map(normalizeText).sort()];
  return createHash("sha256").update(parts.join("␟")).digest("hex");
}

import { questionSchema, type QuestionInput } from "./schema";

export const IMPORT_MAX_ROWS = 500;
export const IMPORT_MAX_BYTES = 1_000_000;

export type ImportRow = { line: number; data?: QuestionInput; errors: string[] };

/**
 * Parser CSV (RFC 4180): comillas dobles, comas y saltos de línea dentro de
 * campos entrecomillados. Acepta `;` como separador si la cabecera lo usa.
 */
export function parseCsv(text: string): string[][] {
  const src = text.replace(/^﻿/, "");
  const firstLine = src.split(/\r?\n/, 1)[0] ?? "";
  const sep =
    (firstLine.match(/;/g)?.length ?? 0) > (firstLine.match(/,/g)?.length ?? 0) ? ";" : ",";
  const rows: string[][] = [];
  let row: string[] = [];
  let field = "";
  let quoted = false;
  for (let i = 0; i < src.length; i++) {
    const ch = src[i];
    if (quoted) {
      if (ch === '"') {
        if (src[i + 1] === '"') {
          field += '"';
          i++;
        } else quoted = false;
      } else field += ch;
    } else if (ch === '"') quoted = true;
    else if (ch === sep) {
      row.push(field);
      field = "";
    } else if (ch === "\n" || ch === "\r") {
      if (ch === "\r" && src[i + 1] === "\n") i++;
      row.push(field);
      rows.push(row);
      row = [];
      field = "";
    } else field += ch;
  }
  if (field !== "" || row.length) {
    row.push(field);
    rows.push(row);
  }
  return rows.filter((r) => r.some((c) => c.trim() !== ""));
}

const LETTERS = ["a", "b", "c", "d", "e", "f"];

/** Convierte un registro (CSV o JSON) al formato del editor. */
function fromRecord(r: Record<string, unknown>, examIds: Map<string, string>) {
  const options = Array.isArray(r.options)
    ? (r.options as unknown[]).map(String)
    : LETTERS.map((l) => r[`option_${l}`])
        .filter((v) => v !== undefined && String(v).trim() !== "")
        .map(String);
  const correctRaw = String(r.correct ?? "").trim();
  const correct = /^[A-Fa-f]$/.test(correctRaw)
    ? LETTERS.indexOf(correctRaw.toLowerCase())
    : Number(correctRaw);
  const slugs = Array.isArray(r.exams)
    ? (r.exams as unknown[]).map(String)
    : String(r.exams ?? "")
        .split(/[|;]/)
        .map((s) => s.trim())
        .filter(Boolean);
  const unknown = slugs.filter((s) => !examIds.has(s));
  return {
    input: {
      stem: r.stem,
      explanation: r.explanation ?? "",
      category: r.category,
      difficulty: r.difficulty ?? 3,
      locale: r.locale || "es",
      is_free: r.is_free ?? false,
      ai_generated: r.ai_generated ?? false,
      options,
      correct,
      exam_body_ids: slugs.filter((s) => examIds.has(s)).map((s) => examIds.get(s)!),
    },
    unknown,
  };
}

/**
 * Valida un archivo de importación. Nunca escribe: devuelve filas válidas y
 * errores por línea. Todo lo importado entra como BORRADOR (DEC-002).
 */
export function parseImport(
  text: string,
  format: "csv" | "json",
  examIds: Map<string, string>,
): { rows: ImportRow[]; fatal?: string } {
  if (text.length > IMPORT_MAX_BYTES) return { rows: [], fatal: "too_big" };
  let records: Record<string, unknown>[] = [];
  const lineOffset = format === "csv" ? 2 : 1;
  if (format === "json") {
    try {
      const parsed = JSON.parse(text);
      records = Array.isArray(parsed)
        ? parsed
        : Array.isArray(parsed?.questions)
          ? parsed.questions
          : [];
    } catch {
      return { rows: [], fatal: "bad_json" };
    }
  } else {
    const table = parseCsv(text);
    if (table.length < 2) return { rows: [], fatal: "empty" };
    const header = table[0].map((h) => h.trim().toLowerCase());
    if (!header.includes("stem") || !header.includes("correct"))
      return { rows: [], fatal: "bad_header" };
    records = table
      .slice(1)
      .map((cells) => Object.fromEntries(header.map((h, i) => [h, cells[i] ?? ""])));
  }
  if (records.length === 0) return { rows: [], fatal: "empty" };
  if (records.length > IMPORT_MAX_ROWS) return { rows: [], fatal: "too_many" };

  const rows = records.map((rec, i): ImportRow => {
    if (!rec || typeof rec !== "object") return { line: i + lineOffset, errors: ["format"] };
    const { input, unknown } = fromRecord(rec, examIds);
    const parsed = questionSchema.safeParse(input);
    const errors = [
      ...(parsed.success ? [] : parsed.error.issues.map((e) => e.path.join(".") || e.message)),
      ...unknown.map((s) => `exam:${s}`),
    ];
    return {
      line: i + lineOffset,
      data: parsed.success && !unknown.length ? parsed.data : undefined,
      errors,
    };
  });
  return { rows };
}

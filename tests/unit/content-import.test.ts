import { describe, expect, it, vi } from "vitest";
vi.mock("server-only", () => ({}));
import { parseCsv, parseImport } from "@/lib/admin/content/import";
import { contentHash } from "@/lib/admin/content/hash";
import { normalizeText, questionSchema } from "@/lib/admin/content/schema";
import { productSchema } from "@/lib/store/schema";

const exams = new Map([["mossos-esquadra", "6f1c1c3e-1b0a-4a5b-9c3d-2e1f0a9b8c7d"]]);

describe("parser CSV", () => {
  it("respeta comillas, comas y saltos de línea dentro de campos", () => {
    const rows = parseCsv('a,b\n"uno, dos","línea 1\nlínea 2"\n"con ""comillas""",x\n');
    expect(rows).toEqual([
      ["a", "b"],
      ["uno, dos", "línea 1\nlínea 2"],
      ['con "comillas"', "x"],
    ]);
  });
  it("detecta punto y coma como separador y quita el BOM", () => {
    expect(parseCsv("﻿a;b\n1;2")).toEqual([
      ["a", "b"],
      ["1", "2"],
    ]);
  });
});

describe("importación", () => {
  const csv = [
    "stem,explanation,category,difficulty,locale,option_a,option_b,option_c,correct,exams",
    '"¿Cuánto es 2 + 2?","Suma básica.",numerico,1,es,3,4,5,B,mossos-esquadra',
    '"Sin opción correcta válida",,numerico,1,es,a,b,,F,',
    '"Oposición inexistente",,numerico,1,es,a,b,,A,inventada',
    "x,,MAYUS RARO!,1,es,a,a,,A,",
  ].join("\n");

  it("valida fila a fila y no inventa vínculos con oposiciones", () => {
    const { rows, fatal } = parseImport(csv, "csv", exams);
    expect(fatal).toBeUndefined();
    expect(rows).toHaveLength(4);
    expect(rows[0].data).toMatchObject({
      correct: 1,
      options: ["3", "4", "5"],
      exam_body_ids: [exams.get("mossos-esquadra")],
    });
    expect(rows[1].data).toBeUndefined();
    expect(rows[1].errors).toContain("correct");
    expect(rows[2].errors).toContain("exam:inventada");
    expect(rows[3].errors.length).toBeGreaterThan(1);
    expect(rows.map((r) => r.line)).toEqual([2, 3, 4, 5]);
  });

  it("acepta JSON con letra o índice en correct", () => {
    const json = JSON.stringify([
      { stem: "Pregunta JSON uno", category: "test", options: ["a", "b"], correct: "A" },
      { stem: "Pregunta JSON dos", category: "test", options: ["a", "b"], correct: 1 },
    ]);
    const { rows } = parseImport(json, "json", exams);
    expect(rows.map((r) => r.data?.correct)).toEqual([0, 1]);
  });

  it("rechaza archivos vacíos, JSON roto, cabeceras incorrectas y demasiadas filas", () => {
    expect(parseImport("", "csv", exams).fatal).toBe("empty");
    expect(parseImport("{", "json", exams).fatal).toBe("bad_json");
    expect(parseImport("a,b\n1,2", "csv", exams).fatal).toBe("bad_header");
    const many = JSON.stringify(Array.from({ length: 501 }, () => ({})));
    expect(parseImport(many, "json", exams).fatal).toBe("too_many");
  });
});

describe("duplicados", () => {
  it("la huella ignora mayúsculas, tildes, espacios y orden de opciones", () => {
    const a = contentHash({
      stem: "¿Qué  es la Constitución?",
      options: ["Una ley", "Un decreto"],
    });
    const b = contentHash({ stem: "¿que es la constitucion?", options: ["un decreto", "UNA LEY"] });
    expect(a).toBe(b);
    expect(normalizeText("  Ñandú  Á ")).toBe("nandu a");
  });
  it("el esquema rechaza opciones repetidas", () => {
    const r = questionSchema.safeParse({
      stem: "Pregunta",
      category: "xx",
      difficulty: 1,
      options: ["Sí", "si"],
      correct: 0,
    });
    expect(r.success).toBe(false);
  });
});

describe("productos", () => {
  it("convierte el precio a céntimos y valida el identificador", () => {
    const ok = productSchema.parse({
      slug: "pack-1",
      type: "question_pack",
      title: "Pack uno",
      price: "14,99",
    });
    expect(ok.price).toBe(1499);
    expect(productSchema.safeParse({ slug: "Pack Uno", type: "pdf", title: "Pack" }).success).toBe(
      false,
    );
    expect(
      productSchema.safeParse({ slug: "p", type: "pdf", title: "Pack", price: "-1" }).success,
    ).toBe(false);
  });
});

import { describe, expect, it } from "vitest";
import { mockMark, saveMockAnswerSchema } from "@/lib/learning/mock/schema";

const MOSSOS = { penalty: 0.25, max_mark: 10 };

describe("nota de simulacro (formato Mossos 46/26)", () => {
  it("resta 1/4 por error y escala a 10", () => {
    expect(mockMark(30, 0, 30, MOSSOS)).toBe(10);
    expect(mockMark(12, 0, 30, MOSSOS)).toBe(4); // justo el mínimo
    expect(mockMark(13, 4, 30, MOSSOS)).toBe(4); // 13 − 1 = 12
    expect(mockMark(3, 1, 5, MOSSOS)).toBe(5.5);
  });
  it("nunca es negativa y las anuladas no cuentan", () => {
    expect(mockMark(1, 10, 30, MOSSOS)).toBe(0);
    expect(mockMark(29, 0, 29, MOSSOS)).toBe(10);
    expect(mockMark(0, 0, 0, MOSSOS)).toBe(0);
  });
});

describe("guardar respuesta", () => {
  const base = { attemptId: "6f1c2a52-6f7e-4b5a-9a43-0b8b1c1d2e3f", position: 0 };
  it("admite dejar en blanco (null) y opciones 0–5", () => {
    expect(saveMockAnswerSchema.safeParse({ ...base, choice: null }).success).toBe(true);
    expect(saveMockAnswerSchema.safeParse({ ...base, choice: 3 }).success).toBe(true);
  });
  it("rechaza opciones fuera de rango", () => {
    expect(saveMockAnswerSchema.safeParse({ ...base, choice: 6 }).success).toBe(false);
    expect(saveMockAnswerSchema.safeParse({ ...base, choice: -1 }).success).toBe(false);
  });
});

describe("simulacro de psicotécnicos", () => {
  it("genera 80 ítems con todos los tipos, sin la solución en lo que se muestra", async () => {
    const { buildPsychoMock } = await import("@/lib/learning/mock/psycho");
    let s = 1;
    const items = buildPsychoMock(80, () => (s = (s * 48271) % 2147483647));
    expect(items).toHaveLength(80);
    expect(new Set(items.map((i) => i.item_type)).size).toBe(7);
    for (const it of items) {
      expect(it.answer_index).toBeGreaterThanOrEqual(0);
      expect(it.answer_index).toBeLessThan(it.presented.options.length);
      expect(JSON.stringify(it.presented)).not.toMatch(/answerIndex|explanation/);
    }
  });

  it("limita los tipos al formato de la oposición (config.item_types)", async () => {
    const { buildPsychoMock } = await import("@/lib/learning/mock/psycho");
    let s = 7;
    const only = ["series", "numeric", "analogies", "attention"];
    const items = buildPsychoMock(30, () => (s = (s * 48271) % 2147483647), only);
    expect(items).toHaveLength(30);
    expect(new Set(items.map((i) => i.item_type))).toEqual(new Set(only));
    // valores no válidos se ignoran y se usan todos los tipos
    const all = buildPsychoMock(14, () => (s = (s * 48271) % 2147483647), "x");
    expect(new Set(all.map((i) => i.item_type)).size).toBe(7);
  });

  it("respeta las cantidades por tipo y las agrupa en bloques (formato AGE)", async () => {
    const { buildPsychoMock, psychoSlots } = await import("@/lib/learning/mock/psycho");
    let s = 3;
    // el orden de las claves no importa (jsonb lo cambia): manda el del registro
    const mix = { tables: 12, codes: 3, series: 3, equations: 4, probability: 3, percentages: 5 };
    const items = buildPsychoMock(30, () => (s = (s * 48271) % 2147483647), mix);
    const order = ["series", "percentages", "equations", "probability", "codes", "tables"] as const;
    expect(items.map((i) => i.item_type)).toEqual(
      order.flatMap((t) => Array.from({ length: mix[t] }, () => t)),
    );
    // dificultad creciente dentro de cada bloque
    const tables = items.filter((i) => i.item_type === "tables").map((i) => i.difficulty);
    expect(tables[0]).toBe(1);
    expect(tables.at(-1)).toBe(5);
    // proporcional si no suman lo pedido; tipos desconocidos se ignoran
    expect(psychoSlots(10, { tables: 2, numeric: 2, nope: 5 })).toHaveLength(10);
    expect(psychoSlots(3, { tables: 1, codes: 1, equations: 1 })).toEqual([
      "equations",
      "codes",
      "tables",
    ]);
  });
});

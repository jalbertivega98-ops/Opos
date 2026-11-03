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

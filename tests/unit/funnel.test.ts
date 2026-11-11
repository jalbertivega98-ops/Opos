import { describe, expect, it } from "vitest";
import { biggestDrop, funnelRows } from "@/lib/admin/funnel";

describe("embudo del panel", () => {
  it("calcula el % desde el paso anterior y limita la barra a 100", () => {
    const rows = funnelRows([
      { key: "a", value: 1000 },
      { key: "b", value: 50 },
      { key: "c", value: 60 },
      { key: "d", value: 0 },
      { key: "e", value: 0 },
    ]);
    expect(rows.map((r) => r.rate)).toEqual([null, 5, 120, 0, null]);
    expect(rows.map((r) => r.share)).toEqual([100, 5, 100, 0, 0]);
  });

  it("admite otro paso de referencia (crear cuenta frente a visitas)", () => {
    const rows = funnelRows(
      [
        { key: "visits", value: 959 },
        { key: "start", value: 0 },
        { key: "finish", value: 0 },
        { key: "signup", value: 8 },
      ],
      { signup: "visits" },
    );
    expect(rows[3]).toMatchObject({ base: "visits", rate: 0.8 });
    expect(rows[2].rate).toBeNull();
  });

  it("señala la mayor caída ignorando pasos sin referencia", () => {
    const rows = funnelRows([
      { key: "visits", value: 959 },
      { key: "start", value: 40 },
      { key: "finish", value: 30 },
      { key: "signup", value: 8 },
      { key: "pay", value: 0 },
    ]);
    expect(biggestDrop(rows)).toBe("pay");
    expect(
      biggestDrop(
        funnelRows([
          { key: "a", value: 0 },
          { key: "b", value: 0 },
        ]),
      ),
    ).toBeNull();
  });
});

import { describe, expect, it } from "vitest";
import { dailyAverage, parsePeriod, pointsTrend, rate, trend } from "@/lib/admin/overview";

describe("resumen del panel", () => {
  it("lee el periodo y vuelve a 30 si no es válido", () => {
    expect(parsePeriod("7")).toBe(7);
    expect(parsePeriod(["90", "7"])).toBe(90);
    expect(parsePeriod("15")).toBe(30);
    expect(parsePeriod(undefined)).toBe(30);
  });

  it("compara con el periodo anterior", () => {
    expect(trend(120, 100)).toEqual({ delta: 20, direction: "up" });
    expect(trend(50, 200)).toEqual({ delta: -75, direction: "down" });
    expect(trend(5, 5)).toEqual({ delta: 0, direction: "flat" });
    expect(trend(0, 0)).toEqual({ delta: 0, direction: "flat" });
    // Sin base no hay %: solo se dice que es nuevo
    expect(trend(3, 0)).toEqual({ delta: null, direction: "up" });
  });

  it("calcula la conversión y su diferencia en puntos", () => {
    expect(rate(3, 200)).toBe(1.5);
    expect(rate(1, 0)).toBe(0);
    expect(pointsTrend(2.5, 2.1)).toEqual({ delta: 0.4, direction: "up" });
    expect(pointsTrend(1, 1)).toEqual({ delta: 0, direction: "flat" });
  });

  it("media diaria", () => {
    expect(dailyAverage([1, 2, 4])).toBe(2.3);
    expect(dailyAverage([])).toBe(0);
  });
});

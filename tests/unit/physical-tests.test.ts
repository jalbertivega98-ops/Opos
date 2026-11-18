import { describe, expect, it } from "vitest";
import {
  exercisePoints,
  formatTime,
  getPhysicalGuide,
  parseTime,
  physicalScore,
} from "@/lib/seo/physical-tests";

// ADR-052: baremos del anexo 2 de la Resolución ISP/1763/2026 (Mossos 46/26).
const guide = getPhysicalGuide("mossos-esquadra")!;
const [agility, bench, shuttle] = guide.exercises;

describe("baremos de la prueba física de Mossos", () => {
  it("circuito (menos es mejor): bordes de la tabla de hombres", () => {
    const s = agility.scale.men;
    expect(exercisePoints(s, 21.6, true)).toBe(0);
    expect(exercisePoints(s, 21.5, true)).toBe(1);
    expect(exercisePoints(s, 20.5, true)).toBe(1); // entre filas: la alcanzada
    expect(exercisePoints(s, 18.9, true)).toBe(5);
    expect(exercisePoints(s, 16.3, true)).toBe(9); // el 10 es «<16,3»
    expect(exercisePoints(s, 16.2, true)).toBe(10);
  });

  it("press de banca (más es mejor): mujeres", () => {
    const s = bench.scale.women;
    expect(exercisePoints(s, 9, false)).toBe(0);
    expect(exercisePoints(s, 10, false)).toBe(1);
    expect(exercisePoints(s, 20, false)).toBe(5);
    expect(exercisePoints(s, 34, false)).toBe(9); // el 10 es «>34»
    expect(exercisePoints(s, 35, false)).toBe(10);
  });

  it("course navette: el 10 es la marca exacta de la tabla", () => {
    expect(exercisePoints(shuttle.scale.men, 12.5, false)).toBe(10);
    expect(exercisePoints(shuttle.scale.men, 6, false)).toBe(0);
    expect(exercisePoints(shuttle.scale.women, 10, false)).toBe(10);
    expect(exercisePoints(shuttle.scale.women, 6.5, false)).toBe(5);
  });

  it("los baremos tienen 9 escalones ordenados en la dirección correcta", () => {
    for (const ex of guide.exercises)
      for (const sex of ["men", "women"] as const) {
        const { steps, top } = ex.scale[sex];
        expect(steps).toHaveLength(9);
        const all = [...steps, top.value];
        for (let i = 1; i < all.length; i++)
          expect(ex.lowerIsBetter ? all[i] <= all[i - 1] : all[i] >= all[i - 1]).toBe(true);
      }
  });

  it("nota: media de los tres, 5 para aprobar y al menos 1 punto en cada ejercicio", () => {
    const ok = physicalScore(guide, "men", [18.9, 31, 9]);
    expect(ok.points).toEqual([5, 5, 5]);
    expect(ok.total).toBe(5);
    expect(ok.passed).toBe(true);

    const zero = physicalScore(guide, "men", [16, 45, 6]);
    expect(zero.points).toEqual([10, 10, 0]);
    expect(zero.total).toBeCloseTo(6.67, 2);
    expect(zero.passed).toBe(false);
    expect(zero.failedExercises).toEqual(["shuttle"]);

    const low = physicalScore(guide, "women", [25, 13, 4.5]);
    expect(low.points).toEqual([1, 2, 2]);
    expect(low.passed).toBe(false);
  });
});

// Bombers 81/26: annex 3 de la Resolució ISP/3218/2026, de medio en medio punto.
describe("baremos de las pruebas físicas de Bombers", () => {
  const bombers = getPhysicalGuide("bombers-generalitat")!;
  const [vegetation, structural, water] = bombers.exercises;

  it("incendio de vegetación: filas de la tabla oficial", () => {
    const w = vegetation.scale.women;
    expect(exercisePoints(w, 366, true)).toBe(0); // ≥ 6'06"
    expect(exercisePoints(w, 365, true)).toBe(0.5); // 6'00" a 6'05"
    expect(exercisePoints(w, 311, true)).toBe(5); // 5'06" a 5'11"
    expect(exercisePoints(w, 253, true)).toBe(9); // 4'13" a 4'23"
    expect(exercisePoints(w, 237, true)).toBe(9.5); // 3'57" a 4'12"
    expect(exercisePoints(w, 236, true)).toBe(10); // ≤ 3'56"
    const m = vegetation.scale.men;
    expect(exercisePoints(m, 330, true)).toBe(0);
    expect(exercisePoints(m, 275, true)).toBe(5); // 4'30" a 4'35"
    expect(exercisePoints(m, 200, true)).toBe(10);
  });

  it("incendio estructural y rescate acuático: el 5 y los extremos", () => {
    expect(exercisePoints(structural.scale.women, 203, true)).toBe(5); // 3'23"
    expect(exercisePoints(structural.scale.men, 161, true)).toBe(5); // 2'41"
    expect(exercisePoints(structural.scale.men, 86, true)).toBe(10); // ≤ 1'26"
    expect(exercisePoints(structural.scale.women, 258, true)).toBe(0); // ≥ 4'18"
    expect(exercisePoints(water.scale.women, 227, true)).toBe(5); // 3'47"
    expect(exercisePoints(water.scale.men, 203, true)).toBe(5); // 3'23"
    expect(exercisePoints(water.scale.men, 129, true)).toBe(9.5); // 2'09" a 2'24"
    expect(exercisePoints(water.scale.women, 282, true)).toBe(0); // ≥ 4'42"
  });

  it("19 escalones de 0,5 ordenados y sin mínimo por ejercicio", () => {
    for (const ex of bombers.exercises)
      for (const sex of ["men", "women"] as const) {
        const { steps, top } = ex.scale[sex];
        expect(steps).toHaveLength(19);
        const all = [...steps, top.value];
        for (let i = 1; i < all.length; i++) expect(all[i]).toBeLessThan(all[i - 1]);
      }
    const r = physicalScore(bombers, "women", [366, 120, 150]);
    expect(r.points).toEqual([0, 10, 10]);
    expect(r.total).toBeCloseTo(6.67, 2);
    expect(r.passed).toBe(true);
  });

  it("lee y escribe los tiempos en minutos y segundos", () => {
    expect(parseTime("4:35")).toBe(275);
    expect(parseTime("4'35\"")).toBe(275);
    expect(parseTime("275")).toBe(275);
    expect(parseTime("4:75")).toBeNull();
    expect(parseTime("abc")).toBeNull();
    expect(formatTime(275)).toBe("4'35\"");
    expect(formatTime(86)).toBe("1'26\"");
  });
});

import { describe, expect, it } from "vitest";
import { createTranslator } from "next-intl";
import es from "../../messages/es.json";
import ca from "../../messages/ca.json";
import { dec, round } from "@/lib/learning/psycho/format";
import { solvePercentages } from "@/lib/learning/psycho/percentages";
import { sideText, solveEquation } from "@/lib/learning/psycho/equations";
import { solveProbability } from "@/lib/learning/psycho/probability";
import { decode } from "@/lib/learning/psycho/codes";
import { solveTable } from "@/lib/learning/psycho/tables";
import { generateItem, getGenerator } from "@/lib/learning/psycho/registry";
import type { Difficulty, PsychoType } from "@/lib/learning/psycho/types";

const AGE: PsychoType[] = ["percentages", "equations", "probability", "codes", "tables"];
const DIFFS = [1, 2, 3, 4, 5] as Difficulty[];

describe("formato numérico", () => {
  it("usa coma decimal y redondea .5 hacia arriba", () => {
    expect(dec(41.4)).toBe("41,40");
    expect(dec(0.625, 3)).toBe("0,625");
    expect(round(60.325)).toBe(60.33);
    expect(dec(-2.075)).toBe("-2,08");
  });
});

describe("casos del examen real (INAP 2024 y 2025, modelo A)", () => {
  it("porcentajes y fracciones", () => {
    expect(solvePercentages("discount", { price: 45, d: 8 })).toBe("41,40 €");
    expect(solvePercentages("increase", { price: 58, d: 4 })).toBe("60,32 €");
    expect(solvePercentages("absent", { n: 50, p: 64 })).toBe("18");
    expect(solvePercentages("fractions", { n: 616, a: 3, b: 2, den: 8 })).toBe("231");
    expect(solvePercentages("share", { n: 73, k: 12 })).toBe("83,56 %");
  });

  it("ecuaciones", () => {
    // 5(5x − 3) = x → 0,625
    expect(solveEquation({ m1: 5, a1: 5, c1: -3, f1: 0, m2: 1, a2: 1, c2: 0, f2: 0 })).toBe(
      "0,625",
    );
    // 9(7x − 13) = −x + 1 → 1,84
    expect(solveEquation({ m1: 9, a1: 7, c1: -13, f1: 0, m2: 1, a2: -1, c2: 1, f2: 0 })).toBe(
      "1,84",
    );
    // 10 − 9x = 4(x − 4) → 2
    expect(solveEquation({ m1: 1, a1: -9, c1: 10, f1: 1, m2: 4, a2: 1, c2: -4, f2: 0 })).toBe("2");
    expect(sideText({ m: 1, a: -9, c: 10, constFirst: true })).toBe("10 - 9x");
    expect(sideText({ m: 5, a: 5, c: -3, constFirst: false })).toBe("5(5x - 3)");
  });

  it("probabilidad", () => {
    expect(solveProbability("probability_balls_red", { r: 4, g: 3, b: 5 })).toBe("33,33 %");
    expect(solveProbability("probability_raffle_laptop", { m: 5, t: 3, l: 1 })).toBe("11,11 %");
  });

  it("codificación", () => {
    const map = "a=0001, b=0010, c=0100, d=1000, e=0011, f=0101";
    expect(decode(map, "0001010001000010")).toBe("accb");
    expect(decode(map, "000101")).toBeNull();
  });

  it("tablas: la oficina con más kilómetros", () => {
    const rows = [
      ["A-115", "w:dep_admin", "Zaragoza", "1,0", "505", "40,64"],
      ["M-254", "w:dep_marketing", "Zaragoza", "0,5", "721", "16,60"],
      ["C-491", "w:dep_admin", "Valencia", "2,0", "678", "10,84"],
      ["A-115", "w:dep_marketing", "Tarragona", "1,0", "1425", "38,90"],
      ["M-254", "w:dep_tech", "Bilbao", "2,0", "1250", "30,40"],
      ["C-510", "w:dep_sales", "Valencia", "3,0", "707", "22,34"],
      ["C-510", "w:dep_marketing", "Bilbao", "0,5", "1388", "11,78"],
      ["C-510", "w:dep_sales", "Tarragona", "2,0", "1104", "5,97"],
    ];
    const opts = ["Zaragoza", "Valencia", "Tarragona", "Bilbao"];
    expect(solveTable("trips", rows, { q: "sum_max", cat: "office", num: "km" }, opts)).toBe(
      "Bilbao",
    );
    expect(
      solveTable("trips", rows, { q: "share", cat: "office", num: "km", value: "Tarragona" }, []),
    ).toBe("32,51 %");
  });
});

describe("generadores del formato AGE", () => {
  it("todos los ítems se verifican y tienen 4 opciones distintas", () => {
    for (const type of AGE)
      for (const d of DIFFS)
        for (let i = 0; i < 150; i++) {
          const item = generateItem(type, i * 7919 + d, d);
          expect(item.options).toHaveLength(4);
          expect(new Set(item.options).size).toBe(4);
          expect(getGenerator(type)!.verify(item).ok, `${type} d=${d} seed=${item.seed}`).toBe(
            true,
          );
        }
  });

  it("son deterministas", () => {
    for (const type of AGE)
      expect(generateItem(type, 1234, 3)).toEqual(generateItem(type, 1234, 3));
  });

  it("las tablas usan palabras traducidas en castellano y catalán", () => {
    for (const [locale, messages] of [
      ["es", es],
      ["ca", ca],
    ] as const) {
      const t = createTranslator({ locale, messages, namespace: "psycho" }) as unknown as (
        key: string,
        values?: Record<string, string | number>,
      ) => string;
      const words = messages.psycho.words as Record<string, string>;
      for (let i = 0; i < 200; i++) {
        const item = generateItem("tables", i, ((i % 5) + 1) as Difficulty);
        const p = item.presentation;
        if (p.kind !== "table") throw new Error("kind");
        for (const v of Object.values(p.values ?? {}))
          if (typeof v === "string" && v.startsWith("w:"))
            expect(words[v.slice(2)], v).toBeTruthy();
        for (const o of item.options)
          if (o.startsWith("w:")) expect(words[o.slice(2)], o).toBeTruthy();
        expect(t(`problems.${p.key}`, p.values)).not.toMatch(/\{/);
      }
    }
  });

  it("cubren todos los tipos de pregunta de tablas", () => {
    const keys = new Set<string>();
    for (let i = 0; i < 400; i++) {
      const item = generateItem("tables", i, ((i % 5) + 1) as Difficulty);
      if (item.presentation.kind === "table") keys.add(item.presentation.key);
    }
    expect([...keys].sort()).toEqual(
      [
        "tables_avg_max",
        "tables_filter",
        "tables_ratio_group",
        "tables_ratio_row",
        "tables_share",
        "tables_sum_max",
      ].sort(),
    );
  });
});

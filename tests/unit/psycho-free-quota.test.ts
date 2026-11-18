import { describe, expect, it } from "vitest";
import {
  allowedCount,
  FREE_PSYCHO_PER_TYPE,
  FREE_PSYCHO_TOTAL,
  hasUnlimitedPsycho,
  psychoQuota,
} from "@/lib/learning/practice/free-quota";
import { PSYCHO_TYPES } from "@/lib/learning/psycho/types";

const item = (o: Partial<Parameters<typeof hasUnlimitedPsycho>[0][number]> = {}) => ({
  type: "bundle",
  source: "subscription",
  is_test: false,
  attempts_left: null as number | null,
  ...o,
});

describe("muestra gratis de psicotécnicos (ADR-067)", () => {
  it("el Premium real quita el límite; los packs de intentos, los gratis y los de prueba no", () => {
    expect(hasUnlimitedPsycho([item()])).toBe(true);
    expect(hasUnlimitedPsycho([item({ source: "gift" })])).toBe(true);
    expect(hasUnlimitedPsycho([item({ attempts_left: 10 })])).toBe(false);
    expect(hasUnlimitedPsycho([item({ is_test: true })])).toBe(false);
    expect(hasUnlimitedPsycho([item({ source: "free" })])).toBe(false);
    expect(hasUnlimitedPsycho([item({ type: "question_pack" })])).toBe(false);
    expect(hasUnlimitedPsycho([])).toBe(false);
  });

  it("da la misma muestra de cada tipo y descuenta lo ya hecho", () => {
    expect(FREE_PSYCHO_TOTAL).toBe(FREE_PSYCHO_PER_TYPE * PSYCHO_TYPES.length);
    const q = psychoQuota(false, { series: 3, matrices: 9 });
    if (q.unlimited) throw new Error("debía tener límite");
    expect(q.left.series).toBe(FREE_PSYCHO_PER_TYPE - 3);
    expect(q.left.matrices).toBe(0);
    expect(q.left.letters).toBe(FREE_PSYCHO_PER_TYPE);
    expect(q.totalLeft).toBe(FREE_PSYCHO_TOTAL - 3 - FREE_PSYCHO_PER_TYPE);
  });

  it("recorta la sesión a lo que queda y no recorta con Premium", () => {
    const q = psychoQuota(false, { series: 3 });
    expect(allowedCount(q, "series", 10)).toBe(2);
    expect(allowedCount(q, "letters", 20)).toBe(FREE_PSYCHO_PER_TYPE);
    expect(allowedCount(psychoQuota(false, { series: 5 }), "series", 5)).toBe(0);
    expect(allowedCount(psychoQuota(true, { series: 99 }), "series", 20)).toBe(20);
  });
});

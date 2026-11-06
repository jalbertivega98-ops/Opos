import { describe, expect, it } from "vitest";
import { couponParams, promoCodeSchema, userGrantSchema } from "@/lib/admin/user-schemas";

const USER = "11111111-1111-4111-8111-111111111111";

describe("códigos promocionales desde la ficha del alumno", () => {
  it("normaliza el código a mayúsculas y rechaza caracteres que Stripe no admite", () => {
    const ok = promoCodeSchema.parse({
      user: USER,
      code: " bienvenida-20 ",
      kind: "percent",
      value: "20",
      duration: "once",
    });
    expect(ok.code).toBe("BIENVENIDA-20");
    expect(
      promoCodeSchema.safeParse({ ...ok, code: "con espacio" }).success ||
        promoCodeSchema.safeParse({ ...ok, code: "MAL_CODIGO" }).success,
    ).toBe(false);
  });
  it("limita el porcentaje a 100 y exige meses si se repite", () => {
    const base = { user: USER, code: "ABC", kind: "percent", duration: "once" };
    expect(promoCodeSchema.safeParse({ ...base, value: "120" }).success).toBe(false);
    expect(
      promoCodeSchema.safeParse({ ...base, value: "50", duration: "repeating", months: "" })
        .success,
    ).toBe(false);
    expect(
      promoCodeSchema.safeParse({ ...base, value: "50", duration: "repeating", months: "3" })
        .success,
    ).toBe(true);
  });
  it("traduce el formulario a un cupón de Stripe (importes en céntimos)", () => {
    const amount = promoCodeSchema.parse({
      user: USER,
      code: "PACK5",
      kind: "amount",
      value: "4.99",
      duration: "once",
    });
    expect(couponParams(amount)).toEqual({
      amount_off: 499,
      currency: "eur",
      duration: "once",
      name: "PACK5",
    });
    const pct = promoCodeSchema.parse({
      user: USER,
      code: "TRES",
      kind: "percent",
      value: "50",
      duration: "repeating",
      months: "3",
    });
    expect(couponParams(pct)).toEqual({
      percent_off: 50,
      duration: "repeating",
      duration_in_months: 3,
      name: "TRES",
    });
  });
  it("asignar acceso: días opcionales", () => {
    const g = userGrantSchema.parse({ user: USER, product: USER, days: "" });
    expect(g.days).toBeNull();
    expect(userGrantSchema.safeParse({ user: USER, product: USER, days: "0" }).success).toBe(false);
  });
});

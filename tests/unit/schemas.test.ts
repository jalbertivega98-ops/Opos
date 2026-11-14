import { describe, expect, it } from "vitest";
import { fieldErrors, resetSchema, signUpSchema } from "@/lib/auth/schemas";
import { onboardingSchema } from "@/lib/onboarding/schema";
import { sanitizeSearch } from "@/lib/catalog/search";

const valid = { email: " Ana@Example.COM ", password: "abcdef12", locale: "es" };

describe("signUpSchema", () => {
  it("normaliza el email y acepta datos válidos", () => {
    const r = signUpSchema.parse(valid);
    expect(r.email).toBe("ana@example.com");
    expect(r.displayName).toBeUndefined();
  });
  it("no pide casilla de condiciones: se aceptan al pulsar el botón (ADR-056)", () => {
    expect(signUpSchema.safeParse(valid).success).toBe(true);
  });
  it.each([
    ["corta1", "password.min"],
    ["solamenteletras", "password.number"],
    ["12345678", "password.letter"],
  ])("rechaza contraseña %s (%s)", (password, code) => {
    const r = signUpSchema.safeParse({ ...valid, password });
    expect(fieldErrors(r.error!).password).toBe(code);
  });
  it("usa el código de Zod para errores genéricos", () => {
    const r = signUpSchema.safeParse({ ...valid, email: "no-es-email" });
    expect(fieldErrors(r.error!).email).toBe("invalid_format");
  });
  it("idioma desconocido cae a es", () => {
    expect(signUpSchema.parse({ ...valid, locale: "fr" }).locale).toBe("es");
  });
});

describe("resetSchema", () => {
  it("detecta contraseñas distintas", () => {
    const r = resetSchema.safeParse({ password: "abcdef12", confirm: "abcdef13", locale: "es" });
    expect(fieldErrors(r.error!).confirm).toBe("password.mismatch");
  });
});

describe("onboardingSchema", () => {
  const base = {
    exam: "mossos-esquadra",
    level: "beginner",
    weeklyHours: "10",
    goals: ["build_habit"],
    notifyConsent: false,
    locale: "ca",
  };
  it("acepta datos válidos y convierte horas", () => {
    expect(onboardingSchema.parse(base).weeklyHours).toBe(10);
  });
  it("nombre opcional: vacío se ignora y se recorta (ADR-056)", () => {
    expect(onboardingSchema.parse({ ...base, displayName: "  " }).displayName).toBeUndefined();
    expect(onboardingSchema.parse({ ...base, displayName: " Laura " }).displayName).toBe("Laura");
    expect(onboardingSchema.safeParse({ ...base, displayName: "x".repeat(81) }).success).toBe(false);
  });
  it("rechaza objetivos vacíos, desconocidos y slugs maliciosos", () => {
    expect(onboardingSchema.safeParse({ ...base, goals: [] }).success).toBe(false);
    expect(onboardingSchema.safeParse({ ...base, goals: ["hack"] }).success).toBe(false);
    expect(onboardingSchema.safeParse({ ...base, exam: "x'; drop table" }).success).toBe(false);
    expect(onboardingSchema.safeParse({ ...base, weeklyHours: "500" }).success).toBe(false);
  });
});

describe("sanitizeSearch", () => {
  it("elimina caracteres de sintaxis PostgREST y comodines", () => {
    expect(sanitizeSearch('polic%,name.eq.x)("_*')).toBe("policname.eq.x");
  });
  it("conserva acentos, apóstrofos y punto volado catalán", () => {
    expect(sanitizeSearch("  Mossos d'Esquadra  ")).toBe("Mossos d'Esquadra");
    expect(sanitizeSearch("Col·legi")).toBe("Col·legi");
  });
});

describe("csvCell", async () => {
  const { csvCell } = await import("@/lib/admin/csv");
  it("escapa comillas, comas y saltos de línea", () => {
    expect(csvCell('a,"b"')).toBe('"a,""b"""');
    expect(csvCell(null)).toBe("");
  });
  it("neutraliza fórmulas", () => {
    expect(csvCell("=HYPERLINK(1)")).toBe("'=HYPERLINK(1)");
    expect(csvCell("+34")).toBe("'+34");
  });
});

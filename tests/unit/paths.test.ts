import { describe, expect, it } from "vitest";
import { isProtectedPath, safeNextPath, stripLocale } from "@/lib/paths";

describe("stripLocale", () => {
  it.each([
    ["/ca/app", "/app"],
    ["/es/oposiciones", "/oposiciones"],
    ["/ca", "/"],
    ["/app", "/app"],
    ["/catalogo", "/catalogo"],
  ])("%s -> %s", (input, out) => expect(stripLocale(input)).toBe(out));
});

describe("isProtectedPath", () => {
  it("protege /app, /admin y subrutas con o sin idioma", () => {
    expect(isProtectedPath("/app")).toBe(true);
    expect(isProtectedPath("/ca/app/onboarding")).toBe(true);
    expect(isProtectedPath("/admin")).toBe(true);
  });
  it("no protege rutas públicas parecidas", () => {
    expect(isProtectedPath("/")).toBe(false);
    expect(isProtectedPath("/application")).toBe(false);
    expect(isProtectedPath("/oposiciones")).toBe(false);
  });
});

describe("safeNextPath (open redirect)", () => {
  it("acepta rutas internas", () => {
    expect(safeNextPath("/app/onboarding?exam=x")).toBe("/app/onboarding?exam=x");
  });
  it.each([
    "//evil.com",
    "/\\evil.com",
    "https://evil.com",
    "javascript:alert(1)",
    "app",
    "/app\n/x",
    "",
    undefined,
  ])("rechaza %s", (v) => expect(safeNextPath(v as string)).toBe("/app"));
});

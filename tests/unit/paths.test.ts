import { describe, expect, it } from "vitest";
import {
  examFromNext,
  isProtectedPath,
  onboardingPath,
  safeNextPath,
  signUpPath,
  stripLocale,
} from "@/lib/paths";

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

describe("registro con la oposición elegida", () => {
  it("signUpPath y onboardingPath conservan solo slugs válidos", () => {
    expect(signUpPath("mossos-esquadra")).toBe("/registro?exam=mossos-esquadra");
    expect(signUpPath()).toBe("/registro");
    expect(signUpPath("../evil")).toBe("/registro");
    expect(signUpPath("a&next=//evil.com")).toBe("/registro");
    expect(onboardingPath("policia-local")).toBe("/app/onboarding?exam=policia-local");
    expect(onboardingPath("X Y")).toBe("/app/onboarding");
  });

  it("examFromNext saca la oposición del destino que guarda el proxy", () => {
    expect(examFromNext("/app/onboarding?exam=auxilio-judicial")).toBe("auxilio-judicial");
    expect(examFromNext("/app/onboarding")).toBeUndefined();
    expect(examFromNext("//evil.com/?exam=x")).toBeUndefined();
    expect(examFromNext("/app?exam=<script>")).toBeUndefined();
    expect(examFromNext(undefined)).toBeUndefined();
  });
});

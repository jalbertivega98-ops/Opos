import { describe, expect, it } from "vitest";
import { stripUrl } from "@/components/web-analytics";

describe("stripUrl (Vercel Web Analytics)", () => {
  it("quita parámetros sensibles y el fragmento", () => {
    expect(stripUrl("https://www.oposaprueba.com/auth/confirm?token_hash=abc&type=email#x")).toBe(
      "https://www.oposaprueba.com/auth/confirm",
    );
    expect(stripUrl("https://www.oposaprueba.com/entrar?next=%2Fapp&email=a%40b.c")).toBe(
      "https://www.oposaprueba.com/entrar",
    );
  });
  it("conserva los utm_*", () => {
    expect(
      stripUrl("https://www.oposaprueba.com/?utm_source=tiktok&code=1&utm_campaign=lanzamiento"),
    ).toBe("https://www.oposaprueba.com/?utm_source=tiktok&utm_campaign=lanzamiento");
  });
  it("devuelve tal cual lo que no es una URL", () => {
    expect(stripUrl("/relativa")).toBe("/relativa");
  });
});

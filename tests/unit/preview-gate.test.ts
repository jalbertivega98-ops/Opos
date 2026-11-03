import { describe, expect, it } from "vitest";
import { NextRequest } from "next/server";
import { previewGate } from "@/lib/preview";

const req = (auth?: string) =>
  new NextRequest("http://localhost/", { headers: auth ? { authorization: auth } : {} });
const basic = (u: string, p: string) => `Basic ${btoa(`${u}:${p}`)}`;

describe("preview privada", () => {
  it("sin PREVIEW_PASSWORD no bloquea nada", () => {
    expect(previewGate(req(), "")).toBeNull();
  });
  it("pide credenciales y rechaza contraseñas incorrectas", () => {
    expect(previewGate(req(), "secreta")?.status).toBe(401);
    expect(previewGate(req(basic("joel", "mala")), "secreta")?.status).toBe(401);
    expect(previewGate(req(basic("joel", "secreta")), "secreta")).toBeNull();
  });
});

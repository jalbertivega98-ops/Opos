import { describe, expect, it } from "vitest";
import type { User } from "@supabase/supabase-js";
import { hasPassword, signedInRecently } from "@/lib/auth/identity";

const identity = (provider: string) =>
  ({ provider }) as unknown as NonNullable<User["identities"]>[number];

describe("hasPassword", () => {
  it("alta por correo: sí", () => {
    expect(hasPassword({ identities: [identity("email")], app_metadata: {} })).toBe(true);
  });
  it("solo Google: no", () => {
    expect(hasPassword({ identities: [identity("google")], app_metadata: {} })).toBe(false);
  });
  it("correo y Google enlazados: sí", () => {
    const identities = [identity("google"), identity("email")];
    expect(hasPassword({ identities, app_metadata: {} })).toBe(true);
  });
  it("sin identidades usa app_metadata", () => {
    expect(hasPassword({ app_metadata: { providers: ["google"] } })).toBe(false);
    expect(hasPassword({ app_metadata: { provider: "email" } })).toBe(true);
  });
});

describe("signedInRecently", () => {
  const now = Date.parse("2026-11-06T12:00:00Z");
  it("dentro de los 10 minutos", () => {
    expect(signedInRecently({ last_sign_in_at: "2026-11-06T11:52:00Z" }, now)).toBe(true);
  });
  it("fuera de plazo o sin dato", () => {
    expect(signedInRecently({ last_sign_in_at: "2026-11-06T11:40:00Z" }, now)).toBe(false);
    expect(signedInRecently({ last_sign_in_at: undefined }, now)).toBe(false);
  });
});

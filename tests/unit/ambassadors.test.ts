import { describe, expect, it } from "vitest";
import { ambassadorTarget, ambassadorUrl, parseAmbassadorPath } from "@/lib/ambassadors/link";
import { ambassadorCreateSchema, optionalRefSchema } from "@/lib/ambassadors/schemas";

describe("enlace de embajadora (ADR-054)", () => {
  it("reconoce /r/<código> en castellano y catalán y normaliza a minúsculas", () => {
    expect(parseAmbassadorPath("/r/laura")).toEqual({ code: "laura", prefix: "" });
    expect(parseAmbassadorPath("/r/Laura-Opos/")).toEqual({ code: "laura-opos", prefix: "" });
    expect(parseAmbassadorPath("/ca/r/marta")).toEqual({ code: "marta", prefix: "/ca" });
  });

  it("ignora rutas y códigos no válidos", () => {
    for (const p of [
      "/r",
      "/r/",
      "/r/a",
      "/r/con espacio",
      "/r/x/y",
      "/registro",
      "/r/%E0%A4%A",
      "/r/<script>",
    ]) {
      expect(parseAmbassadorPath(p)).toBeNull();
    }
  });

  it("lleva al registro con el código y genera la URL pública", () => {
    expect(ambassadorTarget({ code: "laura", prefix: "/ca" })).toBe("/ca/registro?ref=laura");
    expect(ambassadorUrl("https://www.oposaprueba.com/", "laura")).toBe(
      "https://www.oposaprueba.com/r/laura",
    );
  });

  it("el código del registro es opcional y se descarta si no es válido", () => {
    expect(optionalRefSchema.parse(" LAURA ")).toBe("laura");
    expect(optionalRefSchema.parse("mal código!")).toBeUndefined();
    expect(optionalRefSchema.parse(undefined)).toBeUndefined();
  });

  it("valida el alta de embajadora", () => {
    const ok = ambassadorCreateSchema.safeParse({
      code: "Laura",
      name: "Laura",
      network: "instagram",
      handle: "",
      exam: "",
      notes: "",
    });
    expect(ok.success && ok.data).toMatchObject({ code: "laura", handle: null, exam: null });
    expect(ambassadorCreateSchema.safeParse({ code: "x", name: "", network: "fax" }).success).toBe(
      false,
    );
  });
});

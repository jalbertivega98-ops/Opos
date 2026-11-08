import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { randomUUID } from "node:crypto";
import { cleanup, connect } from "./helpers";

/** Alta con «Continuar con Google» (ADR-040): el perfil toma el nombre que da Google. */
let client: pg.Client;
const ids: string[] = [];

async function insertUser(meta: Record<string, unknown>) {
  const id = randomUUID();
  ids.push(id);
  await client.query(
    `insert into auth.users (id, instance_id, aud, role, email, raw_user_meta_data, created_at, updated_at)
     values ($1, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', $2, $3, now(), now())`,
    [id, `g-${id.slice(0, 8)}@example.test`, JSON.stringify(meta)],
  );
  const { rows } = await client.query(
    "select display_name, locale from public.profiles where id = $1",
    [id],
  );
  return rows[0] as { display_name: string | null; locale: string };
}

beforeAll(async () => {
  client = await connect();
});
afterAll(async () => {
  await cleanup(client, ids);
  await client.end();
});

describe("perfil al entrar con Google", () => {
  it("usa full_name de Google como nombre visible", async () => {
    const p = await insertUser({ full_name: "Laura Pérez", name: "Laura Pérez", iss: "google" });
    expect(p).toEqual({ display_name: "Laura Pérez", locale: "es" });
  });

  it("si solo hay name, usa name", async () => {
    expect((await insertUser({ name: "  Marc  " })).display_name).toBe("Marc");
  });

  it("el nombre del alta por correo sigue teniendo prioridad", async () => {
    const p = await insertUser({ display_name: "Ana", full_name: "Ana García", locale: "ca" });
    expect(p).toEqual({ display_name: "Ana", locale: "ca" });
  });

  it("sin nombre queda vacío y recorta nombres largos a 80", async () => {
    expect((await insertUser({})).display_name).toBeNull();
    expect((await insertUser({ full_name: "x".repeat(120) })).display_name).toHaveLength(80);
  });
});

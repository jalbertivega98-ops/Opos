import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

let client: pg.Client;
let student: { id: string }, other: { id: string };

beforeAll(async () => {
  client = await connect();
  student = await createUser(client);
  other = await createUser(client);
});
afterAll(async () => {
  await cleanup(client, [student.id, other.id]);
  await client.end();
});

describe("tutorial de bienvenida", () => {
  it("un perfil nuevo no lo ha visto y complete_welcome_tour lo marca solo para él", async () => {
    await as(client, { uid: student.id }, async (q) => {
      const before = await q("select tour_completed_at from public.profiles where id = $1", [
        student.id,
      ]);
      expect(before.rows[0].tour_completed_at).toBeNull();
      await q("select public.complete_welcome_tour()");
      const after = await q("select id, tour_completed_at from public.profiles");
      const mine = after.rows.find((r) => r.id === student.id);
      expect(mine?.tour_completed_at).not.toBeNull();
      // RLS: no ve el perfil de otra persona.
      expect(after.rows.some((r) => r.id === other.id)).toBe(false);
    });
    const { rows } = await client.query(
      "select tour_completed_at from public.profiles where id = $1",
      [other.id],
    );
    expect(rows[0].tour_completed_at).toBeNull();
  });

  it("repetirlo no cambia la fecha", async () => {
    await as(client, { uid: student.id }, async (q) => {
      await q("select public.complete_welcome_tour()");
      const a = await q("select tour_completed_at from public.profiles where id = $1", [
        student.id,
      ]);
      await q("select public.complete_welcome_tour()");
      const b = await q("select tour_completed_at from public.profiles where id = $1", [
        student.id,
      ]);
      expect(b.rows[0].tour_completed_at).toEqual(a.rows[0].tour_completed_at);
    });
  });

  it("el alumno no puede escribir la columna directamente", async () => {
    await expect(
      as(client, { uid: student.id }, (q) =>
        q("update public.profiles set tour_completed_at = null where id = $1", [student.id]),
      ),
    ).rejects.toThrow(/permission denied/);
  });

  it("sin sesión no se puede llamar", async () => {
    await expect(
      as(client, "anon", (q) => q("select public.complete_welcome_tour()")),
    ).rejects.toThrow(/permission denied/);
  });
});

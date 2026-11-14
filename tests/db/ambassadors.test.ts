import { randomUUID } from "node:crypto";
import { afterAll, beforeAll, describe, expect, it } from "vitest";
import type pg from "pg";
import { as, cleanup, connect, createUser } from "./helpers";

/** Alta con el código en los metadatos, como hace signUpAction. */
async function createReferredUser(client: pg.Client, ref: string) {
  const id = randomUUID();
  await client.query(
    `insert into auth.users (id, instance_id, aud, role, email, raw_user_meta_data, created_at, updated_at)
     values ($1, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', $2, $3, now(), now())`,
    [id, `ref-${id.slice(0, 8)}@example.test`, JSON.stringify({ locale: "es", ref })],
  );
  return id;
}

describe("programa de embajadoras (ADR-054)", () => {
  let client: pg.Client;
  const ids: string[] = [];
  const code = `emb-${randomUUID().slice(0, 8)}`;
  let ambassador: string;
  let student: string;
  let admin: string;

  beforeAll(async () => {
    client = await connect();
    student = (await createUser(client)).id;
    admin = (await createUser(client, { role: "admin" })).id;
    ids.push(student, admin);
    const { rows } = await client.query(
      "insert into public.ambassadors (code, name) values ($1, 'Prueba') returning id",
      [code],
    );
    ambassador = rows[0].id;
  });
  afterAll(async () => {
    await client.query("delete from public.ambassadors where code like 'emb-%'");
    await cleanup(client, ids);
    await client.end();
  });

  it("el alta por correo con código queda atribuida (sin distinguir mayúsculas)", async () => {
    const id = await createReferredUser(client, code.toUpperCase());
    ids.push(id);
    const { rows } = await client.query(
      "select ambassador_id from public.ambassador_referrals where user_id = $1",
      [id],
    );
    expect(rows[0]?.ambassador_id).toBe(ambassador);
  });

  it("un código inexistente o de una embajadora inactiva no rompe el alta ni atribuye", async () => {
    const unknown = await createReferredUser(client, "no-existe-xyz");
    ids.push(unknown);
    await client.query("update public.ambassadors set active = false where id = $1", [ambassador]);
    const inactive = await createReferredUser(client, code);
    ids.push(inactive);
    await client.query("update public.ambassadors set active = true where id = $1", [ambassador]);
    const { rows } = await client.query(
      "select count(*)::int as n from public.ambassador_referrals where user_id = any($1::uuid[])",
      [[unknown, inactive]],
    );
    expect(rows[0].n).toBe(0);
    const { rows: profiles } = await client.query(
      "select count(*)::int as n from public.profiles where id = any($1::uuid[])",
      [[unknown, inactive]],
    );
    expect(profiles[0].n).toBe(2);
  });

  it("claim_referral: solo cuentas recientes, una vez y para sí mismas", async () => {
    const fresh = (await createUser(client)).id;
    ids.push(fresh);
    const claimed = await as(client, { uid: fresh }, async (q) => {
      const first = await q("select public.claim_referral($1) as ok", [code]);
      const second = await q("select public.claim_referral($1) as ok", [code]);
      const { rows } = await q(
        "select count(*)::int as n from public.ambassador_referrals where user_id = $1",
        [fresh],
      ).catch(() => ({ rows: [{ n: -1 }] }));
      return { first: first.rows[0].ok, second: second.rows[0].ok, n: rows[0].n };
    });
    expect(claimed.first).toBe(true);
    expect(claimed.second).toBe(false);
    // El alumno no puede leer la tabla (solo admin).
    expect(claimed.n).toBe(0);

    await client.query(
      "update public.profiles set created_at = now() - interval '3 days' where id = $1",
      [student],
    );
    const old = await as(client, { uid: student }, (q) =>
      q("select public.claim_referral($1) as ok", [code]),
    );
    expect(old.rows[0].ok).toBe(false);
    await expect(
      as(client, "anon", (q) => q("select public.claim_referral($1)", [code])),
    ).rejects.toThrow(/permission denied/);
  });

  it("nadie escribe atribuciones directamente ni llama a record_referral", async () => {
    for (const who of [{ uid: student }, { uid: admin }] as const) {
      await expect(
        as(client, who, (q) =>
          q("insert into public.ambassador_referrals (user_id, ambassador_id) values ($1, $2)", [
            student,
            ambassador,
          ]),
        ),
      ).rejects.toThrow(/permission denied/);
      await expect(
        as(client, who, (q) => q("select public.record_referral($1, $2)", [student, code])),
      ).rejects.toThrow(/permission denied/);
    }
  });

  it("solo service_role suma visitas, y solo a códigos activos", async () => {
    await as(client, "service", async (q) => {
      const ok = await q("select public.track_ambassador_visit($1) as ok", [code]);
      const bad = await q("select public.track_ambassador_visit('no-existe-xyz') as ok");
      expect(ok.rows[0].ok).toBe(true);
      expect(bad.rows[0].ok).toBe(false);
      const { rows } = await q(
        "select hits from public.ambassador_visits_daily where ambassador_id = $1",
        [ambassador],
      );
      expect(rows[0].hits).toBe(1);
    });
    for (const who of ["anon", { uid: student }, { uid: admin }] as const) {
      await expect(
        as(client, who, (q) => q("select public.track_ambassador_visit($1)", [code])),
      ).rejects.toThrow(/permission denied/);
    }
  });

  it("solo admin gestiona embajadoras y ve el resumen", async () => {
    const studentView = await as(client, { uid: student }, (q) =>
      q("select count(*)::int as n from public.ambassadors"),
    );
    expect(studentView.rows[0].n).toBe(0);
    await expect(
      as(client, { uid: student }, (q) =>
        q("insert into public.ambassadors (code, name) values ('emb-alumno', 'X')"),
      ),
    ).rejects.toThrow(/row-level security|permission denied/);
    await expect(
      as(client, { uid: student }, (q) => q("select * from public.admin_ambassador_stats(30)")),
    ).rejects.toThrow(/No autorizado/);

    await as(client, { uid: admin }, async (q) => {
      await q(
        "insert into public.ambassadors (code, name, network) values ('emb-admin', 'Y', 'tiktok')",
      );
      const { rows } = await q(
        "select * from public.admin_ambassador_stats(30) where ambassador_id = $1",
        [ambassador],
      );
      expect(Number(rows[0].signups_total)).toBe(1);
      expect(Number(rows[0].paid_total)).toBe(0);
    });
  });

  it("valida el formato del código", async () => {
    await expect(
      client.query("insert into public.ambassadors (code, name) values ('Con Espacios', 'Z')"),
    ).rejects.toThrow(/check constraint/);
  });
});

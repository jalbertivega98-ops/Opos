import pg from "pg";
import { randomUUID } from "node:crypto";

/**
 * Utilidades para probar RLS directamente en PostgreSQL, imitando lo que hace
 * PostgREST: `set local role` + `request.jwt.claims` dentro de una transacción.
 */
export const DB_URL = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";

export async function connect() {
  const client = new pg.Client({ connectionString: DB_URL });
  await client.connect();
  return client;
}

export async function createUser(client: pg.Client, opts: { role?: string; locale?: string } = {}) {
  const id = randomUUID();
  const email = `test-${id.slice(0, 8)}@example.test`;
  await client.query(
    `insert into auth.users (id, instance_id, aud, role, email, raw_user_meta_data, created_at, updated_at)
     values ($1, '00000000-0000-0000-0000-000000000000', 'authenticated', 'authenticated', $2, $3, now(), now())`,
    [id, email, JSON.stringify({ locale: opts.locale ?? "es", display_name: "Test" })],
  );
  if (opts.role)
    await client.query("update public.profiles set role = $2 where id = $1", [id, opts.role]);
  return { id, email };
}

/** Ejecuta fn como `authenticated` (con uid), `anon` o `service_role`, siempre con rollback. */
export async function as<T>(
  client: pg.Client,
  who: { uid: string } | "anon" | "service",
  fn: (q: (sql: string, params?: unknown[]) => Promise<pg.QueryResult>) => Promise<T>,
): Promise<T> {
  await client.query("begin");
  try {
    if (who === "service") {
      await client.query("set local role service_role");
      await client.query(
        `select set_config('request.jwt.claims', '{"role":"service_role"}', true)`,
      );
    } else if (who === "anon") {
      await client.query("set local role anon");
      await client.query(`select set_config('request.jwt.claims', '{"role":"anon"}', true)`);
    } else {
      await client.query("set local role authenticated");
      await client.query("select set_config('request.jwt.claims', $1, true)", [
        JSON.stringify({ sub: who.uid, role: "authenticated" }),
      ]);
    }
    return await fn((sql, params) => client.query(sql, params as unknown[]));
  } finally {
    await client.query("rollback");
  }
}

export async function cleanup(client: pg.Client, ids: string[]) {
  if (ids.length) await client.query("delete from auth.users where id = any($1::uuid[])", [ids]);
}

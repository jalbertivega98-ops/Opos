// Aplica supabase/migrations/*.sql en orden y registra versiones en
// supabase_migrations.schema_migrations (misma tabla que usa Supabase CLI).
// Uso: node scripts/stack/migrate.mjs [--seed] [--reset]
import { readdirSync, readFileSync, existsSync } from "node:fs";
import { join } from "node:path";
import pg from "pg";

const url = process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia";
const root = new URL("../../supabase/", import.meta.url).pathname;
const client = new pg.Client({ connectionString: url });
await client.connect();

const args = new Set(process.argv.slice(2));
if (args.has("--reset")) {
  console.log("· reset: eliminando esquema public y datos de auth (solo local)");
  await client.query(`drop schema if exists public cascade; create schema public;
    grant usage on schema public to anon, authenticated, service_role;
    grant all on schema public to postgres;
    alter default privileges in schema public grant all on tables to anon, authenticated, service_role;
    alter default privileges in schema public grant all on functions to anon, authenticated, service_role;
    alter default privileges in schema public grant all on sequences to anon, authenticated, service_role;
    truncate supabase_migrations.schema_migrations;
    delete from auth.users;`);
}

const done = new Set(
  (await client.query("select version from supabase_migrations.schema_migrations")).rows.map(
    (r) => r.version,
  ),
);
const dir = join(root, "migrations");
for (const file of readdirSync(dir).filter((f) => f.endsWith(".sql")).sort()) {
  const [version, ...rest] = file.replace(/\.sql$/, "").split("_");
  if (done.has(version)) continue;
  const sql = readFileSync(join(dir, file), "utf8");
  process.stdout.write(`· migración ${file} ... `);
  try {
    await client.query("begin");
    await client.query(sql);
    await client.query(
      "insert into supabase_migrations.schema_migrations(version, name) values ($1, $2)",
      [version, rest.join("_")],
    );
    await client.query("commit");
    console.log("ok");
  } catch (e) {
    await client.query("rollback");
    console.log("ERROR");
    console.error(e.message);
    process.exit(1);
  }
}
if (args.has("--seed") && existsSync(join(root, "seed.sql"))) {
  process.stdout.write("· seed.sql ... ");
  await client.query(readFileSync(join(root, "seed.sql"), "utf8"));
  console.log("ok");
}
await client.query("notify pgrst, 'reload schema'");
await client.end();

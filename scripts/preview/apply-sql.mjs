// Aplica en la base de datos de la PREVIEW (Supabase) los SQL de supabase/preview
// que aún no se han aplicado o que han cambiado. Lo ejecuta GitHub Actions en
// cada push a main (.github/workflows/preview-db.yml), así joel no tiene que
// pegarlos a mano.
//
//   PREVIEW_DATABASE_URL=postgresql://… node scripts/preview/apply-sql.mjs
//
// * 1-esquema-y-contenido.sql y 2-cuentas.sql son el arranque manual (crean el
//   esquema y necesitan usuarios creados a mano): nunca se ejecutan aquí.
// * Del 3 en adelante todos son idempotentes; se registran por nombre y huella
//   en public.preview_sql_applied y solo se repiten si cambia el archivo.
// * Nunca toca producción: solo la URL de la preview que se le pase.
import { readdirSync, readFileSync } from "node:fs";
import { createHash } from "node:crypto";
import pg from "pg";

const url = process.env.PREVIEW_DATABASE_URL;
if (!url) {
  console.log("PREVIEW_DATABASE_URL no está configurada: no se aplica nada.");
  process.exit(0);
}
const DIR = "supabase/preview";
const MANUAL = new Set(["1-esquema-y-contenido.sql", "2-cuentas.sql"]);
const order = (name) => {
  const m = name.match(/^(\d+)([a-z]?)-/);
  return m ? Number(m[1]) * 100 + (m[2] ? m[2].charCodeAt(0) - 96 : 0) : Infinity;
};
const files = readdirSync(DIR)
  .filter((f) => f.endsWith(".sql") && !MANUAL.has(f))
  .sort((a, b) => order(a) - order(b));

const local = /@(127\.0\.0\.1|localhost)[:/]/.test(url);
const ca = process.env.PREVIEW_DATABASE_CA;
const db = new pg.Client({
  connectionString: url.replace(/[?&]sslmode=[^&]*/, ""),
  ssl: local ? false : ca ? { ca } : { rejectUnauthorized: false },
  statement_timeout: 300_000,
});
await db.connect();
try {
  const base = await db.query("select to_regclass('public.profiles') as t");
  if (!base.rows[0].t) {
    throw new Error("La base de datos no tiene el esquema base: ejecuta antes 1- y 2- a mano.");
  }
  await db.query(`create table if not exists public.preview_sql_applied (
      name text primary key,
      sha256 text not null,
      applied_at timestamptz not null default now())`);
  await db.query("alter table public.preview_sql_applied enable row level security");
  await db.query("revoke all on public.preview_sql_applied from anon, authenticated");

  const done = new Map(
    (await db.query("select name, sha256 from public.preview_sql_applied")).rows.map((r) => [
      r.name,
      r.sha256,
    ]),
  );
  let applied = 0;
  for (const f of files) {
    const sql = readFileSync(`${DIR}/${f}`, "utf8");
    const sha = createHash("sha256").update(sql).digest("hex");
    if (done.get(f) === sha) {
      console.log(`= ${f} (ya aplicado)`);
      continue;
    }
    process.stdout.write(`→ ${f} … `);
    await db.query(sql);
    await db.query(
      `insert into public.preview_sql_applied (name, sha256) values ($1, $2)
       on conflict (name) do update set sha256 = excluded.sha256, applied_at = now()`,
      [f, sha],
    );
    console.log("ok");
    applied++;
  }
  console.log(`Listo: ${applied} archivo(s) aplicados, ${files.length - applied} sin cambios.`);
} catch (e) {
  console.error(`\nError: ${e.message}`);
  process.exitCode = 1;
} finally {
  await db.end();
}

// Asigna un rol de personal a un usuario existente (solo con acceso directo a la BD).
// Uso: LOCAL_DB_URL=... node scripts/grant-role.mjs <email> <student|editor|admin|owner>
// En producción ejecutar el SQL equivalente desde el editor SQL de Supabase (docs/DEPLOYMENT.md).
import pg from "pg";

const [email, role] = process.argv.slice(2);
const ROLES = ["student", "editor", "admin", "owner"];
if (!email || !ROLES.includes(role)) {
  console.error("Uso: node scripts/grant-role.mjs <email> <student|editor|admin|owner>");
  process.exit(1);
}
const client = new pg.Client({
  connectionString: process.env.LOCAL_DB_URL ?? "postgres://postgres@127.0.0.1:54322/academia",
});
await client.connect();
const { rows } = await client.query(
  `update public.profiles p set role = $2::public.app_role
     from auth.users u where u.id = p.id and lower(u.email) = lower($1)
   returning p.id`,
  [email, role],
);
if (rows.length === 0) {
  console.error(`No existe ningún usuario con email ${email}`);
  process.exit(1);
}
await client.query(
  `insert into public.audit_log (actor_id, action, target_type, target_id, metadata)
   values (null, 'role.granted_cli', 'profile', $1, jsonb_build_object('role', $2::text))`,
  [rows[0].id, role],
);
console.log(`Rol ${role} asignado a ${email}`);
await client.end();

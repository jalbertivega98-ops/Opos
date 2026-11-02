// Genera claves JWT de DESARROLLO (anon / service_role) firmadas con el secreto local.
// Nunca usar estos valores fuera de la máquina local.
import { createHmac } from "node:crypto";

export const DEV_JWT_SECRET =
  process.env.LOCAL_JWT_SECRET ?? "dev-only-jwt-secret-change-me-0123456789abcdef";

const b64 = (obj) => Buffer.from(JSON.stringify(obj)).toString("base64url");

export function sign(payload, secret = DEV_JWT_SECRET) {
  const head = b64({ alg: "HS256", typ: "JWT" });
  const body = b64(payload);
  const sig = createHmac("sha256", secret).update(`${head}.${body}`).digest("base64url");
  return `${head}.${body}.${sig}`;
}

const exp = 2_000_000_000;
export const ANON_KEY = sign({ iss: "supabase-local", role: "anon", exp });
export const SERVICE_KEY = sign({ iss: "supabase-local", role: "service_role", exp });

if (import.meta.url === `file://${process.argv[1]}`) {
  console.log(`LOCAL_JWT_SECRET=${DEV_JWT_SECRET}`);
  console.log(`ANON_KEY=${ANON_KEY}`);
  console.log(`SERVICE_KEY=${SERVICE_KEY}`);
}

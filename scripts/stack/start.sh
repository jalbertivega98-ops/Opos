#!/usr/bin/env bash
# Arranca la pila local compatible con Supabase SIN Docker:
#   PostgreSQL 16 (:54322) + GoTrue (:9999) + PostgREST (:3001)
#   + Mailpit (SMTP :54325, UI :54324) + pasarela (:54321)
# Requisitos: binarios en .local-stack/bin (scripts/stack/setup.sh) y PostgreSQL 16 instalado.
# Argumentos opcionales se pasan a migrate.mjs (--seed, --reset).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STACK="$ROOT/.local-stack"
BIN="$STACK/bin"
PGBIN="${PGBIN:-$(ls -d /usr/lib/postgresql/*/bin | sort -V | tail -1)}"
PGDATA="$STACK/pgdata"
LOGS="$STACK/logs"
mkdir -p "$LOGS"
eval "$(node "$ROOT/scripts/stack/keys.mjs")"

# PostgreSQL no puede ejecutarse como root: usamos un usuario sin privilegios si hace falta.
RUN_AS=()
if [ "$(id -u)" = "0" ]; then
  PGUSER_OS="${PG_OS_USER:-claude}"
  id "$PGUSER_OS" >/dev/null 2>&1 || useradd -m "$PGUSER_OS"
  mkdir -p "$PGDATA"
  chown -R "$PGUSER_OS" "$PGDATA" "$LOGS"
  RUN_AS=(runuser -u "$PGUSER_OS" --)
fi

if [ ! -f "$PGDATA/PG_VERSION" ]; then
  echo "· initdb"
  "${RUN_AS[@]}" "$PGBIN/initdb" -D "$PGDATA" -U postgres --auth=trust -E UTF8 --locale=C.UTF-8 >"$LOGS/initdb.log"
fi
if ! "${RUN_AS[@]}" "$PGBIN/pg_ctl" -D "$PGDATA" status >/dev/null 2>&1; then
  "${RUN_AS[@]}" "$PGBIN/pg_ctl" -D "$PGDATA" -l "$LOGS/postgres.log" \
    -o "-p 54322 -k /tmp -c listen_addresses=127.0.0.1" -w start
fi
PSQL=(psql -h 127.0.0.1 -p 54322 -U postgres -v ON_ERROR_STOP=1 -q)
"${PSQL[@]}" -d postgres -tc "select 1 from pg_database where datname='academia'" | grep -q 1 \
  || "${PSQL[@]}" -d postgres -c "create database academia"
"${PSQL[@]}" -d academia -f "$ROOT/scripts/stack/bootstrap.sql"

start_bg() { # nombre, comando...
  local name="$1"; shift
  if [ -f "$STACK/$name.pid" ] && kill -0 "$(cat "$STACK/$name.pid")" 2>/dev/null; then return; fi
  nohup "$@" >"$LOGS/$name.log" 2>&1 &
  echo $! >"$STACK/$name.pid"
}

start_bg mailpit "$BIN/mailpit" --smtp 127.0.0.1:54325 --listen 127.0.0.1:54324 \
  --smtp-auth-accept-any --smtp-auth-allow-insecure

export GOTRUE_API_HOST=127.0.0.1 PORT=9999
export API_EXTERNAL_URL="http://127.0.0.1:54321/auth/v1"
export GOTRUE_DB_DRIVER=postgres GOTRUE_DB_NAMESPACE=auth
export DATABASE_URL="postgres://supabase_auth_admin:auth-admin-dev@127.0.0.1:54322/academia?sslmode=disable"
export GOTRUE_SITE_URL="${SITE_URL:-http://localhost:3000}"
export GOTRUE_URI_ALLOW_LIST="http://localhost:3000/**,http://127.0.0.1:3000/**"
export GOTRUE_JWT_SECRET="$LOCAL_JWT_SECRET" GOTRUE_JWT_EXP=3600 GOTRUE_JWT_AUD=authenticated
# DEFAULT_GROUP_NAME está marcado como obsoleto pero sin él los usuarios nuevos reciben role="" en el JWT.
export GOTRUE_JWT_DEFAULT_GROUP_NAME=authenticated GOTRUE_JWT_ADMIN_ROLES=service_role
export GOTRUE_DISABLE_SIGNUP=false GOTRUE_EXTERNAL_EMAIL_ENABLED=true GOTRUE_MAILER_AUTOCONFIRM=false
export GOTRUE_SMTP_HOST=127.0.0.1 GOTRUE_SMTP_PORT=54325 GOTRUE_SMTP_USER=dev GOTRUE_SMTP_PASS=dev
export GOTRUE_SMTP_ADMIN_EMAIL="no-reply@aprobia.local" GOTRUE_SMTP_SENDER_NAME="OPOSAPRUEBA (local)"
export GOTRUE_RATE_LIMIT_EMAIL_SENT=1000 GOTRUE_RATE_LIMIT_VERIFY=1000 GOTRUE_RATE_LIMIT_TOKEN_REFRESH=1000
export GOTRUE_PASSWORD_MIN_LENGTH=8
export GOTRUE_MAILER_URLPATHS_CONFIRMATION=/auth/v1/verify GOTRUE_MAILER_URLPATHS_RECOVERY=/auth/v1/verify
export GOTRUE_MAILER_URLPATHS_INVITE=/auth/v1/verify GOTRUE_MAILER_URLPATHS_EMAIL_CHANGE=/auth/v1/verify
start_bg gotrue "$BIN/auth"

for _ in $(seq 1 40); do
  curl -sf http://127.0.0.1:9999/health >/dev/null && break
  sleep 0.5
done
curl -sf http://127.0.0.1:9999/health >/dev/null || { echo "GoTrue no arrancó; ver $LOGS/gotrue.log"; exit 1; }

node "$ROOT/scripts/stack/migrate.mjs" "$@"

cat >"$STACK/postgrest.conf" <<CONF
db-uri = "postgres://authenticator:authenticator-dev@127.0.0.1:54322/academia"
db-schemas = "public"
db-anon-role = "anon"
db-channel-enabled = true
db-config = false
jwt-secret = "$LOCAL_JWT_SECRET"
server-host = "127.0.0.1"
server-port = 3001
CONF
start_bg postgrest "$BIN/postgrest" "$STACK/postgrest.conf"
start_bg gateway node "$ROOT/scripts/stack/gateway.mjs"
sleep 1
echo
echo "Pila local lista:"
echo "  API (Supabase URL): http://127.0.0.1:54321"
echo "  Base de datos:      postgres://postgres@127.0.0.1:54322/academia"
echo "  Correo (Mailpit):   http://127.0.0.1:54324"

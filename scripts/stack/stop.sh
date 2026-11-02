#!/usr/bin/env bash
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STACK="$ROOT/.local-stack"
PGBIN="${PGBIN:-$(ls -d /usr/lib/postgresql/*/bin | sort -V | tail -1)}"
for n in gateway postgrest gotrue mailpit; do
  pidfile="${STACK:?}/${n:?}.pid"
  if [ -f "$pidfile" ]; then
    kill "$(cat "$pidfile")" 2>/dev/null
    rm -f -- "$pidfile"
  fi
done
RUN_AS=()
[ "$(id -u)" = "0" ] && RUN_AS=(runuser -u "${PG_OS_USER:-claude}" --)
"${RUN_AS[@]}" "$PGBIN/pg_ctl" -D "$STACK/pgdata" stop -m fast 2>/dev/null || true
echo "Pila local detenida."

#!/usr/bin/env bash
# Descarga los binarios oficiales de la pila local (una sola vez) en .local-stack/bin.
# Fuentes: releases oficiales de supabase/auth, PostgREST y axllent/mailpit en GitHub.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
BIN="$ROOT/.local-stack/bin"
DL="$ROOT/.local-stack/downloads"
mkdir -p "$BIN" "$DL"
GOTRUE_V=v2.180.0
POSTGREST_V=v13.0.4
MAILPIT_V=v1.27.10
if [ ! -x "$BIN/auth" ]; then
  curl -fsSL -o "$DL/auth.tgz" "https://github.com/supabase/auth/releases/download/$GOTRUE_V/auth-$GOTRUE_V-x86.tar.gz"
  tar xzf "$DL/auth.tgz" -C "$BIN"
fi
if [ ! -x "$BIN/postgrest" ]; then
  curl -fsSL -o "$DL/postgrest.txz" "https://github.com/PostgREST/postgrest/releases/download/$POSTGREST_V/postgrest-$POSTGREST_V-linux-static-x86-64.tar.xz"
  tar xJf "$DL/postgrest.txz" -C "$BIN"
fi
if [ ! -x "$BIN/mailpit" ]; then
  curl -fsSL -o "$DL/mailpit.tgz" "https://github.com/axllent/mailpit/releases/download/$MAILPIT_V/mailpit-linux-amd64.tar.gz"
  tar xzf "$DL/mailpit.tgz" -C "$BIN" mailpit
fi
echo "Binarios listos en $BIN"

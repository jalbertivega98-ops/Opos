#!/usr/bin/env bash
# Genera el SQL de la preview (preguntas en BORRADOR + fichas) de una carpeta de content/.
# Uso: bash scripts/content/preview-sql.sh <carpeta de content> <salida.sql> "<descripción>"
set -euo pipefail
dir="$1"; out="$2"; desc="$3"
{
  echo "-- ${desc}: preguntas en BORRADOR con cita literal de la fuente oficial y fichas de estudio."
  echo "-- Generado: bash scripts/content/preview-sql.sh ${dir} ${out}. Idempotente."
  echo "begin;"
  for f in "${dir}"/*.json; do node scripts/content/to-sql.mjs "$f"; done
  if compgen -G "${dir}/fichas/*.json" > /dev/null; then
    node scripts/content/notes-to-sql.mjs "${dir}"/fichas/*.json
  fi
  echo "commit;"
} > "${out}"
echo "${out}: $(grep -c '^with q as' "${out}") preguntas"

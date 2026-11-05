#!/usr/bin/env bash
# Instala extensiones listadas en dotfiles/cursor-extensions.txt
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LIST="${ROOT}/dotfiles/cursor-extensions.txt"

if ! command -v cursor >/dev/null 2>&1; then
  echo "cursor CLI no está en PATH. Abre Cursor al menos una vez." >&2
  exit 1
fi

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  echo "==> $line"
  cursor --install-extension "$line"
done < "$LIST"

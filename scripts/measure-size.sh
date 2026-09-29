#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

LOC="$(find src/Iter -type f -name '*.fs' -print0 | xargs -0 cat | wc -l | tr -d ' ')"
BYTES="$(find src/Iter -type f -name '*.fs' -print0 | xargs -0 cat | wc -c | tr -d ' ')"

echo "Iter production F# source: $LOC lines, $BYTES bytes"

if [ "$LOC" -gt 1000 ]; then
  echo "ERROR: Iter production source exceeded the initial 1,000-line minimality budget."
  exit 1
fi

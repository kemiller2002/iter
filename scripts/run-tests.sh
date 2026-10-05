#!/usr/bin/env bash
# Test-execution integrity gate (ITR-F2).
#
# Iter's test project is a dependency-free executable runner (R0.2, R8.2,
# R12.11 forbid a third-party test framework). `dotnet test` must therefore
# execute that runner, and a green result is only accepted when the runner
# reports a non-zero number of executed tests with zero failures. A run that
# executes nothing is a failure, never a pass.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

CONFIGURATION="${CONFIGURATION:-Release}"
LOG="$(mktemp)"
trap 'rm -f "$LOG"' EXIT

set +e
dotnet test Iter.slnx --configuration "$CONFIGURATION" --no-build "$@" 2>&1 | tee "$LOG"
STATUS="${PIPESTATUS[0]}"
set -e

if [ "$STATUS" -ne 0 ]; then
  echo "ERROR: dotnet test failed with exit code $STATUS."
  exit "$STATUS"
fi

SUMMARY="$(grep -Eo 'Iter\.Tests: [0-9]+ executed; [0-9]+ passed; [0-9]+ failed' "$LOG" | tail -n 1 || true)"

if [ -z "$SUMMARY" ]; then
  echo "ERROR: dotnet test reported success but the Iter.Tests runner did not execute (no summary line)."
  exit 1
fi

EXECUTED="$(echo "$SUMMARY" | sed -E 's/.*: ([0-9]+) executed.*/\1/')"
FAILED="$(echo "$SUMMARY" | sed -E 's/.*; ([0-9]+) failed/\1/')"

if [ "$EXECUTED" -eq 0 ]; then
  echo "ERROR: zero tests executed; refusing to report success."
  exit 1
fi

if [ "$FAILED" -ne 0 ]; then
  echo "ERROR: $FAILED test(s) failed."
  exit 1
fi

echo "Test-execution integrity: $EXECUTED test(s) executed, 0 failed."

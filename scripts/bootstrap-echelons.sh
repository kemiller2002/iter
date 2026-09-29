#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

component_field() {
  local id="$1"
  local field="$2"
  node -e '
const fs = require("fs");
const [id, field] = process.argv.slice(1);
const data = JSON.parse(fs.readFileSync(".echelon/desired-components.json", "utf8"));
const component = data.components.find(x => x.id === id);
if (!component || component[field] == null) process.exit(2);
process.stdout.write(String(component[field]));
' "$id" "$field"
}

PRAXIS_VERSION="$(component_field praxis version)"
ORDO_VERSION="$(component_field ordo version)"
VISUAL_VERSION="$(component_field visual-engineering version)"
COMMUNICATION_COMMIT="$(component_field communication-engineering commit)"
TUTELA_COMMIT="$(component_field tutela commit)"

INSTALL_BASE="${ECHELON_HOME:-${RUNNER_TEMP:-$HOME/.echelon}/iter-echelons}"
export ECHELON_HOME="$INSTALL_BASE"
export PATH="$INSTALL_BASE/bin:$PATH"

TMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TMP_ROOT"' EXIT

echo "Installing native Praxis $PRAXIS_VERSION"
curl -fsSL https://raw.githubusercontent.com/kemiller2002/praxis/main/scripts/install-native.sh -o "$TMP_ROOT/install-praxis.sh"
sh "$TMP_ROOT/install-praxis.sh" --version "$PRAXIS_VERSION" --install-base "$INSTALL_BASE"

echo "Installing native Ordo $ORDO_VERSION"
curl -fsSL https://raw.githubusercontent.com/kemiller2002/ordo/main/scripts/install-native.sh -o "$TMP_ROOT/install-ordo.sh"
sh "$TMP_ROOT/install-ordo.sh" --version "$ORDO_VERSION" --install-base "$INSTALL_BASE"

echo "Installing Praxis repository governance"
praxis init

echo "Installing Ordo repository methodology"
ordo init

echo "Installing Visual Engineering $VISUAL_VERSION"
npx --yes --package="@echelon-foundry/visual-engineering@$VISUAL_VERSION" visual-engineering init

echo "Installing Communication Engineering at $COMMUNICATION_COMMIT"
COMMUNICATION_DIR="$TMP_ROOT/communication-engineering"
git clone --quiet https://github.com/kemiller2002/communication-engineering.git "$COMMUNICATION_DIR"
git -C "$COMMUNICATION_DIR" checkout --quiet "$COMMUNICATION_COMMIT"
node "$COMMUNICATION_DIR/bin/communication-engineering.mjs" init --root "$ROOT"

echo "Installing Tutela at $TUTELA_COMMIT"
TUTELA_DIR="$TMP_ROOT/tutela"
git clone --quiet https://github.com/kemiller2002/tutela.git "$TUTELA_DIR"
git -C "$TUTELA_DIR" checkout --quiet "$TUTELA_COMMIT"
node "$TUTELA_DIR/bin/tutela.mjs" init --root "$ROOT"

echo "Verifying installed lifecycle capabilities"
praxis verify --strict
ordo verify --strict
npx --yes --package="@echelon-foundry/visual-engineering@$VISUAL_VERSION" visual-engineering verify --strict
node "$COMMUNICATION_DIR/bin/communication-engineering.mjs" verify --strict --root "$ROOT"
node "$TUTELA_DIR/bin/tutela.mjs" verify --strict --root "$ROOT"

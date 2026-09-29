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
COMMUNICATION_VERSION="$(component_field communication-engineering version)"
TUTELA_COMMIT="$(component_field tutela commit)"

echo "Installing Praxis $PRAXIS_VERSION"
npx --yes --package="@echelon-foundry/repository-operating-system@$PRAXIS_VERSION" ros init

echo "Installing Ordo $ORDO_VERSION"
npx --yes --package="@echelon-foundry/sde@$ORDO_VERSION" sde init

echo "Installing Visual Engineering $VISUAL_VERSION"
npx --yes --package="@echelon-foundry/visual-engineering@$VISUAL_VERSION" visual-engineering init

echo "Installing Communication Engineering $COMMUNICATION_VERSION"
npx --yes --package="@echelon-foundry/communication-engineering@$COMMUNICATION_VERSION" communication-engineering init

echo "Installing Tutela at $TUTELA_COMMIT"
TUTELA_DIR="$(mktemp -d)"
trap 'rm -rf "$TUTELA_DIR"' EXIT
git clone --quiet https://github.com/kemiller2002/tutela.git "$TUTELA_DIR"
git -C "$TUTELA_DIR" checkout --quiet "$TUTELA_COMMIT"
node "$TUTELA_DIR/bin/tutela.mjs" init --root "$ROOT"

echo "Verifying installed lifecycle capabilities"
npx --yes --package="@echelon-foundry/repository-operating-system@$PRAXIS_VERSION" ros verify --strict
npx --yes --package="@echelon-foundry/sde@$ORDO_VERSION" sde verify --strict
npx --yes --package="@echelon-foundry/visual-engineering@$VISUAL_VERSION" visual-engineering verify --strict
npx --yes --package="@echelon-foundry/communication-engineering@$COMMUNICATION_VERSION" communication-engineering verify --strict
node "$TUTELA_DIR/bin/tutela.mjs" verify --strict --root "$ROOT"

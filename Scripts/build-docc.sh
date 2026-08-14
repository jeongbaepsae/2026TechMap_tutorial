#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE_PATH="${1:-YachtDice}"
BUILD_ROOT="$ROOT/.docc-build"
DERIVED_DATA="$BUILD_ROOT/DerivedData"
SITE="$BUILD_ROOT/site"

rm -rf "$BUILD_ROOT"
mkdir -p "$SITE"

xcodebuild docbuild \
  -project "$ROOT/YachtDice.xcodeproj" \
  -scheme YachtDice \
  -destination 'generic/platform=visionOS' \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGNING_ALLOWED=NO \
  DOCC_HOSTING_BASE_PATH="$BASE_PATH"

ARCHIVE="$(find "$DERIVED_DATA/Build/Products" -name 'YachtDice.doccarchive' -print -quit)"

if [[ -z "$ARCHIVE" ]]; then
  echo "YachtDice.doccarchive was not found." >&2
  exit 1
fi

cp -R "$ARCHIVE"/. "$SITE"/
touch "$SITE/.nojekyll"

echo "DocC static site: $SITE"
echo "Hosting base path: /$BASE_PATH"

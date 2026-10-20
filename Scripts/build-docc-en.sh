#!/usr/bin/env bash
# Builds the English DocC catalog (DocC-en/YachtDice.docc) into a static-hosting site.
#
# Usage: Scripts/build-docc-en.sh <hosting-base-path> <output-dir>
#   e.g. Scripts/build-docc-en.sh 2026TechMap_tutorial/en site/en
#
# Images and the tutorial project-files zip are shared with the Korean catalog, so they
# are overlaid onto a temporary copy of the English catalog instead of being duplicated
# in the repository.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE_PATH="${1:?hosting base path is required (e.g. 2026TechMap_tutorial/en)}"
OUTPUT="${2:?output directory is required}"

KO_RESOURCES="$ROOT/YachtDice/YachtDice.docc/Resources"
EN_CATALOG="$ROOT/DocC-en/YachtDice.docc"

STAGING="$(mktemp -d)"
trap 'rm -rf "$STAGING"' EXIT

cp -R "$EN_CATALOG" "$STAGING/YachtDice.docc"
mkdir -p "$STAGING/YachtDice.docc/Resources/Images" "$STAGING/YachtDice.docc/Resources/Downloads"
cp -R "$KO_RESOURCES/Images/." "$STAGING/YachtDice.docc/Resources/Images/"
cp -R "$KO_RESOURCES/Downloads/." "$STAGING/YachtDice.docc/Resources/Downloads/"

xcrun docc convert "$STAGING/YachtDice.docc" \
  --fallback-display-name YachtDice \
  --fallback-bundle-identifier com.example.yachtdice.en \
  --output-path "$OUTPUT" \
  --transform-for-static-hosting \
  --hosting-base-path "$BASE_PATH"

touch "$OUTPUT/.nojekyll"
echo "English DocC site: $OUTPUT"
echo "Hosting base path: /$BASE_PATH"

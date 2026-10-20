#!/usr/bin/env bash
# Adds the 한국어 | English toggle (Scripts/lang-toggle.js) to every page of a combined
# DocC site, where the Korean site is at the site root and the English site is at /en.
#
# Usage: Scripts/inject-lang-toggle.sh <site-dir> <hosting-base-path>
#   e.g. Scripts/inject-lang-toggle.sh site 2026TechMap_tutorial
set -euo pipefail

SITE="${1:?site directory is required}"
BASE="${2:?hosting base path is required (e.g. 2026TechMap_tutorial)}"
HERE="$(cd "$(dirname "$0")" && pwd)"

cp "$HERE/lang-toggle.js" "$SITE/lang-toggle.js"

export TAG="<script defer data-lang-toggle data-base=\"/${BASE}\" src=\"/${BASE}/lang-toggle.js\"></script>"

# DocC writes one near-identical index.html per route (thousands of files), so patch them in batches.
find "$SITE" -name index.html -print0 \
  | xargs -0 perl -0pi -e 's{</body>}{$ENV{TAG}</body>} unless /data-lang-toggle/'

total=$(find "$SITE" -name index.html | wc -l | tr -d ' ')
missing=$(find "$SITE" -name index.html -print0 | xargs -0 grep -L 'data-lang-toggle' | wc -l | tr -d ' ')
if [ "$missing" -ne 0 ]; then
  echo "::error::Language toggle was not injected into $missing of $total pages." >&2
  exit 1
fi
echo "Language toggle injected into $total pages."

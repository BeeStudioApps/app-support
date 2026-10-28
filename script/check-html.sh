#!/usr/bin/env sh
set -eu

for file in \
  index.html \
  styles.css \
  numplo/privacy/index.html \
  numplo/support/index.html \
  beat4/privacy/index.html \
  beat4/support/index.html; do
  test -f "$file"
done

for path in \
  /app-support/numplo/privacy/ \
  /app-support/numplo/support/ \
  /app-support/beat4/privacy/ \
  /app-support/beat4/support/; do
  rg -F "$path" . --glob '*.html' --glob '*.md' >/dev/null
done

if rg -n 'in the reviewed|reviewed production|reviewed cloud' --glob '*.html'; then
  echo 'Public policy pages must not include audit-only wording.' >&2
  exit 1
fi

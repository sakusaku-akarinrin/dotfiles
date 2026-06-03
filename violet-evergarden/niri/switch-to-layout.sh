#!/bin/bash
# switch-to-layout.sh
# Switch to a specific keyboard layout by index.
# Usage: switch-to-layout.sh <index>
#
# Reads current layout from niri msg keyboard-layouts (JSON),
# and switches via niri msg action switch-layout until the
# target index is reached.

set -eu

TARGET="${1:-0}"

LAYOUTS="$(niri msg --json keyboard-layouts)"
CURRENT="$(echo "$LAYOUTS" | jq -r '.current_idx')"
COUNT="$(echo "$LAYOUTS" | jq -r '.names | length')"

[ "$CURRENT" = "$TARGET" ] && exit 0

# Calculate forward distance from current to target.
i=1
while [ "$i" -lt "$COUNT" ]; do
    NEXT="$(( (CURRENT + i) % COUNT ))"
    [ "$NEXT" = "$TARGET" ] && break
    i="$((i + 1))"
done

for _ in $(seq 1 "$i"); do
    niri msg action switch-layout next
done

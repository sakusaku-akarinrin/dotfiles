#!/bin/bash
# ╭────────────────────────────────────────────╮
# │  🌸  Waybar Language Module for Niri  🌸 │
# ╰────────────────────────────────────────────╯
# Displays current keyboard layout.
# Signal: pkill -SIGRTMIN+1 waybar  (bind to layout-switch)
#
# Suggested Niri keybind:
#   Mod+Space { spawn-sh "niri msg action switch-layout next; pkill -SIGRTMIN+1 waybar"; }

LAYOUTS=$(niri msg keyboard-layouts 2>/dev/null)

if [ -z "$LAYOUTS" ]; then
    echo "??"
    exit 0
fi

# Extract the first (active) layout name
ACTIVE=$(echo "$LAYOUTS" | grep -oP '".*?":' | head -1 | tr -d '":')

case "${ACTIVE:-us}" in
    us|en)  echo " EN" ;;
    th)     echo " TH" ;;
    jp|ja)  echo " JP" ;;
    *)      echo " ${ACTIVE^^}" ;;
esac

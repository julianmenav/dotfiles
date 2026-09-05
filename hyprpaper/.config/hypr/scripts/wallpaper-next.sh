#!/usr/bin/env bash
# Cycle hyprpaper through the Tokyo Night wallpapers (all monitors). Bound to Super+Shift+W.
# Usage: wallpaper-next.sh [next|prev]
set -euo pipefail
dir="$HOME/.config/backgrounds"
mapfile -t walls < <(ls -1 "$dir"/tokyo-night-*.{png,jpg} 2>/dev/null | sort)
[ ${#walls[@]} -gt 0 ] || { notify-send "Wallpaper" "no tokyo-night-* files in $dir"; exit 1; }

current=$(hyprctl hyprpaper listactive 2>/dev/null | head -1 | sed 's/^[^:]*: //')
current=$(readlink -f "$current" 2>/dev/null || true)
idx=-1
for i in "${!walls[@]}"; do
    [ "$(readlink -f "${walls[$i]}")" = "$current" ] && idx=$i && break
done
if [ "${1:-next}" = "prev" ]; then
    next=$(( (idx - 1 + ${#walls[@]}) % ${#walls[@]} ))
else
    next=$(( (idx + 1) % ${#walls[@]} ))
fi
hyprctl hyprpaper wallpaper ",${walls[$next]}" >/dev/null
notify-send -a "Wallpaper" -t 1500 "$(basename "${walls[$next]}" | sed 's/tokyo-night-//; s/\..*//')"

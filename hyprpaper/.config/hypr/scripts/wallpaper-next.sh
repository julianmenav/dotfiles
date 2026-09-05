#!/usr/bin/env bash
# Cycle hyprpaper through the rice wallpapers (rose-pine-*, tokyo-night-*) on all monitors.
# Bound to Super+Shift+W. Usage: wallpaper-next.sh [next|prev]
set -euo pipefail
dir="$HOME/.config/backgrounds"
mapfile -t walls < <(ls -1 "$dir"/rose-pine-* "$dir"/tokyo-night-* 2>/dev/null | grep -Ei '\.(png|jpe?g)$' | sort)
[ ${#walls[@]} -gt 0 ] || { notify-send "Wallpaper" "no rose-pine-*/tokyo-night-* files in $dir"; exit 1; }

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
name=$(basename "${walls[$next]}"); name=${name#rose-pine-}; name=${name#tokyo-night-}; name=${name%.*}
notify-send -a "Wallpaper" -t 1500 "$name"

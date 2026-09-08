#!/bin/sh
# Screen recording toggle (Super+Ctrl+Delete).
# First press: draw a region with slurp (Escape cancels), wf-recorder records it.
# Second press: stop; the file is in ~/Videos/recordings.
# Video only. For sound add `--audio` to the wf-recorder line (default PipeWire source).
dir=~/Videos/recordings
command -v wf-recorder >/dev/null || { notify-send -u critical -a record "wf-recorder is not installed" "sudo pacman -S wf-recorder"; exit 1; }

if pgrep -x wf-recorder >/dev/null; then
    pkill -INT -x wf-recorder
    notify-send -a record "Recording saved" "$(ls -t "$dir"/*.mp4 | head -1)"
    exit 0
fi

geometry=$(slurp) || exit 0
mkdir -p "$dir"
file="$dir/rec-$(date +%Y%m%d-%H%M%S).mp4"
notify-send -a record "Recording…" "Super+Ctrl+Delete stops it"
exec wf-recorder -g "$geometry" -f "$file"

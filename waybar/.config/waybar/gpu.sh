#!/usr/bin/env bash
# GPU usage for waybar (custom/gpu). NVIDIA via nvidia-smi, AMD via sysfs; prints nothing otherwise.
if command -v nvidia-smi >/dev/null; then
    IFS=', ' read -r util temp used total < <(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null)
    [ -n "$util" ] || exit 0
    vram=$(awk -v u="$used" -v t="$total" 'BEGIN{printf "%.1f / %.1f GiB", u/1024, t/1024}')
elif f=$(ls /sys/class/drm/card*/device/gpu_busy_percent 2>/dev/null | head -1); then
    util=$(cat "$f")
    hw=$(ls "$(dirname "$f")"/hwmon/hwmon*/temp1_input 2>/dev/null | head -1)
    [ -n "$hw" ] && temp=$(( $(cat "$hw") / 1000 )) || temp="?"
    vram="n/a"
else
    exit 0
fi
class=""; [ "${temp:-0}" != "?" ] && [ "${temp:-0}" -ge 85 ] && class="hot"
printf '{"text":"󰢮  %s%%","tooltip":"GPU %s%%  ·  %s°C  ·  VRAM %s","class":"%s"}\n' "$util" "$util" "$temp" "$vram" "$class"

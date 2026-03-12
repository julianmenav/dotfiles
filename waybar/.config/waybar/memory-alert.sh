#!/usr/bin/env bash
# Waybar custom memory module — adds "warning" class when used RAM > threshold

THRESHOLD_GB=20

read -r mem_total mem_available _ < <(awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{printf "%s %s", t, a}' /proc/meminfo)

used_kb=$(( mem_total - mem_available ))
used_gb=$(awk "BEGIN{printf \"%.1f\", $used_kb / 1048576}")
total_gb=$(awk "BEGIN{printf \"%.1f\", $mem_total / 1048576}")

class=""
if awk "BEGIN{exit !($used_kb / 1048576 > $THRESHOLD_GB)}"; then
    class="warning"
fi

printf '{"text":"󰍛  %sG","tooltip":"Used: %sG / Total: %sG","class":"%s"}\n' \
    "$used_gb" "$used_gb" "$total_gb" "$class"

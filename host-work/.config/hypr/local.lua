-- Work machine. Loaded at the end of hyprland.lua.

-- Monitors — https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({ output = "DP-1",     mode = "preferred", position = "0x0",  scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1 })

-- Slack
hl.bind("SUPER + S", hl.dsp.exec_cmd("/usr/bin/slack --disable-gpu-compositing --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --enable-features=WebRTCPipeWireCapturer --enable-features=WaylandWindowDecorations --disable-features=WaylandFractionalScaleV1"))

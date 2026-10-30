-- Home desktop: CachyOS, RTX 4060 (nvidia-open). Loaded at the end of hyprland.lua.

-- Monitors — https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({ output = "DP-2",     mode = "1920x1080@165", position = "0x0",    scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60",  position = "1920x0", scale = 1 })

-- NVIDIA — https://wiki.hypr.land/Nvidia/
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Uncomment if the cursor flickers or disappears
-- hl.config({ cursor = { no_hardware_cursors = true } })

-- Dofus 3 (Unity, XWayland): never tile it. When tiled, Unity saves the tile
-- size as the game resolution and renders a downscaled viewport into the slot
-- ("everything looks zoomed out"). Force fullscreen on the monitor it opens on.
hl.window_rule({
    name  = "dofus-fullscreen",
    match = { class = [[^(Dofus\.x64)$]] },
    -- NOTE: `fullscreen = true` was silently ignored on 0.56.2 (tested);
    -- fullscreen_state = "<internal> <client>", 2 = fullscreen, works.
    fullscreen_state = "2 2",
})

-- Baldur's Gate 3 (native SDL2 build, XWayland): SDL drops fullscreen when the
-- window loses focus (mouse crossing to the other monitor). Ignore fullscreen
-- requests coming from the client so only Super+Shift+F changes it.
hl.window_rule({
    name  = "bg3-keep-fullscreen",
    match = { class = "^(bg3)$" },
    suppress_event = "fullscreen",
})

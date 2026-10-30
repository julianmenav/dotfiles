-- Hyprland config (Lua, Hyprland >= 0.57).
-- Refer to the wiki for more information: https://wiki.hypr.land/configuring/
-- Per-machine monitors, GPU env and machine-only binds live in local.lua
-- (provided by the host-* stow package) and are loaded at the end of this file.

local mainMod = "SUPER" -- Sets "Windows" key as main modifier


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
-- Fallback; per-machine monitors are in local.lua (loaded at the end)
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.bind(mainMod .. " + F1", hl.dsp.workspace.move({ monitor = 0 }))
hl.bind(mainMod .. " + F2", hl.dsp.workspace.move({ monitor = 1 }))


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/
-- Runs once, on compositor start (the old exec-once).
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & hypridle & hyprpaper & clipse -listen & dunst")
    -- Polkit agent so GUI apps can ask for a password
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- Video wallpaper (mpvpaper) on top of hyprpaper; hypridle reruns the script after suspend
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper-video.sh")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    -- GTK theme, icons, cursor, font
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Tokyo-Night' && gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-purple' && gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice' && gsettings set org.gnome.desktop.interface cursor-size 24 && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' && gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
-- Qt apps follow qt6ct
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/configuring/core/config-options/

-- Tokyo Night
local borderActive   = { colors = { "rgba(bb9af7ff)", "rgba(b4f9f8ff)" }, angle = 45 }
local borderInactive = { colors = { "rgba(565f89cc)", "rgba(9aa5cecc)" }, angle = 45 }

hl.config({
    general = {
        gaps_in     = 3,
        gaps_out    = 8,
        border_size = 2,

        col = {
            active_border   = borderActive,
            inactive_border = borderInactive,
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    group = {
        col = {
            border_active          = borderActive,
            border_inactive        = borderInactive,
            border_locked_active   = borderActive,
            border_locked_inactive = borderInactive,
        },
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Translucent windows + blur; fullscreen and the opaque-content rule stay solid
        active_opacity     = 0.98,
        inactive_opacity   = 0.9,
        fullscreen_opacity = 1.0,
        dim_special        = 0.3,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = false,
            special           = true,
        },
    },

    animations = {
        enabled = true,
    },

    -- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
    dwindle = {
        preserve_split = true, -- You probably want this
    },

    -- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper  = 0,    -- no anime mascot on the fallback background
        disable_hyprland_logo    = true, -- no Hyprland logo on the fallback background
        disable_splash_rendering = true, -- no joke line ("Designed in California...") at the bottom
    },

    ecosystem = {
        no_update_news  = true, -- no "Hyprland updated to x.y.z" popup after upgrades
        no_donation_nag = true,
    },

    input = {
        kb_layout  = "us,es",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/configuring/core/animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Ref https://wiki.hypr.land/configuring/core/rules/workspace-rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1",   match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })

-- Example per-device config
-- See https://wiki.hypr.land/configuring/core/devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/ for more
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
-- hl.bind(mainMod .. " + M",   hl.dsp.exit())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo()) -- dwindle
-- hl.bind(mainMod .. " + J",   hl.dsp.layout("togglesplit")) -- dwindle

-- Screenshots (Delete = capture; Shift = window, Ctrl = video)
hl.bind(mainMod .. " + SHIFT + DELETE", hl.dsp.exec_cmd("hyprshot -m window -o ~/Images/screenshots"))
hl.bind(mainMod .. " + DELETE",         hl.dsp.exec_cmd("hyprshot -m region -o ~/Images/screenshots"))
-- Region recording, press again to stop -> ~/Videos/recordings
hl.bind(mainMod .. " + CTRL + DELETE",  hl.dsp.exec_cmd("~/.config/hypr/scripts/record-toggle.sh"))

-- FullScreen: Super+F = maximize (waybar stays), Super+Shift+F = true fullscreen (covers waybar)
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized",  action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + TAB",       hl.dsp.window.cycle_next())

-- Lock
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("hyprlock"))

-- Wallpaper: next image
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper-next.sh"))

-- Emojis
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofi -show emoji -modi emoji -no-show-icons -theme-str 'listview { lines: 12; }'"))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special (magic) workspace (scratchpad)
hl.bind(mainMod .. " + M",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- clipse
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("kitty --class clipse clipse"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name  = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- clipse floating always
hl.window_rule({
    name  = "clipse-float",
    match = { class = "^(clipse)$" },
    float        = true,
    size         = { 800, 600 },
    stay_focused = true,
})

-- Keep browsers, media and file managers opaque
hl.window_rule({
    name  = "opaque-content",
    match = { class = [[^(firefox|google-chrome|chromium|[Bb]rave-browser|mpv|vlc|[Ss]team|org\.kde\.dolphin|dolphin)$]] },
    opaque = true,
})

-- Blur the shell layers
hl.layer_rule({
    name  = "shell-blur",
    match = { namespace = "^(waybar|rofi|notifications)$" },
    blur         = true,
    ignore_alpha = 0,
})


---------------------
---- PER-MACHINE ----
---------------------

-- Monitors, GPU env, machine-only binds. Provided by the host-* package (stow exactly one).
-- ~/.config/hypr is on package.path, so this loads ~/.config/hypr/local.lua.
-- Drop the module cache first so `hyprctl reload` picks up edits to local.lua.
package.loaded["local"] = nil
local ok, err = pcall(require, "local")
if not ok then
    hl.notification.create({
        text    = "hyprland.lua: local.lua not loaded (stow a host-* package): " .. tostring(err),
        timeout = 10000,
        color   = "rgb(f7768e)",
    })
end

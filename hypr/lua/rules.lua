-- vim: foldmethod=marker ft=lua

-- ============================================================
--  _      ___         __                   __
-- | | /| / (_)__  ___/ /__ _    ______    / /  ___ ___ _____ ________
-- | |/ |/ / / _ \/ _  / _ \ |/|/ /___/   / /__/ _ `/ // / -_) __/___/
-- |__/|__/_/_//_/\_,_/\___/__,__/   ( ) /____/\_,_/\_, /\__/_/     ( )
--                                   |/            /___/            |/
--  _      __         __                                   __
-- | | /| / /__  ____/ /__ ___ ___  ___ ________ ______ __/ /__ ___
-- | |/ |/ / _ \/ __/  '_/(_-</ _ \/ _ `/ __/ -_) __/ // / / -_|_-<
-- |__/|__/\___/_/ /_/\_\/___/ .__/\_,_/\__/\__/_/  \_,_/_/\__/___/
--                          /_/
-- ============================================================

-- Workspacerules {{{
hl.workspace_rule({ workspace = "special:magic", gaps_in = 24, gaps_out = 72 })

hl.workspace_rule({ workspace = "10", layout = "monocle" })

hl.workspace_rule({
    workspace = "f[1]s[false]",
    gaps_out = 23,
})
-- }}}

-- Windowrules {{{
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "suppress-fullscreen-events",
    match = { class = ".*" },
    suppress_event = "fullscreen",
})

hl.window_rule({
    name = "float_and_resize-pw",
    match = { title = "Pipewire Volume Control" },
    float = true,
    size = { 768, 768 },
})

hl.window_rule({
    name = "float_and_resize-iwgtk",
    match = { title = "iwgtk" },
    float = true,
    size = { 768, 768 },
})

hl.window_rule({
    name = "float_and_resize-copyq",
    match = { class = "copyq" },
    float = true,
    center = true,
    size = { 768, 1024 },
})

hl.window_rule({
    name = "float_and_resize-dummy",
    match = { title = "Dummy manual" },
    float = true,
    size = { 768, 768 },
})

hl.window_rule({
    name = "float_and_resize-g-cal",
    match = { class = "chrome-calendar.google.com__-Default" },
    float = true,
    size = { 1280, 768 },
})

hl.window_rule({
    name = "float_and_resize-monitor-conf",
    match = { title = "Monitor config" },
    float = true,
    size = { 768, 480 },
})

hl.window_rule({
    name = "float_and_resize-pacman",
    match = { title = "Pacman" },
    float = true,
    size = { 870, 768 },
})

hl.window_rule({
    name = "float_and_resize-qalc",
    match = { title = "qalc floating" },
    float = true,
    size = { 840, 768 },
})

hl.window_rule({
    name = "float_and_resize-zellij",
    match = { title = "zellij_floating" },
    float = true,
    size = { 1680, 1280 },
})

hl.window_rule({
    name = "float_and_resize-showmethekeys",
    match = { class = "showmethekey-gtk" },
    float = true,
    size = { 768, 144 },
})

hl.window_rule({
    name = "float_and_resize-satty",
    match = { title = "satty" },
    float = true,
    size = { 1280, 768 },
})

hl.window_rule({
    name = "float_and_resize-nsxiv",
    match = { title = "nsxiv" },
    float = true,
    center = true,
    -- size = { 768, 480 },
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "fullscreen-borders",
    match = { fullscreen = true },
    border_size = 4,
})

-- hl.window_rule({
--     name = "group no fade animation",
--     match = { group = true },
--     animation = "popin 0%",
-- })

hl.window_rule({
    name = "wofi-dim",
    match = { class = "wofi" },
    dim_around = true,
})

hl.window_rule({
    name = "lock-screen",
    match = { title = "lock_bg" },
    no_anim = true,
    fullscreen_state = 2,
    workspace = "name:lock silent",
})

-- }}}

-- Layerrules {{{
hl.layer_rule({
    name = "anim_awww",
    match = { namespace = "awww-daemon" },
    animation = "fade",
})

hl.layer_rule({
    name = "no_anim_hyprpicker",
    match = { namespace = "hyprpicker" },
    no_anim = true,
})

hl.layer_rule({
    name = "no_anim_selection",
    match = { namespace = "selection" },
    no_anim = true,
})

hl.layer_rule({
    name = "notifications",
    match = { namespace = "notifications" },
    animation = "slide",
})

hl.layer_rule({
    name = "waybar",
    match = { namespace = "waybar" },
    animation = "fade",
})

-- }}}

-- vim: foldmethod=marker

-- ============================================================
--    ___          __   __              ____  ___  _______  ____
--   / _ \___ ___ / /__/ /____  ___    / __ \/ _ \/  _/ _ \/ __/
--  / // / -_|_-</  '_/ __/ _ \/ _ \  / /_/ / , _// // // / _/
-- /____/\__/___/_/\_\\__/\___/ .__/  \____/_/|_/___/____/___/
--                           /_/
-- ============================================================

-- See https://wiki.hypr.land/configuring/core/environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("WLR_NO_HARDWARE_CURSORS","1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.config({
    layout = {
        single_window_aspect_ratio = { 48, 38 },
    },

    cursor = {
        no_hardware_cursors = 1,
    },
})

hl.monitor({
    output = "",
    mode = "3440x1440@200",
    -- cm = "wide",
    -- bitdepth = 10,
    scale = "1",
})

hl.config({
    decoration = {
        blur = {
            enabled = false,
            size = 2,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    group = {
        col = {
            border_active = "rgba(BD93F9FF)",
            border_inactive = "rgba(44475aff)",
        },

        groupbar = {
            font_size = 16,
            font_family = "JetBrainsMonoNL Nerd Font Mono",
            height = 20,
        },
    },

    animations = {
        enabled = true,
    },
})

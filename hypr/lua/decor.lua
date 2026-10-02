-- vim: foldmethod=marker

-- ============================================================
--    ___                        __  _
--   / _ \___ _______  _______ _/ /_(_)__  ___  ___
--  / // / -_) __/ _ \/ __/ _ `/ __/ / _ \/ _ \(_-<
-- /____/\__/\__/\___/_/  \_,_/\__/_/\___/_//_/___/
-- ============================================================

hl.config({
    general = { -- {{{
        gaps_in = 12,
        gaps_out = 24,

        border_size = 2,

        col = {
            active_border = "rgba(BD93F9FF)",
            inactive_border = "rgba(44475aff)",
        },

        resize_on_border = true,

        allow_tearing = true,

        layout = "dwindle",
    }, -- }}}

    decoration = { -- {{{
        rounding = 0,
        rounding_power = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        dim_special = 0.5,

        shadow = {
            enabled = false,
            range = 4,
            render_power = 3,
            color = "0xee1a1a1a",
        },

        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    }, -- }}}

    group = { -- {{{
        col = {
            border_active = "rgba(BD93F9FF)",
            border_inactive = "rgba(44475aff)",
        },

        groupbar = {
            enabled = true,
            font_size = 20,
            font_family = "JetBrainsMonoNL Nerd Font Mono",
            height = 24,

            indicator_height = 0,
            rounding = 0,

            gaps_in = 0,
            render_titles = true,

            gradient_rounding = 0,
            gradients = true,

            col = {
                active = "rgba(45475aff)",
                inactive = "rgba(181825ff)",
            },
        },
    }, -- }}}

    animations = {
        enabled = true,
    },
})

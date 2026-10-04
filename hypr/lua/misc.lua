-- vim: foldmethod=marker

-- ============================================================
--    __  ____
--   /  |/  (_)__ ____
--  / /|_/ / (_-</ __/
-- /_/  /_/_/___/\__/
-- ============================================================

hl.config({
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
        allow_session_lock_restore = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        background_color = "rgba(00000000)",
        font_family = "JetBrainsMonoNL Nerd Font Mono",
        session_lock_xray = true,
    },

    binds = {
        hide_special_on_workspace_change = true,
        allow_workspace_cycles = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    ecosystem = {
        no_donation_nag = true,
    },
})

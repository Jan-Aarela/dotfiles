-- vim: foldmethod=marker

--    __ __              __             __
--   / // /_ _____  ____/ /__ ____  ___/ /
--  / _  / // / _ \/ __/ / _ `/ _ \/ _  / _   _   _
-- /_//_/\_, / .__/_/ /_/\_,_/_//_/\_,_/ (_) (_) (_)
--      /___/_/

-- Sourcing
require("lua/startup")
require("lua/keys")
require("lua/anims")
require("lua/decor")
require("lua/rules")
require("lua/input")
require("lua/monitors")

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

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
})

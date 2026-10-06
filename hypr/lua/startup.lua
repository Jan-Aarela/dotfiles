-- vim: foldmethod=marker ft=lua

-- ============================================================
--    ______           __
--   / __/ /____ _____/ /___ _____
--  _\ \/ __/ _ `/ __/ __/ // / _ \
-- /___/\__/\_,_/_/  \__/\_,_/ .__/
--                          /_/
-- ============================================================

hl.on("hyprland.start", function()
    -- Envs and setup
    hl.exec_cmd("~/.config/scripts/hypr_lua/theme_switcher.sh previous")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("QT_QPA_PLATFORM=xcb copyq")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("brightnessctl set 100%")
    hl.exec_cmd('xrdb -merge "$HOME/.Xresources"')
    hl.exec_cmd("udiskie")
    hl.exec_cmd("sleep 4 && paplay ~/.config/sounds/ice_cream.mp3")

    -- ??
    hl.exec_cmd("dbus-update-activation-environment")
    hl.exec_cmd("systemctl")
    hl.exec_cmd("systemctl --user start polkit-gnome.service")

    -- Start apps
    hl.exec_cmd("kitty -e btop", { workspace = "special:magic silent" })
    hl.exec_cmd("Telegram", { workspace = "special:magic silent" })
end)

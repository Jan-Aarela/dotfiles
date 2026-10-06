-- vim: foldmethod=marker

-- ============================================================
--    __             __              ____  ___  _______  ____
--   / /  ___ ____  / /____  ___    / __ \/ _ \/  _/ _ \/ __/
--  / /__/ _ `/ _ \/ __/ _ \/ _ \  / /_/ / , _// // // / _/
-- /____/\_,_/ .__/\__/\___/ .__/  \____/_/|_/___/____/___/
--          /_/           /_/
-- ============================================================

-- See https://wiki.hypr.land/configuring/core/environment-variables/

local mainMod = "SUPER"

local function exec(cmd)
    return hl.dsp.exec_cmd(cmd)
end

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", default = true })

hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1", default = true })

hl.monitor({
    output = "",
    mode = "preferred",
    position = "500x1440",
    scale = "1.125",
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "3440x1440@100",
    position = "0x0",
    scale = "1",
})

hl.bind(
    mainMod .. " + i",
    exec([[hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })']])
)

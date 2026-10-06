-- vi:foldmethod=marker

-- ============================================================
--    __ __         __   _         __
--   / //_/__ __ __/ /  (_)__  ___/ /__
--  / ,< / -_) // / _ \/ / _ \/ _  (_-<  _   _   _
-- /_/|_|\__/\_, /_.__/_/_//_/\_,_/___/ (_) (_) (_)
--          /___/
-- ============================================================

-- Variables & functions {{{

local mainMod = "SUPER"

local directions = {
    left = { x = -1, y = 0 },
    right = { x = 1, y = 0 },
    up = { x = 0, y = -1 },
    down = { x = 0, y = 1 },
}

local function exec(cmd)
    return hl.dsp.exec_cmd(cmd)
end

local function sound()
    hl.dispatch(hl.dsp.exec_cmd("aplay ~/.config/sounds/interact.wav"))
end

-- }}}

-- Launch apps and such {{{

hl.bind(mainMod .. " + RETURN", exec("kitty"))
hl.bind(mainMod .. " + SHIFT + RETURN", exec("kitty --title zellij_floating -o confirm_os_window_close=0 -e zellij"))
hl.bind(mainMod .. " + Q", exec("~/.config/scripts/hypr_lua/close_window.sh"))
hl.bind(mainMod .. " + SHIFT + Q", exec("~/.config/scripts/hypr_lua/close_window.sh force"))
hl.bind(mainMod .. " + SHIFT + P", exec("~/.config/scripts/powermenu.sh"))
hl.bind(mainMod .. " + P", exec("~/.config/scripts/power-profiles.sh"))
hl.bind(mainMod .. " + D", exec("wofi --show drun -c ~/.config/wofi/default -s ~/.config/wofi/default.css"))
hl.bind(mainMod .. " + W", exec("chromium"))
hl.bind(mainMod .. " + SHIFT + W", exec("~/.config/scripts/hypr_lua/gemini.sh"))
-- hl.bind(mainMod .. " + S", exec("~/.config/scripts/hypr_lua/window_switch.sh"))
hl.bind(mainMod .. " + N", exec("iwgtk"))
hl.bind(mainMod .. " + M", exec("pear-desktop"))
hl.bind(mainMod .. " + L", exec("~/.config/scripts/hypr_lua/lock.sh"))
hl.bind(mainMod .. " + E", exec("thunar"))
hl.bind(mainMod .. " + SHIFT + T", exec("~/.config/scripts/hypr_lua/theme_switcher.sh switch"))
hl.bind(mainMod .. " + T", exec("~/.config/scripts/wallpaper_switch.sh"))
hl.bind(mainMod .. " + SHIFT + E", exec("emote"))
hl.bind(mainMod .. " + C", exec("copyq toggle"))
-- hl.bind(mainMod .. " + H", exec("~/.config/scripts/hypr_lua/HDMI.sh"))

hl.bind(
    mainMod .. " + K",
    exec(
        [[kitty --title='qalc floating' \
        -o font_size=24 \
        -o confirm_os_window_close=0 \
        -e bash -c 'echo -e " \e[34m──────────[\e[34m 󱖦 qalc session \e[34m]────────────\e[0m\n" && qalc']]
    )
)

-- }}}

-- Misc {{{
hl.bind(mainMod .. " + X", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + N", exec("~/.config/scripts/notes.sh"))
hl.bind(mainMod .. " + SPACE", exec("hyprctl switchxkblayout all next"))
hl.bind(mainMod .. " + SHIFT + BACKSPACE", exec("dunstctl history-pop"))
hl.bind(mainMod .. " + BACKSPACE", exec("dunstctl close"), { release = true })
hl.bind(mainMod .. " + BACKSPACE", exec("dunstctl close-all"), { long_press = true })
hl.bind(mainMod .. " + SHIFT + C", exec("~/.config/scripts/hypr_lua/workspace_tidy.sh"))

-- }}}

-- Focus {{{

for dir_name in pairs(directions) do
    hl.bind(mainMod .. " + " .. dir_name, function()
        hl.dispatch(hl.dsp.focus({ direction = dir_name }))
    end)
end

hl.bind(mainMod .. " + A", function()
    local w = hl.get_active_window()

    if w ~= nil and w.floating then
        hl.dispatch(hl.dsp.focus({ window = "tiled" }))
    else
        hl.dispatch(hl.dsp.focus({ window = "floating" }))
    end
end)

hl.bind(mainMod .. " + SHIFT + A", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

    local w = hl.get_active_window()

    if w ~= nil and w.floating then
        hl.dispatch(hl.dsp.window.resize({
            x = 1280,
            y = 768,
        }))

        hl.dispatch(hl.dsp.window.center())
    end
end)

hl.bind(mainMod .. " + PERIOD", hl.dsp.focus({ last = true }))
hl.bind(mainMod .. " + MINUS", hl.dsp.focus({ urgent_or_last = true }))

hl.bind("" .. "ALT + TAB", hl.dsp.layout("cyclenext"))
hl.bind("" .. "ALT + SHIFT + TAB", hl.dsp.layout("cycleprev"))

-- }}}

-- Workspace {{{

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

for i = 1, 9 do
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + SECTION", hl.dsp.workspace.toggle_special("magic"), { description = "Workspace: Toggle magic" })
hl.bind(mainMod .. " + ESCAPE", hl.dsp.focus({ workspace = 10 }))

hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.window.move({ workspace = "10", follow = false }))
hl.bind(mainMod .. " + SHIFT + SECTION", hl.dsp.window.move({ workspace = "special:magic", follow = false }))

-- }}}

-- Window / Group movement {{{

local function move_window(dir_name, step)
    local cfg = directions[dir_name]
    local w = hl.get_active_window()

    if w == nil then
        return
    end

    if w.floating then
        hl.dispatch(hl.dsp.window.move({
            x = cfg.x * step,
            y = cfg.y * step,
            relative = true,
        }))
    else
        hl.dispatch(hl.dsp.window.move({ direction = dir_name }))
    end
end

-- Window floating / tiled movement
for dir_name in pairs(directions) do
    -- Big move
    hl.bind(mainMod .. " + SHIFT + " .. dir_name, function()
        move_window(dir_name, 225)
    end)

    -- Micro move
    hl.bind(mainMod .. " + SHIFT + CTRL + " .. dir_name, function()
        move_window(dir_name, 75)
    end)
end

-- Group management
for dir_name in pairs(directions) do
    hl.bind(mainMod .. " + CTRL + " .. dir_name, function()
        hl.dispatch(hl.dsp.window.move({ out_of_group = dir_name }))
        hl.dispatch(hl.dsp.window.move({ into_group = dir_name }))
    end)
end

hl.bind(mainMod .. " + TAB", hl.dsp.group.next())
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.group.prev())
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())

hl.bind(mainMod .. " + C", hl.dsp.window.center())

-- }}}

-- Resize submap {{{

hl.bind(mainMod .. " + R", function()
    sound()
    hl.dispatch(hl.dsp.submap("Resize"))
    hl.config({ general = { col = { active_border = "rgba(ffb86cFF)" } } })
    hl.config({ group = { col = { border_active = "rgba(ffb86cFF)" } } })
end)

-- Start a submap called "resize".
hl.define_submap("Resize", function()
    local function resize_window(dir_name, step)
        local cfg = directions[dir_name]
        hl.dispatch(hl.dsp.window.resize({
            x = cfg.x * step,
            y = cfg.y * step,
            relative = true,
        }))
    end

    -- Bindings
    for dir_name in pairs(directions) do
        -- Normal step (200px)
        hl.bind(dir_name, function()
            resize_window(dir_name, 200)
        end, { repeating = true })

        -- Small step (50px) with SHIFT
        hl.bind("SHIFT + " .. dir_name, function()
            resize_window(dir_name, 50)
        end, { repeating = true })
    end

    hl.bind("catchall", hl.dsp.submap("Resize"))

    hl.bind("escape", function()
        sound()
        hl.dispatch(hl.dsp.submap("reset"))
        hl.config({ general = { col = { active_border = "rgba(BD93F9FF)" } } })
        hl.config({ group = { col = { border_active = "rgba(BD93F9FF)" } } })
    end)
end)

-- }}}

-- Screenshot submap {{{

hl.bind(mainMod .. " + SHIFT + S", function()
    sound()
    hl.dispatch(hl.dsp.submap("Screenshot"))
    hl.dispatch(hl.dsp.exec_cmd([[sh -c 'sleep 2 && hyprctl dispatch "hl.dsp.submap(\"reset\")"' &]]))
end)

hl.define_submap("Screenshot", function()
    local actions = {
        S = "screen",
        E = "satty",
        R = "region",
        W = "window",
        C = "view",
    }

    -- Bindings
    for key, mode in pairs(actions) do
        hl.bind(key, function()
            hl.dispatch(hl.dsp.exec_cmd("~/.config/scripts/hypr_lua/screenshot.sh " .. mode))
            sound()
            hl.dispatch(hl.dsp.submap("reset"))
        end)
    end

    hl.bind("ESCAPE", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("Screenshot"))

    hl.bind("escape", function()
        sound()
        hl.dispatch(hl.dsp.submap("reset"))
    end)
end)

-- }}}

-- Mouse / trackpad controls {{{

hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- }}}

-- Multimedia / brightness {{{

local repeating_keys = {
    XF86AudioRaiseVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.1",
    XF86AudioLowerVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
    XF86MonBrightnessUp = "brightnessctl s 10%+",
    XF86MonBrightnessDown = "brightnessctl s 10%-",
}

-- Bindings
for key, cmd in pairs(repeating_keys) do
    hl.bind(key, function()
        hl.dispatch(hl.dsp.exec_cmd(cmd))
        sound()
    end, { repeating = true })
end

hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- }}}

-- YouTube Music {{{

local media_keys = {
    F1 = "position 0",
    F2 = "play-pause",
    F3 = "previous",
    F4 = "next",
}

-- Bindings
for key, cmd in pairs(media_keys) do
    hl.bind(mainMod .. " + " .. key, function()
        hl.dispatch(hl.dsp.exec_cmd("playerctl -p YoutubeMusic " .. cmd))
        sound()
    end)
end

-- }}}}}}

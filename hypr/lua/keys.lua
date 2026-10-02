-- vi:foldmethod=marker

-- ============================================================
--    __ __         __   _         __
--   / //_/__ __ __/ /  (_)__  ___/ /__
--  / ,< / -_) // / _ \/ / _ \/ _  (_-<  _   _   _
-- /_/|_|\__/\_, /_.__/_/_//_/\_,_/___/ (_) (_) (_)
--          /___/
-- ============================================================

-- ============================================================
-- Variables & functions
-- ============================================================

local mainMod = "SUPER"

local function exec(cmd)
    return hl.dsp.exec_cmd(cmd)
end

local function sound()
    hl.dispatch(hl.dsp.exec_cmd("aplay ~/.config/sounds/interact.wav"))
end

-- ============================================================
-- Launch apps and such
-- ============================================================

hl.bind(mainMod .. " + RETURN", exec("kitty --hold -e fish -c joel"))

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

hl.bind(mainMod .. " + V", exec("copyq toggle"))

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

-- ============================================================
-- Misc
-- ============================================================

hl.bind(mainMod .. " + TAB", hl.dsp.group.next())

hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.group.prev())

hl.bind(mainMod .. " + G", hl.dsp.group.toggle())

hl.bind(mainMod .. " + X", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod .. " + J", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + F7", exec("hyprctl keyword monitor eDP-1,preferred,auto,1"))

hl.bind(mainMod .. " + SHIFT + N", exec("~/.config/scripts/notes.sh"))

hl.bind(mainMod .. " + SPACE", exec("hyprctl switchxkblayout all next"))

hl.bind(mainMod .. " + SHIFT + BACKSPACE", exec("dunstctl history-pop"))

hl.bind(mainMod .. " + BACKSPACE", exec("dunstctl close"), { release = true })

hl.bind(mainMod .. " + BACKSPACE", exec("dunstctl close-all"), { long_press = true })

-- ============================================================
-- Focus
-- ============================================================

hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "l" }))

hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "r" }))

hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "u" }))

hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + PERIOD", hl.dsp.focus({ last = true }))

hl.bind(mainMod .. " + MINUS", hl.dsp.focus({ urgent_or_last = true }))

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

-- ============================================================
-- Switch workspace
-- ============================================================

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

hl.bind(mainMod .. " + ESCAPE", hl.dsp.focus({ workspace = 10 }))

-- ============================================================
-- Move window to workspace
-- ============================================================

for i = 1, 9 do
    hl.bind(
        mainMod .. " + SHIFT + " .. i,
        hl.dsp.window.move({
            workspace = i,
            follow = false,
        })
    )
end

hl.bind(
    mainMod .. " + SHIFT + ESCAPE",
    hl.dsp.window.move({
        workspace = "10",
        follow = false,
    })
)

hl.bind(mainMod .. " + SHIFT + C", exec("~/.config/scripts/hypr_lua/workspace_tidy.sh"))

-- ============================================================
-- Move window
-- ============================================================

hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + CTRL + LEFT", hl.dsp.window.move({ out_of_group = "left" }))
hl.bind(mainMod .. " + CTRL + LEFT", hl.dsp.window.move({ into_group = "left" }))

hl.bind(mainMod .. " + CTRL + RIGHT", hl.dsp.window.move({ out_of_group = "right" }))
hl.bind(mainMod .. " + CTRL + RIGHT", hl.dsp.window.move({ into_group = "right" }))

hl.bind(mainMod .. " + CTRL + UP", hl.dsp.window.move({ out_of_group = "up" }))
hl.bind(mainMod .. " + CTRL + UP", hl.dsp.window.move({ into_group = "up" }))

hl.bind(mainMod .. " + CTRL + DOWN", hl.dsp.window.move({ out_of_group = "down" }))
hl.bind(mainMod .. " + CTRL + DOWN", hl.dsp.window.move({ into_group = "down" }))

hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.move({ y = 0, x = -225, relative = true }))
hl.bind(mainMod .. " + CTRL + LEFT", hl.dsp.window.move({ y = 0, x = -75, relative = true }))

hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.move({ y = 0, x = 225, relative = true }))
hl.bind(mainMod .. " + CTRL + RIGHT", hl.dsp.window.move({ y = 0, x = 75, relative = true }))

hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.move({ y = -225, x = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + UP", hl.dsp.window.move({ y = -75, x = 0, relative = true }))

hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.move({ y = 225, x = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + DOWN", hl.dsp.window.move({ y = 75, x = 0, relative = true }))

hl.bind(mainMod .. " + C", hl.dsp.window.center())

-- ============================================================
-- Resize submap
-- ============================================================

hl.bind(mainMod .. " + R", function()
    sound()
    hl.dispatch(hl.dsp.submap("Resize"))
    hl.config({ general = { col = { active_border = "rgba(ffb86cFF)" } } })
end)

-- Start a submap called "resize".
hl.define_submap("Resize", function()
    -- Set repeating binds for resizing the active window.
    hl.bind("right", hl.dsp.window.resize({ x = 200, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -200, y = 0, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 200, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -200, relative = true }), { repeating = true })

    hl.bind("SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
    hl.bind("SHIFT + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
    hl.bind("SHIFT + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })

    hl.bind("catchall", hl.dsp.submap("Resize"))

    hl.bind("escape", function()
        sound()
        hl.dispatch(hl.dsp.submap("reset"))
        hl.config({ general = { col = { active_border = "rgba(BD93F9FF)" } } })
    end)
end)

-- ============================================================
-- Screenshot submap
-- ============================================================

hl.bind(mainMod .. " + SHIFT + S", function()
    sound()
    hl.dispatch(hl.dsp.submap("Screenshot"))
end)

hl.define_submap("Screenshot", function()
    hl.bind("S", exec('.config/scripts/hypr_lua/screenshot.sh "screen" & aplay ~/.config/sounds/interact.wav'))
    hl.bind("E", exec('.config/scripts/hypr_lua/screenshot.sh "satty" & aplay ~/.config/sounds/interact.wav'))
    hl.bind("R", exec('.config/scripts/hypr_lua/screenshot.sh "region" & aplay ~/.config/sounds/interact.wav'))
    hl.bind("W", exec('.config/scripts/hypr_lua/screenshot.sh "window" & aplay ~/.config/sounds/interact.wav'))
    hl.bind("C", exec('.config/scripts/hypr_lua/screenshot.sh "view" & aplay ~/.config/sounds/interact.wav'))

    hl.bind("ESCAPE", hl.dsp.submap("reset"))
    hl.bind("catchall", hl.dsp.submap("Screenshot"))

    hl.bind("escape", function()
        sound()
        hl.dispatch(hl.dsp.submap("reset"))
    end)
end)

-- ============================================================
-- Special workspace
-- ============================================================

hl.bind(mainMod .. " + SECTION", hl.dsp.workspace.toggle_special("magic"), { description = "Workspace: Toggle magic" })

hl.bind(
    mainMod .. " + SHIFT + SECTION",
    hl.dsp.window.move({
        workspace = "special:magic",
        follow = false,
    })
)

-- ============================================================
-- Workspace scrolling
-- ============================================================

-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

-- Original was:
-- workspace, eDP-1
--
-- This appears to be a monitor selector rather than workspace scrolling.
-- Keeping the original behavior:
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ monitor = "eDP-1" }))

-- ============================================================
-- Mouse move / resize
-- ============================================================

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ============================================================
-- Multimedia / brightness
-- ============================================================

hl.bind(
    "XF86AudioRaiseVolume",
    exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.1 && " .. "aplay ~/.config/sounds/interact.wav"),
    { repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && " .. "aplay ~/.config/sounds/interact.wav"),
    { repeating = true }
)

hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind(
    "XF86MonBrightnessUp",
    exec("brightnessctl s 10%+ && aplay ~/.config/sounds/interact.wav"),
    { repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    exec("brightnessctl s 10%- && aplay ~/.config/sounds/interact.wav"),
    { repeating = true }
)

-- ============================================================
-- YouTube Music
-- ============================================================

hl.bind(mainMod .. " + F3", exec("playerctl -p YoutubeMusic previous && " .. "aplay ~/.config/sounds/interact.wav"))

hl.bind(mainMod .. " + F1", exec("playerctl -p YoutubeMusic position 0 && " .. "aplay ~/.config/sounds/interact.wav"))

hl.bind(mainMod .. " + F2", exec("playerctl -p YoutubeMusic play-pause && " .. "aplay ~/.config/sounds/interact.wav"))

hl.bind(mainMod .. " + F4", exec("playerctl -p YoutubeMusic next && " .. "aplay ~/.config/sounds/interact.wav"))

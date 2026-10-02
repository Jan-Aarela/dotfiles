#!/bin/bash

if pgrep -x hyprlock >/dev/null; then
    exit 0
fi

# kitty --title lock_bg -e pipes -p 32 -r 0 &
kitty -o background=#13141a -o color4=#7d61a4 --title lock_bg -e cmatrix -C blue &
# kitty --title lock_bg -e cbonsai --screensaver --wait 1 &
# kitty --title lock_bg -e asciiquarium2 -t &
# kitty --title lock_bg -o font_size=10 -e solarust -t ansi -s day &

sleep 0.5

notify-send " Locked!" &
aplay ~/.config/sounds/theme_switch.wav &
hyprctl dispatch 'hl.dsp.focus({workspace = "lock"})'

hyprlock

hyprctl dispatch 'hl.dsp.focus({workspace = "previous"})'
aplay ~/.config/sounds/theme_switch.wav
notify-send " Welcome back!"

hyprctl dispatch 'hl.dsp.window.kill({window ="title:lock_bg"})'

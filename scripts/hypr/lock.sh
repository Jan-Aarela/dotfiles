#!/bin/bash

if pgrep -x hyprlock >/dev/null; then
  exit 0
fi

# kitty --title lock_bg -e pipes -p 32 -r 0 &
# kitty --title lock_bg -e cmatrix -C yellow &
# kitty --title lock_bg -e cbonsai --screensaver --wait 1 &
kitty --title lock_bg -e asciiquarium2 -t &

sleep 0.33

notify-send " Locked!" &
aplay ~/.config/sounds/theme_switch.wav &

WS=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')
hyprctl dispatch workspace name:lock

# swaylock \
#     -c 00000000 --clock --timestr %H:%M --datestr "" \
#     --inside-color 181826 --ring-color 313244 --key-hl-color B4BEFE --text-color ffffff \
#     --ring-wrong-color f38ba8 --inside-wrong-color 181826 --text-wrong-color f38ba8 \
#     --inside-ver-color 181826 --ring-ver-color B4BEFE --text-ver-color ffffff \
#     -e --font "JetBrainsMonoNL Nerd Font Mono" --layout-bg-color 00000000 \
#     --ring-clear-color fab387 --inside-clear-color 181826 --text-clear-color ffffff --bs-hl-color fab387

hyprlock

hyprctl dispatch workspace $WS

aplay ~/.config/sounds/theme_switch.wav
notify-send " Welcome back!"

sleep 0.125
hyprctl dispatch killwindow title:lock_bg

#!/bin/bash

if pgrep -x hyprlock >/dev/null; then
  exit 0
fi

# kitty --title lock_bg -e pipes -p 32 -r 0 &
# kitty --title lock_bg -e cmatrix -C red &
# kitty --title lock_bg -e cbonsai --screensaver --wait 1 &
kitty --title lock_bg -e asciiquarium -t &

sleep 0.33

notify-send " Locked!" &
aplay ~/.config/sounds/theme_switch.wav &

WS=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')
hyprctl dispatch workspace name:lock

hyprlock

hyprctl dispatch workspace $WS

aplay ~/.config/sounds/theme_switch.wav
notify-send " Welcome back!"

sleep 0.125
hyprctl dispatch killwindow title:lock_bg

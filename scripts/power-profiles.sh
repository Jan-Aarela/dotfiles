#!/bin/bash

# Start wofi with selections
SELECTED=$(echo -e "󰗑\n󰌪\n󰓅" | wofi -dmenu -p "Power Profiles" -s ~/.config/wofi/icon.css -i -c ~/.config/wofi/power)

case "$SELECTED" in
"󰓅")
  powerprofilesctl set performance &
  aplay ~/.config/sounds/theme_switch.wav
  ;;
"󰗑")
  powerprofilesctl set balanced &
  aplay ~/.config/sounds/theme_switch.wav
  ;;
"󰌪")
  powerprofilesctl set power-saver &
  aplay ~/.config/sounds/theme_switch.wav
  ;;
esac

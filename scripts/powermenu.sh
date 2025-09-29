#!/bin/bash

# Start wofi with selections
SELECTED=$(echo -e "\n\n" | wofi -dmenu -i -p "Power" -s ~/.config/wofi/icon.css -c ~/.config/wofi/power)

# Checks if a selection is valid
if [[ $SELECTED == "" || $SELECTED == "" || $SELECTED == "" ]]; then

  # Ask confimation
  CONFIRMATION=$(echo -e "$SELECTED Sure?" | wofi -dmenu -i -p "$SELECTED?" -s ~/.config/wofi/icon.css -c ~/.config/wofi/confirm)

  # Case matching
  if [[ $CONFIRMATION == "$SELECTED Sure?" || $CONFIRMATION == "yes" || $CONFIRMATION == "Y" || $CONFIRMATION == "y" || $CONFIRMATION == " Yes" ]]; then

    case "$SELECTED" in
    "") aplay ~/.config/sounds/shutdown.wav && systemctl poweroff ;;
    "") aplay ~/.config/sounds/shutdown.wav && systemctl reboot ;;
    "") aplay ~/.config/sounds/shutdown.wav && hyprctl dispatch exit ;;
    esac
  fi
fi

#!/bin/bash

MODE=$1
THEME_DIR="$HOME/.config/hypr/themes"

if [[ "$MODE" == "switch" ]]; then
  # Get list of theme folder names
  THEMES=$(find "$THEME_DIR" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort -f)
  echo "$THEMES"
  # Calculate the Height of the window

  COUNT=$(echo "$THEMES" | wc -l)
  HEIGHT=$(("$COUNT" * 51))

  # Prompt wofi menu
  SELECTED=$(echo "$THEMES" | wofi -dmenu -p "Switch to" -W 300 -H "$HEIGHT" -w 1 -c ~/.config/wofi/config -O alphabetical -i)

  # If a theme was selected, run the switcher
  if [ "$SELECTED" != "" ]; then
    sh "$THEME_DIR/$SELECTED/init" "$THEME_DIR/$SELECTED"
    echo "$SELECTED" >"$THEME_DIR/current_theme"
    notify-send " $SELECTED Theme" &
    aplay ~/.config/sounds/theme_switch.wav
  fi
fi

# Run previous theme (On startup)
if [[ "$MODE" == "previous" ]]; then
  PREVIOUS=$(cat "$THEME_DIR/current_theme")
  echo "$PREVIOUS"
  sh "$THEME_DIR/$PREVIOUS/init" "$THEME_DIR/$PREVIOUS"
  notify-send " $PREVIOUS Theme"
  sleep 1
  aplay ~/.config/sounds/startup.wav
fi

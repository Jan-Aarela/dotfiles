#!/bin/bash

IMAGE_DIR="$HOME/Pictures/wallpapers/"
IMAGES=$(find "$IMAGE_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.webp" \) -exec basename {} \; | sort -f )

# Prompt wofi menu
SELECTED=$( echo "$IMAGES" | wofi -dmenu -p "Wallpaper Switch" -W 300 -H 300 -w 1 -c ~/.config/wofi/config -O alphabetical -i)

SELECTED=$(echo "$IMAGES" | fzf --filter="$SELECTED" --select-1 --exit-0)
echo "matched $SELECTED"
COUNT=$(echo "$SELECTED" | wc -l)

# If a selection was made
if [[ -z "$SELECTED" ]]; then
  echo "No matches"
elif [[ $COUNT -ge 3 ]]; then
  echo "Too many matches ($COUNT) / Exit"
else
  swww img $IMAGE_DIR/$SELECTED -t grow --transition-duration 0.5 --transition-fps 90
  notify-send "   $SELECTED" & aplay ~/.config/sounds/theme_switch.wav
fi


# if [ -n "$SELECTED" ]; then
#   swww img $IMAGE_DIR/$SELECTED -t grow --transition-duration 0.5 --transition-fps 90
#   notify-send "   $SELECTED" & aplay ~/.config/sounds/theme_switch.wav
# fi


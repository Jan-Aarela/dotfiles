#!/bin/bash

# hyprctl dispatch submap reset

MODE=$1
OUTPUT="$HOME/Pictures/Screenshots"
COUNT1=$(find ~/Pictures/Screenshots -type f | wc -l)
# echo $COUNT1

case "$MODE" in
region)
  hyprshot -m region -z -o "$OUTPUT" -f "$(date '+%Y-%m-%d-%H%M%S')"_region.png
  ;;
window)
  hyprshot -m active -m window -z -o "$OUTPUT" -f "$(date '+%Y-%m-%d-%H%M%S')"_window.png
  ;;
screen)
  hyprshot -m active -m output -z -o "$OUTPUT" -f "$(date '+%Y-%m-%d-%H%M%S')"_screen.png
  ;;
satty)
  FILENAME=$(date '+%Y-%m-%d-%H%M%S')_satty.png
  grim -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/"$FILENAME" --early-exit --save-after-copy
  wl-copy --type image/png <~/Pictures/Screenshots/"$FILENAME"
  ;;
view)
  # IMG=$(nsxiv -to ~/Pictures/Screenshots/ -s f | awk -F'/' '{print $NF}')
  # echo "$IMG"
  # IMG=$(nsxiv -to ~/Pictures/Screenshots/ -g 1400x1150 -s f | awk -F'/' '{print $NF}')
  IMG=$(nsxiv -to $(ls -r ~/Pictures/Screenshots/*) -g 1400x1150 | awk -F'/' '{print $NF}')
  echo "$IMG"

  wl-copy --type image/png <~/Pictures/Screenshots/"$IMG"
  ;;
esac

sleep 0.25
COUNT2=$(find ~/Pictures/Screenshots -type f | wc -l)
# echo $COUNT2

if [[ $COUNT2 -gt $COUNT1 ]]; then
  aplay ~/.config/sounds/theme_switch.wav
fi

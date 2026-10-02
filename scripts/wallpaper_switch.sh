#!/bin/bash

THEME=$(find "$HOME/Pictures/wallpapers/" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort -f | wofi -dmenu -s ~/.config/wofi/default.css -c ~/.config/wofi/default -p "Wallpaper Themes" -W 300 -H 400 --sort-order=alphabetical)

if [ -z "$THEME" ]; then
    exit 0
fi

IMG=$(nsxiv -to ~/Pictures/wallpapers/"$THEME" -g 1400x1150 -s f || notify-send "Empty dir!" | awk -F'/' '{print $NF}')
echo "$IMG"

if [[ -n $IMG ]]; then
    awww img "$IMG" -t wipe --transition-duration 0.5 --transition-fps 90
    notify-send " $(basename "$IMG")" &
    aplay ~/.config/sounds/theme_switch.wav
fi

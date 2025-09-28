#!/bin/bash

IMAGE_DIR="$HOME/Pictures/wallpapers/"

IMG=$(nsxiv -to ~/Pictures/wallpapers/ -g 1400x1150 -s f | awk -F'/' '{print $NF}')
echo $IMG

if [[ -n $IMG ]];then
    swww img $IMAGE_DIR/$IMG -t grow --transition-duration 0.5 --transition-fps 90
    notify-send "   $IMG" & aplay ~/.config/sounds/theme_switch.wav
fi

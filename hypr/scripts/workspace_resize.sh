#!/bin/bash

hyprctl keyword workspace 1, addreserved,0,0,100,400

SELECTED=$(echo -e "16:10\n4:3\n21:9" | wofi -dmenu -W 320 -H 191 -w 1 -p "Power Profiles" -s ~/.config/wofi/power.css -i)

WORKSPACE=$(hyprctl activewindow -j | jq ".workspace" | jq ".id" )
echo $WORKSPACE

case "$SELECTED" in
    "16:10") hyprctl keyword workspace $WORKSPACE, addreserved,0,0,0,0 && aplay ~/.config/sounds/theme_switch.wav ;;
    "4:3")   hyprctl keyword workspace $WORKSPACE, addreserved,0,0,400,400 && aplay ~/.config/sounds/theme_switch.wav  ;;     # Thin spaces used 
    "21:9")  hyprctl keyword workspace $WORKSPACE, addreserved,0,0,100,100 && aplay ~/.config/sounds/theme_switch.wav  ;;
esac


#!/bin/bash

FORCE=$1
ADDRESS1=$(cat ~/.config/scripts/hypr_lua/close_variable)
ADDRESS2=$(hyprctl activewindow -j | jq '.address')

if [[ "$ADDRESS2" == "$ADDRESS1" ]]; then
    echo 0 >~/.config/scripts/hypr_lua/close_variable &
    if [[ $FORCE == "force" ]]; then
        hyprctl dispatch 'hl.dsp.window.kill()' &
        WINDOW=$(hyprctl activewindow -j | jq -r '.class')
        aplay ~/.config/sounds/blade.wav &
        notify-send "FORCE KILLED -" "$WINDOW" -u critical -t 1000 &
    else
        hyprctl dispatch 'hl.dsp.window.close()' &
    fi
else
    echo "$ADDRESS2" >~/.config/scripts/hypr_lua/close_variable &
    sleep 0.25
    echo 0 >~/.config/scripts/hypr_lua/close_variable &
fi

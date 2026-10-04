#!/bin/bash

hyprctl dispatch 'hl.dispatch(hl.dsp.submap("reset"))'

MODE=$1

CURRENT_MONTH=$(date +%Y-%m)
OUTPUT="$HOME/Pictures/Screenshots/$CURRENT_MONTH"

COUNT1=$(find ~/Pictures/Screenshots -type f | wc -l)

confirmation() {
    sleep 0.25
    COUNT2=$(find ~/Pictures/Screenshots -type f | wc -l)

    if [[ $COUNT2 -gt $COUNT1 ]]; then
        aplay ~/.config/sounds/theme_switch.wav
    fi
}

case "$MODE" in
    region)
        hyprshot -m region -z -o "$OUTPUT" -f "$(date '+%Y-%m-%d-%H%M%S')"_region.png && confirmation
        ;;
    window)
        hyprshot -m active -m window -z -o "$OUTPUT" -f "$(date '+%Y-%m-%d-%H%M%S')"_window.png && confirmation
        ;;
    screen)
        hyprshot -m active -m output -z -o "$OUTPUT" -f "$(date '+%Y-%m-%d-%H%M%S')"_screen.png && confirmation
        ;;
    satty)
        FILENAME=$(date '+%Y-%m-%d-%H%M%S')_satty.png
        grim -t ppm - | satty --filename - --fullscreen --output-filename "$OUTPUT"/"$FILENAME" --early-exit --save-after-copy
        wl-copy --type image/png <~/Pictures/Screenshots/"$FILENAME"
        ;;
    view)
        FOLDER=$(find "$HOME/Pictures/Screenshots/" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort -f | tac | wofi -dmenu -s ~/.config/wofi/default.css -c ~/.config/wofi/ss -p "Screenshot months" -W 300 -H 400)
        echo "$FOLDER"
        if [ -z "$FOLDER" ]; then
            exit 0
        fi

        FOLDER=$(find "$HOME"/Pictures/Screenshots/ -maxdepth 1 -iname "*$FOLDER*" -type d)

        IMG=$(nsxiv -to $(ls -r "$FOLDER"/*) -g 1400x1150 || notify-send "No Screenshots!" | awk -F'/' '{print $NF}')
        echo "$IMG"

        wl-copy --type image/png <"$IMG"
        ;;
esac

#!/bin/bash

DIR="$HOME/notes"

# List files and pass to wofi
SELECTED=$(ls -p "$DIR" | grep -v / | wofi -dmenu -p "Select a Note:" -W 300 -H 300 -c ~/.config/wofi/config -O alphabetical -i)

SELECTED=$(ls -p "$DIR" | grep -v / | fzf --filter="$SELECTED" --select-1 --exit-0)
COUNT=$(echo "$SELECTED" | wc -l)

# If a selection was made
if [[ -z "$SELECTED" ]]; then
    echo "No matches"
elif [[ "$SELECTED" == "Add+" ]]; then
    kitty -e nvim ~/notes/Add\+
elif [[ $COUNT -ge 3 ]]; then
    echo "Too many matches ($COUNT) / Exit"
else
    echo "$DIR/$SELECTED"
    kitty --title='Dummy manual' -e nvim "$DIR/$SELECTED"
fi

#!/bin/bash

# hyprctl dispatch 'hl.dsp.workspace.rename({workspace = "3", "lol"})'
# hyprctl dispatch 'hl.dsp.workspace.change_id({workspace = "1", id ="7"})'

# Fetch active numeric workspaces (1-9) that actually have windows, sorted by ID
mapfile -t active_workspaces < <(
    hyprctl workspaces -j | jq -r '
        [.[] | select(.id >= 1 and .id <= 9 and .windows > 0)]
        | sort_by(.id)
        | .[].id
    '
)

currentws=$(hyprctl activeworkspace | awk '/workspace ID/ {print $3}')

# Move each workspace sequentially to target index (1, 2, 3...)
target=1
moved=0
for ws in "${active_workspaces[@]}"; do

    if [[ "$ws" -ne "$target" ]]; then

        if [[ $moved == 0 && $currentws -eq $target ]]; then
            moved=1
            hyprctl dispatch 'hl.dsp.focus({workspace = "'"$ws"'"})'
            paplay ~/.config/sounds/interact.wav &
            sleep 0.1

        fi

        hyprctl dispatch 'hl.dsp.workspace.change_id({workspace = "'"$ws"'", id = "'"$target"'"})'
        hyprctl dispatch 'hl.dsp.workspace.rename({workspace = "'"$target"'", name = "'"$target"'"})'
        paplay ~/.config/sounds/interact.wav &
        sleep 0.1

    fi
    ((target++))
done

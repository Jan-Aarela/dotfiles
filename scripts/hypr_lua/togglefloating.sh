#!/bin/bash

hyprctl dispatch 'hl.dsp.window.float({action = "toggle"})'

# Checks if an active window is a floating one.
TYPE=$(hyprctl activewindow -j | jq '.floating')

if [[ "$TYPE" != "false" ]]; then
    hyprctl dispatch 'hl.dsp.window.resize({x = 1280, y = 768})'
fi

hyprctl dispatch 'hl.dsp.window.center()'

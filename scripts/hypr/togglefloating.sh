#!/bin/bash

hyprctl dispatch togglefloating

# Checks if an active window is a floating one.
TYPE=$(hyprctl activewindow -j | jq '.floating')

if [[ "$TYPE" != "false" ]]; then
  hyprctl dispatch resizeactive exact 1024 768
fi

hyprctl dispatch centerwindow

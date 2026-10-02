#!/bin/bash

sleep 2

hyprctl dispatch togglespecialworkspace magic

# Launch apps in special workspace.
hyprctl dispatch exec "[workspace special:magic silent; group set]" "kitty -e btop"
hyprctl dispatch exec "[workspace special:magic silent]" "Telegram"

sleep 2

hyprctl dispatch togglespecialworkspace magic

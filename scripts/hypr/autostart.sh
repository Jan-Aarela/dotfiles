#!/bin/bash

sleep 2

# Launch apps in special workspace.
hyprctl dispatch exec "[workspace special:magic silent;group set]" "kitty -e btop"
hyprctl dispatch exec "[workspace special:magic silent]" "Telegram"

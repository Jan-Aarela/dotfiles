#!/bin/bash

WINDOW=$(hyprctl clients -j | jq -r '.[] | select(.title == "Google Gemini") | .address')

if [[ -z "$WINDOW" ]]; then
  chromium -app='https://gemini.google.com/'
  exit 0
fi

WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')
hyprctl dispatch movetoworkspace "$WORKSPACE", address:"$WINDOW"

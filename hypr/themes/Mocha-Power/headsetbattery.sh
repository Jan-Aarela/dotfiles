#!/bin/bash

# Get info
STRING=$(headsetcontrol -b)

# Quit if no devices detected
if [[ $STRING == "No supported device found" ]]; then
  exit 0
fi

# Quit if there's more than 1 registered devices
COUNT=$(echo "$STRING" | awk '{print $2}')

if [[ "$COUNT" -gt 1 ]]; then
  exit 0
fi

# Grep battery level
LEVEL=$(headsetcontrol -b | grep 'Level:' | awk '{print $2}' | sed 's/%//')

# If devices is off, output off state.
if [[ -z $LEVEL ]]; then
  CLASS=off
  printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' "󱘖 Off" "$CLASS" "Headset offline"
  exit 0
fi

# Else, output battery level states.
if [[ $LEVEL -le 0 ]]; then
  CLASS=critical
  ICON=󰂎
elif [[ $LEVEL -le 25 ]]; then
  CLASS=low
  ICON=󱊡
elif [[ $LEVEL -le 50 ]]; then
  ICON=󱊢
else
  ICON=󱊣
fi

printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' "$ICON $LEVEL%" "$CLASS" "Headset Power Level"

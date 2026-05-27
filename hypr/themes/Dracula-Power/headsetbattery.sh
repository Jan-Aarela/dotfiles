#!/bin/bash

# Get info
STRING=$(headsetcontrol -o json)

# Get device count
COUNT=$(echo "$STRING" | jq '.device_count')

# Quit if no devices detected or more than 1
if [[ $COUNT -eq 0 ]]; then
  exit 0
elif [[ $COUNT -gt 1 ]]; then
  exit 0
fi

# Get battery level
LEVEL=$(echo "$STRING" | jq '.devices.[0].battery.level')

# If devices is off, output off state.
if [[ $LEVEL -eq -1 ]]; then
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

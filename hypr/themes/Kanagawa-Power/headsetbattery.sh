#!/bin/bash

STRING=$(headsetcontrol -b)

if [[ $STRING == "No supported device found" ]]; then
  exit 0
fi

COUNT=$(echo $STRING | awk '{print $2}')

if [[ "$COUNT" -gt 1 ]]; then
  exit 0
fi

LEVEL=$(headsetcontrol -b | grep 'Level:' | awk '{print $2}' | sed 's/%//')

if [[ -z $LEVEL ]]; then
  CLASS=off
  printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' "󱘖 Off" "$CLASS" "Headset offline"
  exit 0
fi

if [[ $LEVEL -le 0 ]]; then
  CLASS=critical
  ICON=󰂎
elif [[ $LEVEL -le 25 ]]; then
  ICON=󱊡
elif [[ $LEVEL -le 50 ]]; then
  ICON=󱊢
else
  ICON=󱊣
fi

printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' "$ICON $LEVEL%" "$CLASS" "Headset Power Level"

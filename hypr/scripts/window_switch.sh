#!/bin/bash

# Get list of clients with title and address. Adds eg. "1." prefix.
CLIENTS=$(hyprctl clients -j | jq -r '.[] | select(has("address") and .address != null) | "\(.title):TämäEiOleErotinMerkki :D:\(.address // "null")"' | nl -w1 -s'. ')
# Strips addreses for fzf to fyzzy find.
TITLES=$(echo "$CLIENTS" | awk -F ":TämäEiOleErotinMerkki :D:" '{print $1}') 

# Count total windows/clients
COUNT=$(echo "$TITLES" | wc -l)
echo "Windows: $COUNT"

# Use wofi to let the user select a window by title
SELECTED=$(echo "$CLIENTS" | awk -F ":TämäEiOleErotinMerkki :D:" '{print $1}' | wofi -dmen -W 768 -H 500 -p "[$COUNT] Fuzzy find a window" -i -k /dev/null)
#SELECTED=$(echo "$CLIENTS" | awk -F ":TämäEiOleErotinMerkki :D:" '{print $1}' | rofi -dmenu -i )
echo "Selected: $SELECTED"

# Fuzzy find with fzf
BEST=$(echo "$TITLES" | fzf --filter="$SELECTED" --select-1 --exit-0 --exact)
COUNT2=$(echo "$BEST" | wc -l)
echo "Matched: $BEST"

# If a selection was made
if [[ -z "$BEST" ]]; then
  echo "No matches"
elif [[ $COUNT2 -ge 3 ]]; then
  echo "Too many matches ($COUNT2) / Exit"
else
  # Find the corresponding line and extract address
  #LINE1=$(echo "$TITLES" | grep -F "$BEST" | head -n1)
  CLIENT=$(echo "$CLIENTS" | grep -F "$BEST" | head -n1)
  ADDRESS=$(echo "$CLIENT" | awk -F ":TämäEiOleErotinMerkki :D:" '{print $2}')
  echo "Adress: $ADDRESS"
  hyprctl dispatch focuswindow address:$ADDRESS
  aplay ~/.config/sounds/theme_switch.wav
fi


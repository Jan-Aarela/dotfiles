#!/bin/bash
ICON_PATH="img:/usr/share/icons/Qogir/scalable/org.telegram.desktop.svg:"

# 1. Get the raw window data from hyprctl/jq
CLIENTS_RAW=$(hyprctl clients -j | jq -r '.[] | select(has("address") and .address != null) | "text:\(.title):lol:\(.class):lol:\(.address)"')

# 2. Convert spaces between records back to newlines for line-by-line processing
CLIENTS_NL=$(echo -e "$CLIENTS_RAW" | tr ' ' '\n')

# 3. Use sed to PREPEND the icon path to the start of every line
# The pattern '^' matches the beginning of a line.
CLIENTS_FINAL=$(echo -e "$CLIENTS_NL" | sed "s/^/$ICON_PATH/")

# Print the final result (first line example)
echo -e "$CLIENTS_FINAL"

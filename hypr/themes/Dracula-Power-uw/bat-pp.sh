#!/bin/bash

# This variable selects mode to run.
MODE=$1

refresh() {
    # BATTERY=$(upower -b)
    # PERCENT=$(echo "$BATTERY" | awk '/percentage/ {print $2}' | tr -d '%')
    # STATE=$(echo "$BATTERY" | awk '/state/ {print $2}' | tr -d '%')
    # RATE=$(echo "$BATTERY" | awk '/energy-rate/ {print $2}' | tr -d '%')
    # EOL="Empty in: \n$(echo "$BATTERY" | awk '/time to empty/ {for (i=4; i<=NF; i++) printf $i (i<NF?" ":"\n")}')"

    BATPATH="/sys/class/power_supply/BAT0"

    PERCENT=$(cat "$BATPATH/capacity")
    STATE=$(cat "$BATPATH/status")
    RATE=$(awk '{print $1*10^-6}' "$BATPATH/power_now")
    # if [[ $EOL == "Empty in: \n" ]]; then
    #     EOL="Full in: \n$(upower -i "$BATTERY" | awk '/time to full/ {for (i=4; i<=NF; i++) printf $i (i<NF?" ":"\n")}')"
    # fi

    sleep 0.1

    # Set class for styling.
    if [[ $STATE == "Charging" || $STATE == "pending-charge" ]]; then
        CLASS=$"charging"
    elif [[ $PERCENT -le 10 ]]; then
        CLASS=$"critical"
    elif [[ $PERCENT -le 15 ]]; then
        CLASS=$"warning"
    else
        CLASS=$"normal"
    fi

    # Set energy rate polarity.
    if [[ $STATE == "Charging" ]]; then
        TOOLTIP="+$RATE"
    else
        TOOLTIP=$"-$RATE"
    fi

    # Get power profile and format icon.
    # Nerd font used in this case.
    PROFILE=$(powerprofilesctl get)
    case "$PROFILE" in
        "performance")
            PROFILE=$"󰓅"
            ;;
        "balanced")
            PROFILE=$"󰗑"
            ;;
        "power-saver")
            PROFILE=$"󰌪"
            ;;
    esac

    # Export as json.
    printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' "$PROFILE $PERCENT" "$CLASS" "$TOOLTIP W"
}

# Power profile switcher
if [[ $MODE == "toggle" ]]; then
    PROFILE=$(powerprofilesctl get)
    case "$PROFILE" in
        "power-saver")
            powerprofilesctl set performance &
            ;;
        "balanced")
            powerprofilesctl set power-saver &
            ;;
        "performance")
            powerprofilesctl set balanced &
            ;;
    esac
fi

# Refreshes the whole module.
if [[ $MODE == "refresh" ]]; then
    refresh
fi

# Indicator bar
if [[ $MODE == "bar" ]]; then
    BATTERY=$(upower -e | grep 'BAT')
    PERCENT=$(upower -i "$BATTERY" | awk '/percentage/ {print $2}' | tr -d '%')
    STATE=$(upower -i "$BATTERY" | awk '/state/ {print $2}' | tr -d '%')

    # Set class for styling.
    if [[ $STATE == "fully-charged" ]]; then
        CLASS=$"full"
    elif [[ $STATE == "charging" || $STATE == "pending-charge" ]]; then
        CLASS=$"charging"
    elif [[ $PERCENT -le 10 ]]; then
        CLASS=$"critical"
    elif [[ $PERCENT -le 15 ]]; then
        CLASS=$"warning"
    else
        CLASS=$"discharging"
    fi

    # Export as json.
    printf '{"class": "%s"}\n' "$CLASS"
fi

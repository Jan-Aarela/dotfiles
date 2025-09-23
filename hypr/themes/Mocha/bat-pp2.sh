#/bin/bash

# This variable selects mode to run.
MODE=$1

# Power profile switcher
if [[ $MODE == "toggle" ]];then
    PROFILE=$(powerprofilesctl get)
    if [[ $PROFILE == "power-saver" ]]; then
        powerprofilesctl set balanced &
    elif [[ $PROFILE == "balanced" ]]; then
        powerprofilesctl set performance &
    else
        powerprofilesctl set power-saver &
    fi
fi

# Refreshes the whole module.
if [[ $MODE == "refresh" ]];then

    BATTERY=$(upower -e | grep 'BAT')
    PERCENT=$(upower -i "$BATTERY" | awk '/percentage/ {print $2}' | tr -d '%')
    STATE=$(upower -i "$BATTERY" | awk '/state/ {print $2}' | tr -d '%')
    RATE=$(upower -i "$BATTERY" | awk '/energy-rate/ {print $2}' | tr -d '%')

    # Set class for styling.
    if [[ $STATE == "charging" ]];then
        CLASS=$"charging"
    elif [[ $PERCENT -le 10  ]]; then
        CLASS=$"critical"
    elif [[ $PERCENT -le 20 ]]; then
        CLASS=$"warning"
    else
        CLASS=$""
    fi

    # Set energy rate polarity.
    if [[ $STATE == "charging" ]];then
        TOOLTIP="+$RATE"
    else
        TOOLTIP=$"-$RATE"
    fi

    while true; do
        CHECK=$(pgrep -x "powerprofiles")
        if [[ $CHECK != "" ]]; then
            sleep 1
            notify-send "process found"
        else
            notify-send "no process"
            break
        fi
    done

    # Get power profile and format icon.
    # Nerd font used in this case.
    PROFILE=$(powerprofilesctl get)
    case "$PROFILE" in
        performance) PROFILE=$" 󱀚"
            ;;
        balanced) PROFILE=$" "
            ;;
        power-saver) PROFILE=$" "
            ;;
    esac

    # Export as json.
    printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' "$PROFILE $PERCENT" "$CLASS" "$TOOLTIP"
fi

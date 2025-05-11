# Checks battery level.
# And notifies if battery level is low or critical.

BATTERY=$(upower -e | grep 'BAT')
THRESHOLD=20
CRITICAL=10

while true; do
    if [ -n "$BATTERY" ]; then
        PERCENT=$(upower -i $BATTERY | awk '/percentage/ {print $2}' | tr -d '%')
        STATE=$(upower -i $BATTERY | awk '/state/ {print $2}')

        if [[ $PERCENT -le $CRITICAL && "$STATE" == "discharging" ]]; then
            notify-send " " "Low battery!" -u critical -t 5000

        elif [[ $PERCENT -le $THRESHOLD && "$STATE" == "discharging" ]]; then
            notify-send " " "Low battery!" -t 10000
        fi
    fi
    sleep 300
done


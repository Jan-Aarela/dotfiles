# Checks battery level.
# And notifies if battery level is low or critical.

BATTERY=$(upower -e | grep 'BAT')
THRESHOLD=20
CRITICAL=10
ALARM=5

while true; do
    if [ -n "$BATTERY" ]; then
        PERCENT=$(upower -i "$BATTERY" | awk '/percentage/ {print $2}' | tr -d '%')
        echo $PERCENT
        STATE=$(upower -i "$BATTERY" | awk '/state/ {print $2}')
        echo $STATE

        if [[ $PERCENT -le $ALARM && "$STATE" == "discharging" ]]; then
            notify-send " " "Low battery!" -u critical -t 5000
            aplay ~/.config/sounds/alarm.wav &
            echo "< 5%"
            sleep 3.85

        elif [[ $PERCENT -le $CRITICAL && "$STATE" == "discharging" ]]; then
            notify-send " " "Low battery!" -u critical -t 5000
            echo "< 10%"
            sleep 300

        elif [[ $PERCENT -le $THRESHOLD && "$STATE" == "discharging" ]]; then
            notify-send " " "Low battery!" -t 5000
            echo "< 20%"
            sleep 600

        else
            echo "no tresholds"
            sleep 300
        fi
    fi
done

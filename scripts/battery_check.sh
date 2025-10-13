# Checks battery level.
# And notifies if battery level is low or critical.

BATTERY=$(upower -e | grep 'BAT')
LOW=15
CRITICAL=10
ALARM=5

NOTIFY_LOW=TRUE
NOTIFY_CRITICAL=TRUE

while true; do
  if [ -n "$BATTERY" ]; then
    PERCENT=$(upower -i "$BATTERY" | awk '/percentage/ {print $2}' | tr -d '%')
    echo "$PERCENT"
    STATE=$(upower -i "$BATTERY" | awk '/state/ {print $2}')
    echo "$STATE"

    if [[ $STATE == "charging" ]]; then
      NOTIFY_LOW=TRUE
      NOTIFY_CRITICAL=TRUE
      sleep 60

    elif [[ $PERCENT -le $ALARM && "$STATE" == "discharging" ]]; then
      aplay ~/.config/sounds/alarm.wav &
      sleep 3.85

    elif [[ $PERCENT -le $CRITICAL && "$STATE" == "discharging" && $NOTIFY_CRITICAL == "TRUE" ]]; then
      notify-send " Low battery!" -u critical -t 5000
      NOTIFY_CRITICAL=FALSE
      echo "< 10%"
      sleep 60

    elif [[ $PERCENT -le $LOW && "$STATE" == "discharging" && $NOTIFY_LOW == "TRUE" ]]; then
      notify-send " Low battery!" -t 5000 -u critical
      NOTIFY_LOW=FALSE
      sleep 60

    else
      echo "no tresholds"
      sleep 60
    fi
  fi
done

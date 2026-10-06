#!/bin/bash

MODE=$1

if [[ $MODE == "util" ]]; then

    UTILIZATION=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    MODEL=$(nvidia-smi --query-gpu=name --format=csv,noheader | awk '{print $3 " " $4}')

    if [[ "$UTILIZATION" -ge "95" ]]; then
        CLASS="critical"
    fi
    printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' " $UTILIZATION%" "$CLASS" "$MODEL"

elif [[ $MODE == "temp" ]]; then

    TEMPERATURE=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

    if [[ "$TEMPERATURE" -ge "90" ]]; then
        CLASS="critical"
        TEMPERATURE_ICON=""

    elif [[ "$TEMPERATURE" -ge "75" ]]; then
        CLASS="critical"
        TEMPERATURE_ICON=""

    elif [[ "$TEMPERATURE" -ge "60" ]]; then
        CLASS="critical"
        TEMPERATURE_ICON=""

    elif [[ "$TEMPERATURE" -ge "50" ]]; then
        CLASS="critical"
        TEMPERATURE_ICON=""
    else
        TEMPERATURE_ICON=""
    fi

    printf '{"text": "%s%s", "class": "%s"}\n' "$TEMPERATURE_ICON" " $TEMPERATURE°" "$CLASS"

elif [[ $MODE == "vram" ]]; then
    USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
    TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
    USAGE=$(awk "BEGIN {printf \"%d\n\", ($USED / $TOTAL * 100) + 0.5}")
    USED_GIB=$(awk "BEGIN {printf \"%.1f\", $USED / 1024}")
    TOTAL_GIB=$(awk "BEGIN {printf \"%.1f\", $TOTAL / 1024}")

    if [[ "$USAGE" -ge "90" ]]; then
        CLASS="critical"
    fi

    printf '{"text": " %s", "class": "%s", "alt": "%s"}}\n' "$USAGE%" "$CLASS" "$USED_GIB/${TOTAL_GIB} GiB"

fi

# "format-icons": ["", "", "", "", ""],

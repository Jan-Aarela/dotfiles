#!/bin/bash

UTILIZATION=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
# echo $UTILIZATION
MODEL=$(nvidia-smi --query-gpu=name --format=csv,noheader | awk '{print $3 " " $4}')
TEMPERATURE=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
USAGE=$(awk "BEGIN {printf \"%d\n\", ($USED / $TOTAL * 100) + 0.5}")

if [[ "$UTILIZATION" -ge "95" ]];then
    CLASS="critical"
fi



printf '{"text": "%s", "class": "%s", "alt": "%s"}\n' " $UTILIZATION%" "$CLASS" "$MODEL\nTemp: $TEMPERATURE°\nVRAM: $USAGE%"

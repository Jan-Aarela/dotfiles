#!/bin/bash

DELAY=0.01

echo ""
ONEFETCH_OUTPUT=$(onefetch --nerd-fonts)

while IFS= read -r line; do
    echo "$line"
    sleep $DELAY
done <<<"$ONEFETCH_OUTPUT"

#!/bin/bash

# DELAY=0.01

echo ""
ONEFETCH_OUTPUT=$(onefetch --nerd-fonts)

for ((i = 0; i < ${#ONEFETCH_OUTPUT}; i++)); do
  CHAR=${ONEFETCH_OUTPUT:$i:1}
  case "$CHAR" in
  '\n')
    echo
    ;;
  *)
    echo -ne "$CHAR"
    ;;
  esac
  # sleep $DELAY
done

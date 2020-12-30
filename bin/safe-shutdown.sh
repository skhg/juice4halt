#!/usr/bin/env bash

set -eo pipefail

FLAG=/home/pi/juice4halt/.triggered-shutdown
if test -f "$FLAG"; then
    echo "$FLAG exists."
    echo "Shutdown was requested by juice4halt watchdog."
    exit 0
fi

echo "Setting juice4halt module into safe shutdown mode..."

echo "out" > /sys/class/gpio/gpio25/direction
echo "0" > /sys/class/gpio/gpio25/value
sleep 0.1s
echo "in" > /sys/class/gpio/gpio25/direction

echo "juice4halt in safe shutdown mode. Machine can now be powered off."

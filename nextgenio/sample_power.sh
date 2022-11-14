#!/usr/bin/env bash
#
# Bash script to sample likwid-powermeter inteface and save numbers to a set of files.
# This script will run until manually interrupted.
#
# The CPU_POWER_OUTPUT_DIR environment variable must be set before
# running this script.

# Sampling cadence
CADENCE="100ms"
CADENCE_SECS="0.1"

echo "Removing $CPU_POWER_OUTPUT_DIR"
rm -r $CPU_POWER_OUTPUT_DIR
mkdir $CPU_POWER_OUTPUT_DIR

echo "Cadence" >> "$CPU_POWER_OUTPUT_DIR/cadence.txt"
echo $CADENCE >> "$CPU_POWER_OUTPUT_DIR/cadence.txt"

echo "Sampling CPU power..."
n=0
while true; do
    likwid-powermeter -s $CADENCE >> "$CPU_POWER_OUTPUT_DIR/$n.txt"
    ((n++))
done

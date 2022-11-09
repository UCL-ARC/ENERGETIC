#!/usr/bin/env bash
#
# Bash script to sample Intel RAPL inteface and save numbers to a file.
# This script will run until manually interrupted.
#
# The CPU_POWER_OUTPUT_FILE environment variable must be set before
# running this script.

# Sampling cadence in seconds
CADENCE="0.1"
COUNTER="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

rm $CPU_POWER_OUTPUT_FILE

echo "Sampling $COUNTER" >> $CPU_POWER_OUTPUT_FILE
echo "Cadence = $CADENCE seconds" >> $CPU_POWER_OUTPUT_FILE

while /bin/true; do
    cat $COUNTER >> $CPU_POWER_OUTPUT_FILE
    sleep $CADENCE
done

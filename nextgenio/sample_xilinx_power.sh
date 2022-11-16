#!/usr/bin/env bash
#
# Bash script to sample Xilinx votage/current files and save numbers to a file.
# This script will run until manually interrupted.
#
# The XILINX_OUTPUT_FILE environment variable must be set before
# running this script.

# Make sure XILINX_OUTPUT_FILE variable is defined
set -u
: "$XILINX_OUTPUT_FILE"

rm $XILINX_OUTPUT_FILE
# Sampling cadence in seconds
CADENCE="0.1"
# Current and voltage files
COUNTER_DIR="/sys/devices/pci0000:c0/0000:c0:01.1/0000:c3:00.1/xmc.u.19922944"
COUNTER_I="$COUNTER_DIR/xmc_12v_pex_curr"
COUNTER_V="$COUNTER_DIR/xmc_12v_pex_vol"


echo "Sampling current and voltage from $COUNTER_DIR" >> $XILINX_OUTPUT_FILE
echo "Cadence = $CADENCE seconds" >> $XILINX_OUTPUT_FILE
echo "Time, Current, Voltage" >> $XILINX_OUTPUT_FILE

while /bin/true; do
    I=$(cat $COUNTER_I)
    V=$(cat $COUNTER_V)
    TIME=$(date --iso-8601=ns)
    echo "$TIME, $I, $V" >> $XILINX_OUTPUT_FILE
    sleep $CADENCE
done

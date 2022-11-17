#!/usr/bin/env bash
#
# Script to run GEMM on a Xilinx FPGA and sample current/voltage
# hardware counters.

# Error on unset evironment variables
set -u

export XILINX_OUTPUT_FILE="xilinx_power.csv"
MATRIX_SIZE=4096  # Must be a multiple of 16


# Start sampling FPGA
echo "Starting Xilinx power sampling..."
../sample_xilinx_power.sh &
XILINX_POWER_PID=$!

echo "Running GEMM benchmark..."

cd gemm_hls/build
VERIFY="off"
./RunHardware.exe $MATRIX_SIZE $MATRIX_SIZE $MATRIX_SIZE hw $VERIFY
cd ../..

echo "Benchmark finished"
echo "Stopping Xilinx power sampling"
kill $XILINX_POWER_PID

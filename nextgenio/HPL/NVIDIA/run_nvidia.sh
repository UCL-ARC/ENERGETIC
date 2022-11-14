#!/usr/bin/env bash
POWER_CADENCE_MS=100
GPU_POWER_FILE="gpu_power.csv"
export CPU_POWER_OUTPUT_DIR="./power_obs"

rm $GPU_POWER_FILE

# Start sampling GPU
echo "Sampling GPU power..."
nvidia-smi --query-gpu=power.draw --format=csv --loop-ms=$POWER_CADENCE_MS --filename=$GPU_POWER_FILE &
NVIDIA_SMI_PID=$!

# Start sampling CPU
../../sample_power.sh &
CPU_SAMPLE_PID=$!

mpirun -n 4 \
    singularity run --nv \
    -B "./hpl_dat:/my-dat-files" \
    hpc-benchmarks\:21.4-hpl.sif \
    hpl.sh \
    --dat "/my-dat-files/HPL.dat" \
    --cpu-affinity +0:+1:+2:+3 \
    --gpu-affinity 0:0:0:0 \
    --cpu-cores-per-rank 1

kill $NVIDIA_SMI_PID
kill $CPU_SAMPLE_PID

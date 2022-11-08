#!/usr/bin/env bash
POWER_CADENCE_MS=100
GPU_POWER_FILE=gpu_power.csv

rm $GPU_POWER_FILE

nvidia-smi --query-gpu=power.draw --format=csv --loop-ms=$POWER_CADENCE_MS --filename=$GPU_POWER_FILE &
NVIDIA_SMI_PID=$!

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

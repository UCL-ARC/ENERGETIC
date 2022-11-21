set -u

POWER_CADENCE_MS=10
GPU_POWER_FILE="gpu_power.csv"

rm $GPU_POWER_FILE

# Start sampling GPU
echo "Sampling GPU power..."
nvidia-smi --query-gpu=timestamp,power.draw --format=csv --loop-ms=$POWER_CADENCE_MS --filename=$GPU_POWER_FILE &
NVIDIA_SMI_PID=$!

./gemm

kill $NVIDIA_SMI_PID

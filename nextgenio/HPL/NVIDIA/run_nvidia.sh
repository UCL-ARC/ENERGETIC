mpirun -n 4 \
    singularity run --nv \
    -B "./hpl_dat:/my-dat-files" \
    hpc-benchmarks\:21.4-hpl.sif \
    hpl.sh \
    --dat "/my-dat-files/HPL.dat" \
    --cpu-affinity +0:+1:+2:+3 \
    --gpu-affinity 0:0:0:0 \
    --cpu-cores-per-rank 1

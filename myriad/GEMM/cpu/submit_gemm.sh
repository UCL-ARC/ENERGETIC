#!/bin/bash -l

# Request wallclock time (format hours:minutes:seconds).
#$ -l h_rt=00:10:00

# Request 3G RAM per node (must be an integer followed by M, G, or T)
#$ -l mem=3G

# Request TMPDIR space (default is 10 GB - remove if cluster is diskless)
#$ -l tmpfs=1G

# Select the MPI parallel environment and number of cores
# If you change this, remember to change the number of MPI processes below!
#
# Set to 36 to reserve a whole node so energy measurements aren't affected
# by what anyone else is doing.
#$ -pe mpi 4

# Set the name of the job.
#$ -N HPL_tests

# Only run on one type of node
# See https://www.rc.ucl.ac.uk/docs/Clusters/Myriad/#node-types for node documentation
#
# Currently set to any node that has Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz
#$ -ac allow=BDEL

# Set the working directory to somewhere in your scratch space.
# This is a necessary step as compute nodes cannot write to $HOME.
#$ -wd /home/ucasdst/Scratch

# Do work in a temporary directory
BASEDIR="$HOME/ENERGETIC/myriad/GEMM/cpu"
export CPU_POWER_OUTPUT_FILE="cpu_rapl_power_cadence_$JOB_ID.txt"
COUNTER="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

module load compilers/intel numactl

# Copy HPL to temporary directory, and build
cd $TMPDIR
cp -r $BASEDIR .
cd cpu
make mkl

# Run script to sample RAPL, and save PID so we can manually interrupt
# after benchmark has been run
./sample_cpu.sh &
RAPL_SAMPLE_PID=$!
# echo $(date "+%Y-%m-%d %H:%M:%S %N") >> $CPU_POWER_OUTPUT_FILE
# Run benchmark

MATH_LIB='mkl'
MATRIX_RANK=4096
N_THREADS=4

bash run.sh $N_THREADS $MATRIX_RANK $MATH_LIB
kill $RAPL_SAMPLE_PID

# Move output file
mv -f $CPU_POWER_OUTPUT_FILE "$BASEDIR/data"

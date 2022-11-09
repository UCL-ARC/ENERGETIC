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
# Set to 32 to reserve a whole node so energy measurements aren't affected
# by what anyone else is doing.
#$ -pe mpi 32

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
BASEDIR="$HOME/ENERGETIC/myriad/hpl/cpu"
ARCH="Linux_Intel64"
export CPU_POWER_OUTPUT_FILE="cpu_rapl_power_cadence_$JOB_ID.txt"
COUNTER="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

# Copy HPL to temporary directory, and build
cd $TMPDIR
cp -r "$BASEDIR/hpl-2.3" .
cd "hpl-2.3"
make arch=$ARCH
# Change to directory with binary
cd "bin/$ARCH"
# Copy input file so it's next to binary
cp "$BASEDIR/HPL.dat" .

# Run script to sample RAPL, and save PID so we can manually interrupt
# after benchmark has been run
$BASEDIR/sample_cpu.sh &
RAPL_SAMPLE_PID=$!
# echo $(date "+%Y-%m-%d %H:%M:%S %N") >> $CPU_POWER_OUTPUT_FILE
# Run benchmark
mpirun -np 32 "$(pwd)/xhpl"
kill $RAPL_SAMPLE_PID

# Move output file
mv -f $CPU_POWER_OUTPUT_FILE $BASEDIR

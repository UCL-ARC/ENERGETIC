#!/bin/bash -l

# Request wallclock time (format hours:minutes:seconds).
#$ -l h_rt=00:10:00

# Request 2G RAM per node (must be an integer followed by M, G, or T)
#$ -l mem=2G

# Request TMPDIR space (default is 10 GB - remove if cluster is diskless)
#$ -l tmpfs=1G

# Select the MPI parallel environment and number of cores
# If you change this, remember to change the number of MPI processes below!
#
# Set to 36 to reserve a whole node so energy measurements aren't affected
# by what anyone else is doing.
#$ -pe mpi 36

# Set the name of the job.
#$ -N STREAM

# Only run on one type of node
# See https://www.rc.ucl.ac.uk/docs/Clusters/Myriad/#node-types for node documentation
#
# Currently set to any node that has Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz
#$ -ac allow=BDEL

# Set the working directory to somewhere in your scratch space.
# This is a necessary step as compute nodes cannot write to $HOME.
#$ -wd /home/ucasdst/Scratch

# Do work in a temporary directory
BASEDIR="$HOME/ENERGETIC/myriad/STREAM/cpu"
export CPU_POWER_OUTPUT_FILE="cpu_rapl_power_cadence_$JOB_ID.txt"
COUNTER="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"
CPU_SCRIPT="$HOME/ENERGETIC/myriad/sample_cpu.sh"

# Copy HPL to temporary directory, and build
cd $TMPDIR
cp -r $BASEDIR .
cd cpu
make clean
make stream_c.exe

# Run script to sample RAPL, and save PID so we can manually interrupt
# after benchmark has been run
$CPU_SCRIPT &
RAPL_SAMPLE_PID=$!
# Run
./stream_c.exe
kill $RAPL_SAMPLE_PID

# Move output file
mv -f $CPU_POWER_OUTPUT_FILE $BASEDIR

#!/bin/bash -l

# Request wallclock time (format hours:minutes:seconds).
#$ -l h_rt=0:10:0

# Request RAM (must be an integer followed by M, G, or T)
#$ -l mem=1G

# Request TMPDIR space (default is 10 GB - remove if cluster is diskless)
#$ -l tmpfs=10G

# Select the MPI parallel environment and number of processes
#$ -pe mpi 4

# Set the name of the job.
#$ -N HPL_tests

# Only run on one type of node
# See https://www.rc.ucl.ac.uk/docs/Clusters/Myriad/#node-types for node documentation
#
#$ -ac allow=H

# Set the working directory to somewhere in your scratch space.
# This is a necessary step as compute nodes cannot write to $HOME.
#$ -wd $HOME/Scratch

# Do work in a temporary directory
cd $TMPDIR
ARCH="Linux_Intel64"
HPLDIR="$HOME/ENERGETIC/cpu/hpl-2.3"
CPU_POWER_OUTPUT_FILE="cpu_rapl_power_cadence.txt"
COUNTER="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

# Copy HPL to temporary directory, and build
cp -r $HPLDIR .
cd "hpl-2.3"
make arch=$ARCH
cd "bin/$ARCH"

# Run
echo $(cat $COUNTER) >> $CPU_POWER_OUTPUT_FILE
mpirun -np 4 "$(pwd)/xhpl"
echo $(cat $COUNTER) >> $CPU_POWER_OUTPUT_FILE

# Move output file
mv -f $CPU_POWER_OUTPUT_FILE "$HOME/ENERGETIC/cpu/measurements"

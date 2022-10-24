#!/bin/bash -l

export UCLID=
export HPLDIR="$HOME/ENERGETIC/hpl-2.3"

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

# Set the working directory to somewhere in your scratch space.
# This is a necessary step as compute nodes cannot write to $HOME.
#$ -wd /home/$UCLID/Scratch
# Your work should be done in $TMPDIR
export ARCH=Linux_Intel64

cd $TMPDIR
cp -r $HPLDIR .
cd "hpl-2.3"
make arch=$ARCH
cd "bin/$ARCH"
mpirun -np 4 "$(pwd)/xhpl"

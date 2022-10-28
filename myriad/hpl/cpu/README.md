# HPL on myriad CPU

`hpl-2.3.tar.gz` was originally downloaded from https://netlib.org/benchmark/hpl/.

Steps to run:

1. Copy `hpl-2.3.tar.gz` to myriad and extract the files
2. Copy `Make.Linux_Intel64` to the extracted directory
3. Run `make`
4. Copy `submit_hpl.sh` to myriad, and modify the following lines:
    - `HPLDIR="$HOME/ENERGETIC/hpl-2.3"` to point to the extracted directory.
5. Copy `HPL.dat` to `bin/Linux_Intel64`
6. Submit the job using `qsub submit_hpl.sh`

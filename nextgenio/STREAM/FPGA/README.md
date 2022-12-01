# STREAM on Xilinx FPGA

Note that this needs to be done on a node that has the FPGA, and does not work on the login node.

1. `module load vitis quartus cmake` - note that order matters here to load cmake last so a recent version is available!
1. `cmake ../HPCC_FPGA/STREAM -DCMAKE_C_COMPILER=/home/software/gnu/10.2/bin/gcc -DCMAKE_CXX_COMPILER=/home/software/gnu/10.2/bin/g++ -DFPGA_BOARD_NAME=xilinx_u280_xdma_201920_3 -DDEFAULT_REPETITIONS=1`
1. `make STREAM_FPGA_test_xilinx`
1. `make test`

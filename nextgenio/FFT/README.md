# Building FFT on nextgenio

1. `module load vitis init_opencl`
1. `export PLATFORM_REPO_PATHS=/home/nx08/shared/fpga/xilinx/2020.2/Vitis/2020.2/platforms`
1. `make -C Vitis_Libraries/dsp/L2/tests/hw/2dfft/fixed all TARGET=sw_emu PLATFORM=xilinx_u280_xdma_201920_3`

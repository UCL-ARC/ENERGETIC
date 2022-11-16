# SGEMM on FPGA
## SGEMM on Xilinx FPGA
The SGEMM benchmark code is included in a git submodule, `gemm_hls`.

1. Make sure this is present and up to date using `git submodule update --init --recursive`.
1. ssh into `nextgenio`
1. ssh into the node that has the FPGA you want to compile for and run on. See the [FPGA testbed docs on running on FPGAs](https://fpga.epcc.ed.ac.uk/docs/running_fpga.html) for more info on available hardware/nodes.
1. `source /home/nx08/shared/fpga/fpga_modules.sh && module load vitis` to load the vitis toolkits.
1. Use `xbutil examine` to list available hardware. You should get an output like this:
```
System Configuration
  OS Name              : Linux
  Release              : 3.10.0-1160.76.1.el7.x86_64
  Version              : #1 SMP Wed Aug 10 16:21:17 UTC 2022
  Machine              : x86_64
  CPU Cores            : 128
  Memory               : 257749 MB
  Distribution         : CentOS Linux 7 (Core)
  GLIBC                : 2.17
  Model                : ProLiant DL385 Gen10 Plus

XRT
  Version              : 2.11.634
  Branch               : 2021.1
  Hash                 : 5ad5998d67080f00bca5bf15b3838cf35e0a7b26
  Hash Date            : 2021-06-09 05:08:58
  XOCL                 : 2.11.634, 5ad5998d67080f00bca5bf15b3838cf35e0a7b26
  XCLMGMT              : 2.11.634, 5ad5998d67080f00bca5bf15b3838cf35e0a7b26

Devices present
  [0000:c3:00.1] : xilinx_u280_xdma_201920_3
  ```
6. Make a note of the device name. In the example above this is `xilinx_u280_xdma_201920_3`.
6. Edit the `set(MM_PLATFORM "xilinx_u250_gen3x16_xdma_3_1_202020_1" CACHE STRING "Platform string for Vitis.")` line in `gemm_hls/CMakeLists.txt`, replacing the platform string with the platform name found in the previous step.
6. Follow the instructions in `gemm_hls/README.md` to compile (this takes many hours!!) and run the benchmark.

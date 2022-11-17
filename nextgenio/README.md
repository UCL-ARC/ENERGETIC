# `nextgenio`

## Measuring CPU power
`likwid` can be used to measure CPU power on `nextgenio`, using `likwid-perfcounter` ([docs](https://rrze-hpc.github.io/likwid/Doxygen/likwid-perfctr.html)).

1. Load required modules: `module load compiler-rt likwid`
1. `likwid-perfctr -c N -group ENERGY -t 100ms -O bash my_script.sh >> likwid_output.csv 2>&1`

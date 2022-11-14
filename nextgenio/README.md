# `nextgenio`

## Measuring CPU power
`likwid` can be used to measure CPU power on `nextgenio`.

1. Load required modules:
```
module load compiler-rt likwid
```
2. `likwid-perfctr -c N -group ENERGY -t 1s`

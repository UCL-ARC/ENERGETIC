"""
A script to parse a series of power observations recorded
using the `sample_power.sh` script.
"""
import glob
from collections import defaultdict
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

power_obs_dir = Path(__file__).parent / 'power_obs'
# Manually set cadence from `cadence.txt` file
cadence = 0.1

files = glob.glob(str(power_obs_dir / '*.txt'))
files = [Path(f) for f in files if not f.endswith('cadence.txt')]

# Line numbers in the text file that contain energy measurements
energy_socket_lines = [10, 24]

print("Loading energy data...")
data = {}
for fpath in files:
    t = int(fpath.stem) * cadence
    with open(fpath, 'r') as f:
        lines = f.readlines()

    data[t] = {}
    for socket, line in enumerate(energy_socket_lines):
        power = lines[line]
        power = power.split(' ')[2]
        data[t][socket] = float(power)

# Convert to dataframe
df = pd.DataFrame(data).T
df = df.sort_index()
df.columns = ['Socket 0', 'Socket 1']

# Calculate total energy
print("Calculating total energy...")
total_energy = df.sum()
print(total_energy)

fig, ax = plt.subplots()
for col in df.columns:
    ax.plot(df.index, df[col] / cadence, label=f"{col}, {total_energy[col]:.1f} J")

ax.set_xlabel('Time since start / s')
ax.set_ylabel('Power draw / W')
ax.set_title(f"Total energy consumption: {np.sum(total_energy.values):.1f} J")
ax.set_ylim(0)
ax.legend()
plt.show()

import tempfile

import pandas as pd


def load_likwid_file(fname: str) -> tuple[pd.Series, pd.DataFrame, pd.DataFrame]:
    """
    Load a likwid output CSV file.
    
    Returns
    -------
    times, energy, power
    """
    with open(fname, 'r') as f:
        lines = f.readlines()
    
    # Strip out non-data stdout/err lines
    lines = [l for l in lines if l.startswith('1,8,128')]
    fp = tempfile.NamedTemporaryFile()
    with open(fp.name, 'w') as f:
        for l in lines:
            f.write(l)

    cpu_data = pd.read_csv(fp.name, header=None)
    # Time since start of execution
    times = cpu_data.iloc[:, 3]
    offset = 4
    # Energy core
    si = 4 + 128 * offset
    ei = 4 + 128 * (offset + 1)
    energy_core = cpu_data.iloc[:, si:ei]
    offset = 5
    # Power core
    si = 4 + 128 * offset
    ei = 4 + 128 * (offset + 1)
    power_core = cpu_data.iloc[:, si:ei]
    
    return times, energy_core, power_core
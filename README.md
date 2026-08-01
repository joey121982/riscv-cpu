# RISC-V RV32I Single-Cycle CPU

## Design

#### Components
* PC (pc.sv)
* IMEM (imem.sv)
* ALU (alu.sv)
* RegFile (regfile.sv)
* ImmGen (immgen.sv)
* BCE (bce.sv)
* DMEM (dmem.sv)
* CU (cu.sv)
* Top (top.sv)

## Testing with .hex compiled programs

Inside the ```hextb``` directory, you can find a testbench that is configured to load a specified .hex file into the CPU DUT's memory and then reset the CPU and let it run.

To use this testbench, simply run
```make hex FILE="program name"```
from the root of the project.
> You can also create new folders inside hextb/examples/ containing .c and .s source files.
> Then, when calling ```make hex``` with FILE pointing to this new folder, the Makefile will compile your program and run the testbench with it.

After this, you can view the waveforms using GTKWave via
```make waves```

## UVM Verification

> Not started yet.
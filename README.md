# RISC-V RV32I Single-Cycle CPU
An RV32I ISA based CPU with complete support for 37 out of 40 instructions and NOP placeholders for FENCE, ECALL and EBREAK, designed with a Harvard Architecture and implemented in SystemVerilog. 

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

## Prerequisites
>[!NOTE]
> There is no support for Windows or Mac systems, and the project was made using Linux.
> You can edit the build system yourself to add support for your own system.

To compile C/Assembly programs and simulate the CPU, you will need:
* RISC-V GNU Toolchain (e.g., `riscv64-unknown-elf-gcc` or `riscv64-elf-gcc`)
> You can modify the Makefile located at ```hextb/examples/Makefile``` to suit your specific toolchain configuration.
* Verilator
* GTKWave

## Testing with .hex compiled programs

Inside the ```hextb``` directory, you can find a testbench that is configured to load a specified .hex file into the CPU DUT's memory and then reset the CPU and let it run.

To use this testbench, simply run
```make hex FILE="program name"```
from the root of the project.
>[!NOTE]
> You can also create new folders inside ```hextb/examples/``` containing .c and .s source files.
> Then, when calling ```make hex``` with ```FILE``` pointing to this new folder, the Makefile will compile your program and run the testbench with it.

After this, you can view the waveforms using GTKWave via ```make waves```. Also included is a ```signals.gtkw``` file already containing important signals, which can be loaded directly into GTKWave when viewing waveforms.

> The project can be cleaned using ```make clean```

## UVM Verification

> Not started yet.

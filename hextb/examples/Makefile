PREFIX  ?= riscv64-elf-
CC      = $(PREFIX)gcc
OBJCOPY = $(PREFIX)objcopy
OBJDUMP = $(PREFIX)objdump

ARCH    = -march=rv32i -mabi=ilp32

CFLAGS  = $(ARCH) -O0 -nostdlib -nostartfiles -Ttext 0x0

src ?= default

SRCS = $(wildcard $(src)/*.c) $(wildcard $(src)/*.s) $(wildcard $(src)/*.S)

.PHONY: all clean

all:
	@echo "Compiling sources from $(src)/..."
	$(CC) $(CFLAGS) $(SRCS) -o $(src).elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $(src).elf $(src).hex
	$(OBJDUMP) -d -M numeric,no-aliases $(src).elf > $(src).dump
	@echo "Success! Created $(src).hex and $(src).dump"

clean:
	rm -f *.elf *.hex *.dump
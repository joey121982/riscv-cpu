PREFIX  ?= riscv64-elf-
CC      = $(PREFIX)gcc
OBJCOPY = $(PREFIX)objcopy
OBJDUMP = $(PREFIX)objdump

ARCH    = -march=rv32i -mabi=ilp32

src ?= default

LDSCRIPT = $(wildcard $(src)/*.ld)

ifneq ($(LDSCRIPT),)
    LINKER_FLAG = -T $(firstword $(LDSCRIPT))
else
    LINKER_FLAG = -Ttext 0x0
endif

CFLAGS  = $(ARCH) -O0 -nostdlib -nostartfiles $(LINKER_FLAG)

SRCS = $(wildcard $(src)/*.s) $(wildcard $(src)/*.S) $(wildcard $(src)/*.c)

.PHONY: all clean

all:
	@echo "Compiling sources from $(src)/ using $(LINKER_FLAG)..."
	$(CC) $(CFLAGS) $(SRCS) -o $(src).elf
	$(OBJCOPY) -O verilog --verilog-data-width=4 $(src).elf $(src).hex
	$(OBJDUMP) -d -M numeric,no-aliases $(src).elf > $(src).dump
	@echo "Success! Created $(src).hex and $(src).dump"

clean:
	rm -f *.elf *.hex *.dump
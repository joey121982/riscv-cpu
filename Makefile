VERILATOR  = verilator
UVM_ROOT   = uvm-core/src
SRC_DIR    = src
TB_DIR     = tb
TOP_MODULE = tb
EXE        = obj_dir/V$(TOP_MODULE)
WAVEFORM   = dump.vcd
TEST_NAME  = testname

HEX_TB     = hextb/tb.sv
HEX_EXE    = obj_dir/V$(TOP_MODULE)

FILE       ?= hextb/examples/default.hex
HEX_SRC    = $(notdir $(basename $(FILE)))

VFLAGS = --binary -j 0 --trace --timing -Wno-lint \
         +define+UVM_NO_DPI \
         +incdir+$(UVM_ROOT) $(UVM_ROOT)/uvm_pkg.sv \
         +incdir+$(SRC_DIR) \
         +incdir+$(TB_DIR) \
         $(SRC_DIR)/*.sv $(TB_DIR)/*.sv \
         --top-module $(TOP_MODULE)

HEX_VFLAGS = --binary -j 0 --trace --timing -Wno-lint \
             +incdir+$(SRC_DIR) \
             $(SRC_DIR)/*.sv $(HEX_TB) \
             --top-module $(TOP_MODULE)

.PHONY: all build sim wave clean hex

all: build

build:
	@echo "Building binary..."
	$(VERILATOR) $(VFLAGS)

sim: build
	@echo "Running simulation..."
	./$(EXE) +UVM_TESTNAME=$(TEST_NAME)

hex:
	@echo "Building hex testbench..."
	$(VERILATOR) $(HEX_VFLAGS)
	@echo "Building example code for $(HEX_SRC)..."
	$(MAKE) -C hextb/examples src=$(HEX_SRC)
	@echo "Running hex simulation with $(FILE)..."
	./$(HEX_EXE) +HEX_FILE=hextb/examples/$(FILE).hex

wave:
	@echo "Opening waveforms in GTKWave..."
	gtkwave $(WAVEFORM) &

clean:
	rm -rf obj_dir $(WAVEFORM)
	$(MAKE) -C hextb/examples clean
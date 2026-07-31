VERILATOR  = verilator
UVM_ROOT   = uvm-core/src
SRC_DIR    = src
TB_DIR     = tb
TOP_MODULE = tb
EXE        = obj_dir/V$(TOP_MODULE)
WAVEFORM   = dump.vcd
TEST_NAME  = testname

VFLAGS = --binary -j 0 --trace --timing -Wno-lint \
         +define+UVM_NO_DPI \
         +incdir+$(UVM_ROOT) $(UVM_ROOT)/uvm_pkg.sv \
         +incdir+$(SRC_DIR) \
         +incdir+$(TB_DIR) \
         $(SRC_DIR)/*.sv $(TB_DIR)/*.sv \
         --top-module $(TOP_MODULE)

.PHONY: all build sim run clean

all: build

build:
	@echo "Building binary..."
	$(VERILATOR) $(VFLAGS)

sim: build
	@echo "Running simulation..."
	./$(EXE) +UVM_TESTNAME=$(TESTNAME)

run: sim
	@echo "Opening waveforms in GTKWave..."
	gtkwave $(WAVEFORM) &

clean:
	rm -rf obj_dir $(WAVEFORM)
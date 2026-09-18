// .hex program testbench
// Simply loads a .hex file into memory and runs it on the CPU design

module tb ();

logic   clk;
logic   rst;

localparam int IO_PORTS = 3;
localparam logic [31:0] MMIO_BASE = 32'h8000;

logic [31:0] io_in  [0:IO_PORTS-1];
logic [31:0] io_out [0:IO_PORTS-1];
logic [31:0] io_dir [0:IO_PORTS-1];

core #(
    .IO_PORTS(IO_PORTS),
    .MMIO_BASE(MMIO_BASE)
) dut (
    .clk(clk),
    .rst(rst),
    .io_in(io_in),
    .io_out(io_out),
    .io_dir(io_dir)
);

initial begin
    clk = 0;
    forever #1 clk = ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
end

initial begin
    string hex_file;
    
    for (int i = 0; i < IO_PORTS; i++) begin
        io_in[i] = 32'd0;
    end
    
    if ($value$plusargs("HEX_FILE=%s", hex_file)) begin
        $display("Loading %s into memory...", hex_file);
        $readmemh(hex_file, dut.my_imem.memory); 
    end else begin
        $display("No HEX file provided. Using default.");
        $readmemh("hextb/examples/default.hex", dut.my_imem.memory);
    end

    rst = 1;
    #2;
    rst = 0;

    #100000;
    
    $display("Simulation finished.");
    $finish;
end

endmodule
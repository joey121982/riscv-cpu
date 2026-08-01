// .hex program testbench
// Simply loads a .hex file into memory and runs it on the CPU design

module tb ();

logic   clk;
logic   rst;

top dut (
    .clk(clk),
    .rst(rst)
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
module imem #(
    parameter   string  INIT_FILE = "firmware.hex"
) (
    input   logic   [31:0]  addr,
    output  logic   [31:0]  inst
);

logic [31:0] memory [0:8191];

initial begin 
    integer i;
    for (i = 0; i < 8192; i = i + 1) begin
        memory[i] <= 32'b0;
    end
    $readmemh(INIT_FILE, memory);
end

assign inst = memory[addr[14:2]];   // divide the address by 4 by truncating

endmodule
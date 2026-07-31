module imem (
    input   logic   [31:0]  addr,
    output  logic   [31:0]  inst
);

logic [31:0] memory [8192];

assign inst = memory[addr[14:2]];   // divide the address by 4 by truncating

endmodule
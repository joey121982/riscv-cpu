module imem #(
    parameter   string  INIT_FILE = "firmware.hex"
) (
    input   logic   [31:0]  addr,
    output  logic   [31:0]  inst
);

logic [31:0] memory [0:8191];

initial $readmemh(INIT_FILE, memory);

assign inst = memory[addr[14:2]];   // divide the address by 4 by truncating

endmodule
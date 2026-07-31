module dmem (
    input   logic   clk,
    input   logic   we,

    input   logic   [31:0]  addr,
    input   logic   [31:0]  w_data,

    output  logic   [31:0]  r_data
);

logic   [31:0]  memory  [0:8191];

always_ff @(posedge clk) begin
    if (we) memory[addr[14:2]] <= w_data;
end

assign r_data = memory[addr[14:2]];

endmodule
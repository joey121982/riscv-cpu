module pc (
    input   logic   clk,
    input   logic   rst,

    input   logic   [31:0]  next_pc,
    output  logic   [31:0]  curr_pc
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) curr_pc <= 32'd0;
    else     curr_pc <= next_pc;
end

endmodule
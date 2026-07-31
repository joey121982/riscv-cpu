module regfile (
    input   logic   clk,
    input   logic   we,

    input   logic   [4:0]   r_addr1,
    input   logic   [4:0]   r_addr2,
    input   logic   [4:0]   w_addr,
    input   logic   [31:0]  w_data,

    output  logic   [31:0]  r_data1,
    output  logic   [31:0]  r_data2
);

logic [31:0] regs [0:31];

assign r_data1 = (r_addr1 != 5'd0) ? regs[r_addr1] : 32'd0;
assign r_data2 = (r_addr2 != 5'd0) ? regs[r_addr2] : 32'd0;

always_ff @(posedge clk) begin
    if (we & (w_addr != 5'd0)) begin
        regs[w_addr] <= w_data;
    end
end

endmodule
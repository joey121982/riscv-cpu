`include "dmem_types.svh"

module mmio #(
    parameter int NUM_PORTS = 3,
    parameter logic [31:0] BASE_ADDR = 32'h8000
) (
    input   logic               clk,
    input   logic               we,
    input   logic       [31:0]  addr,
    input   logic       [31:0]  w_data,
    input   mem_size_t          mem_size,

    input   logic       [0:NUM_PORTS-1][31:0]   pin_in,     // IDR
    output  logic       [0:NUM_PORTS-1][31:0]   pin_out,    // ODR
    output  logic       [0:NUM_PORTS-1][31:0]   pin_dir,    // DDR
    output  logic       [31:0]  r_data
);

logic [31:0] word_offset;
logic [31:0] port_index;
logic [1:0]  reg_type;

assign word_offset = (addr - BASE_ADDR) >> 2;
assign port_index  = word_offset >> 2; 
assign reg_type    = word_offset[1:0]; 

always_comb begin
    r_data = 32'd0;
    
    if (port_index < NUM_PORTS) begin
        case (reg_type)
            2'b00: r_data = pin_in[port_index];
            2'b01: r_data = pin_out[port_index];
            2'b10: r_data = pin_dir[port_index];
            default: r_data = 32'd0;
        endcase
    end
end

always_ff @(posedge clk) begin
    if (we && (port_index < NUM_PORTS)) begin
        case (reg_type)
            2'b01: pin_out[port_index] <= w_data;
            2'b10: pin_dir[port_index] <= w_data;
            default: ; 
        endcase
    end
end

endmodule
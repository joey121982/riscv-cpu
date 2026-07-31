`include "branchtypes.svh"

module bce (
    input   logic   [31:0]  rs1,
    input   logic   [31:0]  rs2,
    input   br_t            br_type,

    output  logic           result
);

always_comb begin
    unique case (br_type)
        BR_EQ:      result = (rs1 == rs2);
        BR_NEQ:     result = (rs1 != rs2);
        BR_LT:      result = ($signed(rs1)   <  $signed(rs2));
        BR_GE:      result = ($signed(rs1)   >= $signed(rs2));
        BR_LTU:     result = ($unsigned(rs1) <  $unsigned(rs2));
        BR_GEU:     result = ($unsigned(rs1) >= $unsigned(rs2));
        default:    result = 0;
    endcase
end

endmodule
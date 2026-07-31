`include "imm_types.svh"

module immgen (
    input   logic   [31:0]  inst,
    input   imm_t           imm_type,

    output  logic   [31:0]  result
);

always_comb begin
    unique case (imm_type)
        IMM_I:      result = { {20{inst[31]}}, inst[31:20] };
        IMM_S:      result = { {20{inst[31]}}, inst[31:25], inst[11:7] };
        IMM_B:      result = { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 };
        IMM_U:      result = { inst[31:12], 12'b0 };
        IMM_J:      result = { {12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0 };
        default:    result = 32'd0;
    endcase
end

endmodule
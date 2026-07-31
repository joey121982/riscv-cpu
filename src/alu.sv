`include "opcodes.svh"

module alu (
    input   alu_opcode_t    opcode,
    input   logic   [31:0]  loperand,
    input   logic   [31:0]  roperand,

    output  logic   [31:0]  result
);

always_comb begin
    unique case (opcode)
        ALU_ADD:    result = loperand + roperand;
        ALU_SUB:    result = loperand - roperand;
        ALU_XOR:    result = loperand ^ roperand;
        ALU_OR:     result = loperand | roperand;
        ALU_AND:    result = loperand & roperand;
        ALU_SLL:    result = loperand << roperand[4:0];
        ALU_SRL:    result = loperand >> roperand[4:0];
        ALU_SRA:    result = $signed(loperand) >>> roperand[4:0];
        ALU_SLT:    result = ($signed(loperand) < $signed(roperand)) ? 32'd1 : 32'd0;
        ALU_SLTU:   result = (loperand < roperand) ? 32'd1 : 32'd0;
        default:    result = 32'd0;
    endcase
end

endmodule
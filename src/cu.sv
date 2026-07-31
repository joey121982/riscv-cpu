`include "cu_types.svh"
`include "alu_opcodes.svh"
`include "imm_types.svh"

module cu (
    input   pc_opcode_t opcode,
    input   funct3_t    funct3,
    input   funct7_t    funct7,
    input   logic       bce_eval,

    output  pc_src_t        pc_src,
    output  result_src_t    result_src,
    output  logic           mem_we,
    output  alu_opcode_t    alu_op,
    output  alu_src_t       alu_src,
    output  imm_t           imm_type,
    output  logic           reg_we
);



endmodule
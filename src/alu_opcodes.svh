`ifndef ALU_OPCODES_SVH
`define ALU_OPCODES_SVH

typedef enum logic [3:0] {
    ALU_ADD,
    ALU_SUB,
    ALU_XOR,
    ALU_OR,
    ALU_AND,
    ALU_SLL,
    ALU_SRL,
    ALU_SRA,
    ALU_SLT,
    ALU_SLTU
} alu_opcode_t;

`endif // ALU_OPCODES_SVH
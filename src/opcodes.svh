`ifndef OPCODES_SVH
`define OPCODES_SVH

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

`endif // OPCODES_SVH
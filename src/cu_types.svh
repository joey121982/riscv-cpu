`ifndef CU_TYPES_SVH
`define CU_TYPES_SVH

typedef enum logic [1:0] {
    PC_NORMAL,
    PC_TARGET,
    PC_ALU
} pc_src_t;

typedef enum logic [1:0] {
    RES_ALU,
    RES_MEM,
    RES_PC,
    RES_IMM
} result_src_t;

typedef enum logic {
    ALU_SRC_REG,
    ALU_SRC_IMM
} alu_src_t;

typedef enum logic [6:0] {
    OP_LOAD   = 7'b0000011,
    OP_IMM    = 7'b0010011,
    OP_AUIPC  = 7'b0010111,
    OP_STORE  = 7'b0100011,
    OP_OP     = 7'b0110011,
    OP_LUI    = 7'b0110111,
    OP_BRANCH = 7'b1100011,
    OP_JALR   = 7'b1100111,
    OP_JAL    = 7'b1101111,
    OP_SYSTEM = 7'b1110011  // not supported
} pc_opcode_t;

typedef enum logic [2:0] {
    F3_ADD_SUB = 3'b000,
    F3_SLL     = 3'b001,
    F3_SLT     = 3'b010,
    F3_SLTU    = 3'b011,
    F3_XOR     = 3'b100,
    F3_SRL_SRA = 3'b101,
    F3_OR      = 3'b110,
    F3_AND     = 3'b111
} funct3_t;

typedef enum logic [6:0] {
    F7_ADD_SRL = 7'b0000000,
    F7_SUB_SRA = 7'b0100000
} funct7_t

`endif // CU_TYPES_SVH
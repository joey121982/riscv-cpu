`ifndef IMM_TYPES_SVH
`define IMM_TYPES_SVH

typedef enum logic [2:0] {
    IMM_I,
    IMM_S,
    IMM_B,
    IMM_U,
    IMM_J
} imm_t;

`endif // IMM_TYPES_SVH
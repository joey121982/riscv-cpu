`ifndef IMMTYPES_SVH
`define IMMTYPES_SVH

typedef enum logic[2:0] {
    IMM_I,
    IMM_S,
    IMM_B,
    IMM_U,
    IMM_J
} imm_t;

`endif // IMMTYPES_SVH
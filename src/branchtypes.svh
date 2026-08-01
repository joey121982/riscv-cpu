`ifndef BRANCHTYPES_SVH
`define BRANCHTYPES_SVH

typedef enum logic [2:0] {
    BR_EQ,
    BR_NEQ,
    BR_LT,
    BR_GE,
    BR_LTU,
    BR_GEU
} br_t;

`endif // BRANCHTYPES_SVH
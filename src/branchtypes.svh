`ifndef BRANCHTYPES_SVH
`define BRANCHTYPES_SVH

typedef enum logic [2:0] {
    BR_EQ  = 3'b000,
    BR_NEQ = 3'b001,
    BR_LT  = 3'b100,
    BR_GE  = 3'b101,
    BR_LTU = 3'b110,
    BR_GEU = 3'b111
} br_t;

`endif // BRANCHTYPES_SVH
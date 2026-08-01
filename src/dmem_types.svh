`ifndef DMEM_TYPES_SVH
`define DMEM_TYPES_SVH

typedef enum logic [2:0] {
    MEM_SIZE_B  = 3'b000,
    MEM_SIZE_H  = 3'b001,
    MEM_SIZE_W  = 3'b010,
    MEM_SIZE_BU = 3'b100,
    MEM_SIZE_HU = 3'b101
} mem_size_t;

`endif // DMEM_TYPES_SVH
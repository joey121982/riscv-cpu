`include "cu_types.svh"
`include "alu_opcodes.svh"
`include "imm_types.svh"
`include "branchtypes.svh"

module top (
    input logic clk,
    input logic rst
);
    
// Instruction Fetch
logic [31:0] pc_reg;
logic [31:0] pc_next;
logic [31:0] pc_plus_4;
logic [31:0] pc_target;
logic [31:0] instr;

// Instruction Decode
logic [4:0]  rs1;
logic [4:0]  rs2;
logic [4:0]  rd;
pc_opcode_t  opcode;
funct3_t     funct3;
funct7_t     funct7;

// Control Unit
pc_src_t           pc_src;
result_src_t       result_src;
logic              mem_we;
alu_opcode_t       alu_op;
alu_src_t          alu_src;
alu_src_operand1_t alu_src_operand1;
imm_t              imm_type;
logic              reg_we;
logic              bce_eval; 

// Datapath
logic [31:0] rf_data1;
logic [31:0] rf_data2;
logic [31:0] result;
logic [31:0] imm_ext;
logic [31:0] alu_in_a;
logic [31:0] alu_in_b;
logic [31:0] alu_result;
logic [31:0] dmem_rdata;

// PC Register
always_ff @(posedge clk or posedge rst) begin
    if (rst) pc_reg <= 32'b0;
    else     pc_reg <= pc_next;
end

// PC Adders
assign pc_plus_4 = pc_reg + 4;
assign pc_target = pc_reg + imm_ext;

// Next PC Multiplexer
always_comb begin
    case (pc_src)
        PC_NORMAL: pc_next = pc_plus_4;
        PC_TARGET: pc_next = pc_target;
        PC_ALU:    pc_next = alu_result;
        default:   pc_next = pc_plus_4;
    endcase
end

// Instruction Memory
imem my_imem (
    .pc(pc_reg),
    .instr(instr)
);

// Slice the 32-bit instruction into components
assign opcode = pc_opcode_t'(instr[6:0]);
assign rd     = instr[11:7];
assign funct3 = funct3_t'(instr[14:12]);
assign rs1    = instr[19:15];
assign rs2    = instr[24:20];
assign funct7 = funct7_t'(instr[31:25]);

// Control Unit
cu my_cu (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .bce_eval(bce_eval),

    .pc_src(pc_src),
    .result_src(result_src),
    .mem_we(mem_we),
    .alu_op(alu_op),
    .alu_src(alu_src),
    .alu_src_operand1(alu_src_operand1),
    .imm_type(imm_type),
    .reg_we(reg_we)
);

// Register File
regfile my_regfile (
    .clk(clk),
    .we(reg_we),
    .r_addr1(rs1),
    .r_addr2(rs2),
    .w_addr(rd),
    .w_data(result),

    .r_data1(rf_data1),
    .r_data2(rf_data2)
);

// Immediate Generator
immgen my_imm_gen (
    .inst(instr),
    .imm_type(imm_type),

    .result(imm_ext)
);

// Branch Condition Evaluator
bce my_bce (
    .rs1(rf_data1),
    .rs2(rf_data2),
    .br_type(br_t'(funct3)),

    .result(bce_eval)
);

// ALU Input Multiplexers
assign alu_in_a = (alu_src_operand1 == ALU_SRC_PC) ? pc_reg  : rf_data1;
assign alu_in_b = (alu_src == ALU_SRC_IMM)         ? imm_ext : rf_data2;

// ALU
alu my_alu (
    .loperand(alu_in_a),
    .roperand(alu_in_b),
    .opcode(alu_op),

    .result(alu_result)
);

// Data Memory
dmem my_dmem (
    .clk(clk),
    .we(mem_we),
    .addr(alu_result),
    .w_data(rf_data2),
    
    .r_data(dmem_rdata)
);

// Writeback Multiplexer (result_src)
always_comb begin
    case (result_src)
        RES_ALU: result = alu_result;
        RES_MEM: result = dmem_rdata;
        RES_PC:  result = pc_plus_4;
        RES_IMM: result = imm_ext;
        default: result = 32'b0;
    endcase
end

endmodule
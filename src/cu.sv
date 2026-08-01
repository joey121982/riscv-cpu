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

always_comb begin
    /* Default Values */
    pc_src     = PC_NORMAL;
    result_src = RES_ALU;
    mem_we     = 1'b0;
    reg_we     = 1'b0;
    alu_src    = ALU_SRC_REG;
    imm_type   = IMM_I;
    alu_op     = ALU_ADD;

    case (opcode)
        OP_LOAD: begin
            imm_type    = IMM_I;
            alu_src     = ALU_SRC_IMM;
            alu_op      = ALU_ADD;
            result_src  = RES_MEM;
            reg_we      = 1'b1;
        end

        OP_IMM: begin
            imm_type    = IMM_I;
            alu_src     = ALU_SRC_IMM;
            result_src  = RES_ALU;
            reg_we      = 1'b1;

            case (funct3)
                F3_ADD_SUB: alu_op = ALU_ADD;
                F3_SLL:     alu_op = ALU_SLL;
                F3_SLT:     alu_op = ALU_SLT;
                F3_SLTU:    alu_op = ALU_SLTU;
                F3_XOR:     alu_op = ALU_XOR;
                F3_OR:      alu_op = ALU_OR;
                F3_AND:     alu_op = ALU_AND;
                F3_SRL_SRA: begin
                    case (funct7)
                        F7_ADD_SRL: alu_op = ALU_SRL;
                        F7_SUB_SRA: alu_op = ALU_SRA;
                    endcase
                end
            endcase
        end

        OP_AUIPC: begin

        end
        
        OP_STORE: begin
            imm_type    = IMM_S;
            alu_src     = ALU_SRC_IMM;
            alu_op      = ALU_ADD;
            mem_we      = 1'b1;
        end
        
        OP_OP: begin
            imm_type    = IMM_R;
            alu_src     = ALU_SRC_REG;
            result_src  = RES_ALU;
            reg_we      = 1'b1;

            case (funct3)
                F3_ADD_SUB: begin
                    case (funct7)
                        F7_ADD_SRL: alu_op = ALU_ADD;
                        F7_SUB_SRA: alu_op = ALU_SUB;
                    endcase
                end
                F3_SLL:     alu_op = ALU_SLL;
                F3_SLT:     alu_op = ALU_SLT;
                F3_SLTU:    alu_op = ALU_SLTU;
                F3_XOR:     alu_op = ALU_XOR;
                F3_OR:      alu_op = ALU_OR;
                F3_AND:     alu_op = ALU_AND;
                F3_SRL_SRA: begin
                    case (funct7)
                        F7_ADD_SRL: alu_op = ALU_SRL;
                        F7_SUB_SRA: alu_op = ALU_SRA;
                    endcase
                end
            endcase
        end
        
        OP_LUI: begin

        end
        
        OP_BRANCH: begin

        end
        
        OP_JALR: begin

        end
        
        OP_JAL: begin

        end
        
        OP_SYSTEM: begin
            // NOT SUPPORTED
        end

        default:    
    endcase
end

endmodule
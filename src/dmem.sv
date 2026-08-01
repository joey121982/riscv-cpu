`include "dmem_types.svh"

module dmem (
    input   logic           clk,
    input   logic           we,
    input   mem_size_t      mem_size,   // ADDED: Control signal from CU

    input   logic   [31:0]  addr,
    input   logic   [31:0]  w_data,

    output  logic   [31:0]  r_data
);

logic   [31:0]  memory  [0:8191];

always_ff @(posedge clk) begin
    if (we) begin
        case (mem_size)
            MEM_SIZE_B: begin
                case (addr[1:0])
                    2'b00: memory[addr[14:2]][7:0]   <= w_data[7:0];
                    2'b01: memory[addr[14:2]][15:8]  <= w_data[7:0];
                    2'b10: memory[addr[14:2]][23:16] <= w_data[7:0];
                    2'b11: memory[addr[14:2]][31:24] <= w_data[7:0];
                endcase
            end
            
            MEM_SIZE_H: begin
                case (addr[1])
                    1'b0: memory[addr[14:2]][15:0]  <= w_data[15:0];
                    1'b1: memory[addr[14:2]][31:16] <= w_data[15:0];
                endcase
            end
            
            MEM_SIZE_W: begin
                memory[addr[14:2]] <= w_data;
            end
            
            default: ; 
        endcase
    end
end

logic [31:0] raw_word;
assign raw_word = memory[addr[14:2]];

always_comb begin
    r_data = raw_word; 

    case (mem_size)
        MEM_SIZE_B: begin
            case (addr[1:0])
                2'b00: r_data = {{24{raw_word[7]}},  raw_word[7:0]};
                2'b01: r_data = {{24{raw_word[15]}}, raw_word[15:8]};
                2'b10: r_data = {{24{raw_word[23]}}, raw_word[23:16]};
                2'b11: r_data = {{24{raw_word[31]}}, raw_word[31:24]};
            endcase
        end

        MEM_SIZE_H: begin
            case (addr[1])
                1'b0: r_data = {{16{raw_word[15]}}, raw_word[15:0]};
                1'b1: r_data = {{16{raw_word[31]}}, raw_word[31:16]};
            endcase
        end

        MEM_SIZE_W: begin
            r_data = raw_word;
        end

        MEM_SIZE_BU: begin
            case (addr[1:0])
                2'b00: r_data = {24'b0, raw_word[7:0]};
                2'b01: r_data = {24'b0, raw_word[15:8]};
                2'b10: r_data = {24'b0, raw_word[23:16]};
                2'b11: r_data = {24'b0, raw_word[31:24]};
            endcase
        end

        MEM_SIZE_HU: begin
            case (addr[1])
                1'b0: r_data = {16'b0, raw_word[15:0]};
                1'b1: r_data = {16'b0, raw_word[31:16]};
            endcase
        end

        default: r_data = raw_word;
    endcase
end

endmodule
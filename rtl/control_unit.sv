`include "def.sv"

/* verilator lint_off UNUSED */

module control_unit #(
    parameter DATA_WIDTH = 32
) (
   input logic [DATA_WIDTH-1:0] instr,
   input logic stall,
   output logic [3:0] ALUctrl,
   output logic ALUsrc,
   output logic [2:0] ImmSrc,
   output logic [2:0] PCsrc,
   output logic RegWrite,
   output logic MemWrite,
   output logic MemRead,
   output logic addr_mode, // Added for store and load byte instead of word of 4 bytes
   output logic [1:0] ResultSrc
);

logic [6:0] op;
logic [2:0] funct3;
logic [6:0] funct7;

assign op = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];


always_comb begin
    // Setting all the default control signals values
    ALUctrl = `ALU_OPCODE_ADD;
    ALUsrc = 1'b0;
    ImmSrc = 3'b000;
    RegWrite = 0;
    MemWrite = 0;
    MemRead = 0;
    ResultSrc = 0;
    PCsrc = `PC_NEXT;
    
    case(op)

        // R type instructions
        7'b0110011: begin
            RegWrite = 1;
            ALUsrc = 0;
            case(funct3)
                
                // add and sub
                3'b000: begin
                    case(funct7)
                        
                        // add
                        7'h00: begin
                            ALUctrl = `ALU_OPCODE_ADD;
                        end
                        
                        // sub
                        7'h20: begin
                            ALUctrl = `ALU_OPCODE_SUB;
                        end
    
                        default: $display("Warning: undefined add/sub");
    
                    endcase 
                end
                
                // or
                3'b110: begin
                    ALUctrl = `ALU_OPCODE_OR;
                end
                
                // xor
                3'b100: begin
                    ALUctrl = `ALU_OPCODE_XOR;
                end

                // and
                3'b111: begin
                    ALUctrl = `ALU_OPCODE_AND;
                end
                
                // sll
                3'b001: begin
                    ALUctrl = `ALU_OPCODE_LSL;
                end

                // srl or sra
                3'b101: begin
                    case(funct7)
                        
                        // srl
                        7'h00: begin
                            ALUctrl = `ALU_OPCODE_LSR;
                        end
                        
                        // sra
                        7'h20: begin
                            ALUctrl = `ALU_OPCODE_ASR;
                        end
    
                        default: $display("Warning: undefined add/sub");
    
                    endcase
                end

                // slt
                3'b010: begin
                    ALUctrl = `ALU_OPCODE_SLT;
                end

                // sltu
                3'b011: begin
                    ALUctrl = `ALU_OPCODE_SLTU;
                end
                
                default: begin
                    ALUsrc = 0;
                    RegWrite = 0;
                    $display("R type default", op, " ", funct3);
                end
            endcase 
        end

        // I type instructions
        7'b0010011: begin
            ALUsrc = 1;
            RegWrite = 1;
            ImmSrc = `SIGN_EXTEND_I;
            case(funct3)

                // addi
                3'b000: begin
                    ALUctrl = `ALU_OPCODE_ADD;
                end
                
                // ori
                3'b110: begin
                    ALUctrl = `ALU_OPCODE_OR;
                end

                // xori
                3'b100: begin
                    ALUctrl = `ALU_OPCODE_XOR;
                end
                
                // andi
                3'b111: begin
                    ALUctrl = `ALU_OPCODE_AND;
                end

                // slli
                3'b001: begin
                    ImmSrc = `SIGN_EXTEND_I5;
                    ALUctrl = `ALU_OPCODE_LSL;
                end

                // srli or srai
                3'b101: begin
                    ImmSrc = `SIGN_EXTEND_I5;
                    case(funct7)
                        
                        // srli
                        7'h00: begin
                            ALUctrl = `ALU_OPCODE_LSR;
                        end
                        
                        // srai
                        7'h20: begin
                            ALUctrl = `ALU_OPCODE_ASR;
                        end
    
                        default: $display("Warning: undefined add/sub");
    
                    endcase
                end

                // slti
                3'b010: begin
                    ALUctrl = `ALU_OPCODE_SLT;
                end

                // sltiu
                3'b011: begin
                    ALUctrl = `ALU_OPCODE_SLTU;
                end

                default: begin
                    ALUctrl = 4'b0000;
                    $display("I type default", op, " ", funct3);
                end
            endcase
        end

        // Load type instructions
        7'b0000011: begin
            ResultSrc = 1;
            MemRead = 1;
            ALUctrl = `ALU_OPCODE_ADD;
            ImmSrc = `SIGN_EXTEND_I;
            ALUsrc = 1;
            RegWrite = 1;
            case(funct3)
                
                // lb
                3'b000: begin
                    addr_mode = 1;
                end

                // lw
                3'b010: begin
                    addr_mode = 0;
                end

                // lbu
                3'b100: begin
                    addr_mode= 1;
                end

                default: begin
                    ALUsrc = 1;
                    RegWrite = 1;
                    $display("L type default", op, " ", funct3);
                end
            endcase
            
        end

        // S type instructions
        7'b0100011: begin
            ALUsrc = 1;
            ALUctrl = `ALU_OPCODE_ADD;
            ImmSrc = `SIGN_EXTEND_S;
            RegWrite = 0;
            MemWrite = 1;
            case(funct3)
            
            // sb
            3'b000: begin
                addr_mode = 1;
            end

            // sw
            3'b010: begin
                addr_mode = 0;
            end
            
            default: begin
                RegWrite = 0;
                MemWrite = 1;
                $display("S type default", op, " ", funct3);
            end
            endcase
        end
        
        // B type instructions
        7'b1100011: begin
            RegWrite = 0;
            ALUsrc = 0;
            ImmSrc = `SIGN_EXTEND_B;

            case(funct3)
            
            // beq
            3'b000: begin
                PCsrc = `PC_COND_BRANCH;
                ALUctrl = `ALU_OPCODE_SUB;
            end
            
            // bne
            3'b001: begin
                PCsrc = `PC_INV_COND_BRANCH;
                ALUctrl = `ALU_OPCODE_SUB;
            end

            // blt
            3'b100: begin
                PCsrc = `PC_INV_COND_BRANCH;
                ALUctrl = `ALU_OPCODE_SLT;
            end

            // bge
            3'b101: begin
                PCsrc = `PC_COND_BRANCH;
                ALUctrl = `ALU_OPCODE_SLT;
            end

            // bltu
            3'b110: begin
                PCsrc = `PC_INV_COND_BRANCH;
                ALUctrl = `ALU_OPCODE_SLTU;
            end

            // bgeu
            3'b111: begin
                PCsrc = `PC_COND_BRANCH;
                ALUctrl = `ALU_OPCODE_SLTU;
            end

            default: begin
                PCsrc = `PC_COND_BRANCH;
                RegWrite = 0;
                ALUctrl = `ALU_OPCODE_SUB;
                $display("B type default", op, " ", funct3);
            end
            endcase
        end

        // J type instructions
        7'b1101111: begin
            // jal
            PCsrc = `PC_ALWAYS_BRANCH;
            ImmSrc = `SIGN_EXTEND_J;
            ALUsrc = 1;
            RegWrite = 1;
            ResultSrc = 2;
        end

        // I type instruction
        7'b1100111: begin 
            // jalr
            PCsrc = `PC_JALR;
            RegWrite = 1;
            ImmSrc = `SIGN_EXTEND_I;
            ALUsrc = 1;
            ResultSrc = 2;
        end

        // U type instructions
        7'b0110111: begin
            // lui
            ALUsrc = 1;
            RegWrite = 1;
            ALUctrl = `ALU_OPCODE_B;
            ImmSrc = `SIGN_EXTEND_U;
        end

        7'b0010111: begin
            //auipc
            ALUsrc = 1;
            RegWrite = 1;
        end

        // Environment type instructions
        7'b1110011: begin
            RegWrite = 1;
            case(instr[7])

            // ecall
            1'b0: begin
                ALUsrc = 1;
                $display("ecall", op, " ", funct3);
            end 

            // ebreak
            1'b1: begin
                ALUsrc = 1;
                $display("ebreak", op, " ", funct3);
            end
            endcase
        end

        //Other instructions
        default: begin
            RegWrite = 0;
            ImmSrc = `SIGN_EXTEND_I;
            ALUsrc = 0;
            ALUctrl = `ALU_OPCODE_ADD;
            MemWrite = 0;
            MemRead = 0;
        end
    endcase
    
    // Taken outside for nesting reasons.
    // Will overwrite any signal in case-endcase block
    if (stall) begin
        MemWrite = 0;
        RegWrite = 0;
    end
end

endmodule
// Control Unit is not clocked and decodes the instruction to provide control signals to various modules

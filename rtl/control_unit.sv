`include "def.sv"

module control_unit #(
    parameter DATA_WIDTH = 32
) (
   input logic [DATA_WIDTH-1:0] instr,
   input logic EQ,
   output logic [3:0] ALUctrl,
   output logic ALUsrc,
   output logic [2:0] ImmSrc,
   output logic PCsrc,
   output logic RegWrite,
   output logic MemWrite,
   output logic [1:0] ResultSrc
);

logic [6:0] op;
logic [2:0] funct3;
logic [6:0] funct7;
logic [1:0] ALUop; // Not used for now but might need later on

assign op = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];

// Setting all the default control signals values
assign RegWrite = 1'b0;
assign ALUctrl = `ALU_OPCODE_ADD;
assign ALUsrc = 1'b0;
assign ImmSrc = 3'b000;
assign PCsrc = 1'b0;
assign MemWrite = 1'b0;
assign ResultSrc = 2'b00;

always_comb begin
    MemWrite = 0;
    ResultSrc = 0;
    case(op)

        // R type instructions
        7'b0110011: begin
            PCsrc = 0;
            RegWrite = 1;
            ALUsrc = 0;
            case(funct3)
                
                // add and sub
                3'b000: begin
                    case(funct7)
                        
                        // add
                        7'h00: begin
                            ALUctrl = `ALU_OPCODE_ADD;
                            $display("add", op, " ", funct3);
                        end
                        
                        // sub
                        7'h20: begin
                            ALUctrl = `ALU_OPCODE_SUB;
                            $display("sub", op, " ", funct3);
                        end
    
                        default: $display("Warning: undefined add/sub");
    
                    endcase 
                end
                
                // or
                3'b110: begin
                    ALUctrl = `ALU_OPCODE_OR;
                    $display("or", op, " ", funct3);
                end
                
                // xor
                3'b100: begin
                    ALUctrl = `ALU_OPCODE_XOR;
                    $display("xor", op, " ", funct3);
                end

                // and
                3'b111: begin
                    ALUctrl = `ALU_OPCODE_AND;
                    $display("and", op, " ", funct3);
                end
                
                // sll
                3'b001: begin
                    ALUctrl = `ALU_OPCODE_LSL;
                    $display("sll", op, " ", funct3);
                end

                // srl or sra
                3'b101: begin
                    case(funct7)
                        
                        // srl
                        7'h00: begin
                            ALUctrl = `ALU_OPCODE_LSR;
                            $display("srl", op, " ", funct3);
                        end
                        
                        // sra
                        7'h20: begin
                            ALUctrl = `ALU_OPCODE_ASR;
                            $display("sra", op, " ", funct3);
                        end
    
                        default: $display("Warning: undefined add/sub");
    
                    endcase
                end

                // slt
                3'b010: begin
                    ALUctrl = `ALU_OPCODE_SLT;
                    $display("slt", op, " ", funct3);
                end

                // sltu
                3'b011: begin
                    ALUctrl = `ALU_OPCODE_SLTU;
                    $display("sltu", op, " ", funct3);
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
            PCsrc = 0;
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
                    $display("ori", op, " ", funct3);
                end

                // xori
                3'b100: begin
                    ALUctrl = `ALU_OPCODE_XOR;
                    $display("xori", op, " ", funct3);
                end
                
                // andi
                3'b111: begin
                    ALUctrl = `ALU_OPCODE_AND;
                    $display("andi", op, " ", funct3);
                end

                // slli
                3'b001: begin
                    ImmSrc = `SIGN_EXTEND_I5;
                    ALUctrl = `ALU_OPCODE_LSL;
                    $display("slli", op, " ", funct3);
                end

                // srli or srai
                3'b101: begin
                    ImmSrc = `SIGN_EXTEND_I5;
                    case(funct7)
                        
                        // srli
                        7'h00: begin
                            ALUctrl = `ALU_OPCODE_LSR;
                            $display("srli", op, " ", funct3);  
                        end
                        
                        // srai
                        7'h20: begin
                            ALUctrl = `ALU_OPCODE_ASR;
                            // Need to take imm[0:4]
                            $display("srai", op, " ", funct3);  
                        end
    
                        default: $display("Warning: undefined add/sub");
    
                    endcase
                end

                // slti
                3'b010: begin
                    ALUctrl = `ALU_OPCODE_SLT;
                    $display("slti", op, " ", funct3);
                end

                // sltiu
                3'b011: begin
                    ALUctrl = `ALU_OPCODE_SLTU;
                    $display("slti", op, " ", funct3);
                end

                default: begin
                    ALUctrl = 4'b0000;
                    $display("I type default", op, " ", funct3);
                end
            endcase
        end

        // Load type instructions
        7'b0000011: begin
            PCsrc = 0;
            ResultSrc = 1;
            ALUctrl = `ALU_OPCODE_ADD;
            ImmSrc = `SIGN_EXTEND_I;
            case(funct3)
                
                // lw
                3'b010: begin
                    ALUsrc = 1;
                    RegWrite = 1;
                    $display("lw", op, " ", funct3);
                end

                default: begin
                    ALUsrc = 1;
                    RegWrite = 1; //might be 0, no 100% sure
                    $display("L type default", op, " ", funct3);
                end
            endcase
            
        end

        // S type instructions
        7'b0100011: begin
            PCsrc = 0;
            ALUsrc = 1;
            ALUctrl = `ALU_OPCODE_ADD;
            ImmSrc = `SIGN_EXTEND_S;
            case(funct3)
            
            // sw
            3'b010: begin 
                RegWrite = 0;
                MemWrite = 1;
                $display("sw", op, " ", funct3);
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
                PCsrc = EQ ? 1 : 0;
                ALUctrl = `ALU_OPCODE_SUB;
                $display("beq", op, " ", funct3);
            end
            
            // bne
            3'b001: begin
                PCsrc = EQ ? 0 : 1;
                ALUctrl = `ALU_OPCODE_SUB;
                $display("bne", op, " ", funct3);
            end

            // blt
            3'b100: begin
                PCsrc = EQ ? 0 : 1;
                ALUctrl = 4'b0111;
                $display("blt", op, " ", funct3);
            end

            // bge
            3'b101: begin
                PCsrc = EQ ? 1 : 0;
                ALUctrl = 4'b0111;
                $display("bge", op, " ", funct3);
            end

            // bltu
            3'b110: begin
                PCsrc = !EQ ? 1 : 0;
                ALUctrl = 4'b0111;
                $display("bltu", op, " ", funct3);
            end

            // bgeu
            3'b111: begin
                PCsrc = !EQ ? 0 : 1;
                ALUctrl = 4'b0111;
                $display("bgeu", op, " ", funct3);
            end

            default: begin
                PCsrc = 0;
                RegWrite = 0;
                ALUctrl = `ALU_OPCODE_SUB;
                $display("B type default", op, " ", funct3);
            end
            endcase
        end

        // J type instructions
        7'b1101111: begin
            // jal
            PCsrc = 1;
            ImmSrc = `SIGN_EXTEND_J;
            ALUsrc = 1;
            RegWrite = 1;
            ResultSrc = 2;
            $display("jal", op, " ", funct3);
        end

        // I type instruction
        7'b1100111: begin 
            // jalr
            PCsrc = 0;
            RegWrite = 1;
            ALUsrc = 1;
            ResultSrc = 2;
            $display("jalr", op, " ", funct3);
        end

        // U type instructions
        7'b0110111: begin
            // lui
            PCsrc = 0;
            ALUsrc = 1;
            RegWrite = 1;
            ALUctrl = `ALU_OPCODE_B;
            ImmSrc = `SIGN_EXTEND_U;
            $display("lui", op, " ", funct3);
        end

        7'b0010111: begin
            //auipc
            PCsrc = 0;
            ALUsrc = 1;
            RegWrite = 1;
            $display("auipc", op, " ", funct3);
        end

        // Environment type instructions
        7'b1110011: begin
            PCsrc = 0;
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
            PCsrc = 0;
            RegWrite = 0;
            ImmSrc = `SIGN_EXTEND_I;
            ALUsrc = 0;
            ALUctrl = `ALU_OPCODE_ADD;
            MemWrite = 0;
        end
    endcase
end

endmodule
// Control Unit is not clocked and decodes the instruction to provide control signals to various modules

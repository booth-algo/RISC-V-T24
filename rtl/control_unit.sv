module control_unit #(
    parameter DATA_WIDTH = 32
) (
   input logic [DATA_WIDTH-1:0] instr,
   input logic EQ,
   output logic [3:0] ALUctrl,
   output logic ALUsrc,
   output logic [1:0] ImmSrc,
   output logic PCsrc,
   output logic RegWrite,
   output logic MemWrite,
   output logic ResultSrc
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
assign ALUctrl = 4'b000;
assign ALUsrc = 1'b0;
assign ImmSrc = 2'b000;
assign PCsrc = 1'b0;
assign MemWrite = 1'b0;
assign ResultSrc = 1'b0;

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
                            ALUctrl = 4'b0000;
                            $display("add", op, " ", funct3);
                        end
                        
                        // sub
                        7'h20: begin
                            ALUctrl = 4'b0001;
                            $display("sub", op, " ", funct3);
                        end
    
                        default: $display("Warning: undefined add/sub");
    
                    endcase 
                end
                
                // or
                3'b110: begin
                    ALUctrl = 4'b0011;
                    $display("or", op, " ", funct3);
                end
                
                // xor
                3'b100: begin
                    ALUctrl = 4'b0100;
                    $display("xor", op, " ", funct3);
                end

                // and
                3'b111: begin
                    ALUctrl = 4'b0010;
                    $display("and", op, " ", funct3);
                end
                
                // slt
                3'b010: begin
                    ALUctrl = 4'b0111;
                    $display("slt", op, " ", funct3);
                end

                // sltu
                3'b011: begin
                    ALUctrl = 4'b0111;
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
            case(funct3)

                // addi
                3'b000: begin
                    ALUctrl = 4'b0000;
                    ImmSrc = 2'b00;
                end
                
                // ori
                3'b110: begin
                    ALUctrl = 4'b0011;
                    ImmSrc = 2'b00;
                    $display("ori", op, " ", funct3);
                end

                // xori
                3'b100: begin
                    ALUctrl = 4'b0100;
                    ImmSrc = 2'b00;
                    $display("xori", op, " ", funct3);
                end
                
                // andi
                3'b111: begin
                    ALUctrl = 4'b0010;
                    ImmSrc = 2'b00;
                    $display("andi", op, " ", funct3);
                end

                // slli
                3'b001: begin
                    ALUctrl = 4'b0010;
                    ImmSrc = 2'b00;
                    $display("andi", op, " ", funct3);
                end
                
                // slti
                3'b010: begin
                    ALUctrl = 4'b0101;
                    ImmSrc = 2'b00;
                    $display("slti", op, " ", funct3);
                end

                // sltiu
                3'b011: begin
                    ALUctrl = 4'b0101;
                    ImmSrc = 2'b00;
                    $display("sltiu", op, " ", funct3);
                end 

                default: begin
                    ALUctrl = 4'b0000;
                    ImmSrc = 2'b00;
                    $display("I type default", op, " ", funct3);
                end
            endcase
        end

        // Load type instructions
        7'b0000011: begin
            PCsrc = 0;
            ResultSrc = 1;
            ALUctrl = 0;
            case(funct3)
                
                // lw
                3'b010: begin
                    ALUsrc = 1;
                    RegWrite = 1;
                    ImmSrc = 2'b00;
                    $display("lw", op, " ", funct3);
                end

                default: begin
                    ALUsrc = 1;
                    RegWrite = 1; //might be 0, no 100% sure
                    ImmSrc = 2'b00;
                    $display("L type default", op, " ", funct3);
                end
            endcase
            
        end

        // S type instructions
        7'b0100011: begin
            PCsrc = 0;
            ALUsrc = 1;
            ALUctrl = 0;
            case(funct3)
            
            // sw
            3'b010: begin 
                RegWrite = 0;
                ImmSrc = 2'b01;
                MemWrite = 1;
                $display("sw", op, " ", funct3);
            end
            
            default: begin
                RegWrite = 0;
                ImmSrc = 2'b01;
                MemWrite = 1;
                $display("S type default", op, " ", funct3);
            end
            endcase
        end
        
        // B type instructions
        7'b1100011: begin
            RegWrite = 0;
            ALUsrc = 0;
            case(funct3)
            
            // beq
            3'b000: begin
                ImmSrc = 2'b10;
                PCsrc = EQ ? 1 : 0;
                ALUctrl = 4'b0001;
                $display("beq", op, " ", funct3);
            end
            
            // bne
            3'b001: begin
                ImmSrc = 2'b10;
                PCsrc = EQ ? 0 : 1;
                ALUctrl = 4'b0001;
            end
            
            default: begin
                PCsrc = 0;
                RegWrite = 0;
                ImmSrc = 2'b10;
                ALUctrl = 4'b0001;
                $display("B type default", op, " ", funct3);
            end
            endcase
        end

        // J type instructions
        7'b1101111: begin
            //jal
            PCsrc = 0;
            ALUsrc = 1;
            RegWrite = 1;
            $display("jal", op, " ", funct3);
        end

        // I type instruction
        7'b1100111: begin 
            PCsrc = 0;
            RegWrite = 1;
            ALUsrc = 1;
            $display("jalr", op, " ", funct3);
        end

        // U type instructions
        7'b0110111: begin
            // lui
            PCsrc = 0;
            ALUsrc = 1;
            RegWrite = 1;
            ALUctrl = 4'b1000;
            ImmSrc = 2'b11;
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
            ImmSrc = 2'b00;
            ALUsrc = 0;
            ALUctrl = 4'b0000;
            MemWrite = 0;
        end
    endcase
end

endmodule
// Control Unit is not clocked and decodes the instruction to provide control signals to various modules

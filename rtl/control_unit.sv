module control_unit #(
    parameter DATA_WIDTH = 32
) (
   input logic [DATA_WIDTH-1:0] instr,
   input logic EQ,
   output logic [2:0] ALUctrl,
   output logic ALUsrc,
   output logic [1:0] ImmSrc,
   output logic PCsrc,
   output logic RegWrite,
   output logic MemWrite,
   output logic jump,
   // Maybe add ResultSrc later if needed
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
assign ALUctrl = 3'b000;
assign ALUsrc = 1'b0;
assign ImmSrc = 2'b000;
assign MemWrite = 1'b0;
assign jump = 1'b0;
assign PCsrc = 0;


always_comb begin
    case(op)

        // R type instructions
        7'b0110011: begin
            case(funct3)
                
                // add and sub
                3'b000: begin
                    case(funct7)
                        
                        // add
                        6'b000000: begin
                            ALUctrl = 3'b000;
                            RegWrite = 1;
                            $display("add", op, " ", funct3);
                        end
                        
                        // sub
                        6'b000010: begin
                            ALUctrl = 3'b001;
                            RegWrite = 1;
                            $display("sub", op, " ", funct3);
                        end
                    endcase 
                end
                
                // or
                3'b110: begin
                    ALUctrl = 3'b011;
                    RegWrite = 1;
                    $display("or", op, " ", funct3);
                end
                
                // and
                3'b111: begin
                    ALUctrl = 3'b010;
                    RegWrite = 1;
                    $display("and", op, " ", funct3);
                end
                
                // slt
                3'b010: begin
                    ALUctrl = 3'b101;
                    RegWrite = 1;
                    $display("slt", op, " ", funct3);
                end
                
                default: begin
                    ALUsrc = 0;
                    RegWrite = 1;
                    $display("R type default", op, " ", funct3);
                end
            endcase
        end

        // I type instructions
        7'b0010011: begin 
            case(funct3)
                
                // addi
                3'b000: begin
                    ALUsrc = 1;
                    ALUctrl = 3'b000;
                    RegWrite = 1;
                    ImmSrc = 2'b00;
                    $display("addi", op, " ", funct3);                    
                end
                
                // ori
                3'b110: begin
                    ALUsrc = 1;
                    ALUctrl = 0'b011;
                    RegWrite = 1;
                    ImmSrc = 2'b00;
                    $display("ori", op, " ", funct3);
                end
                
                // andi
                3'b111: begin
                    ALUsrc = 1;
                    ALUctrl = 0'b010;
                    RegWrite = 1;
                    ImmSrc = 2'b00;
                    $display("andi", op, " ", funct3);
                end
                
                // slti
                3'b010: begin
                    ALUsrc = 1;
                    ALUctrl = 0'b101;
                    RegWrite = 1;
                    ImmSrc = 2'b00;
                    $display("slti", op, " ", funct3);
                end

                default: begin
                    ALUsrc = 1;
                    ALUctrl = 3'b000;
                    RegWrite = 0;
                    ImmSrc = 2'b00;
                    $display("I type default", op, " ", funct3);                    

                end
            endcase
        end

        // Load type instructions
        7'b0000011: begin
            case(funct3)
                
                // lw
                3'b010: begin
                    ALUsrc = 0;
                    ALUctrl = 1;
                    RegWrite = 0;
                    $display("lw", op, " ", funct3);
                end

                default: begin
                    ALUsrc = 1;
                    RegWrite = 0;
                    $display("L type default", op, " ", funct3);
                end
            endcase
        end

        // S type instructions
        7'b0100011: begin
            case(funct3)
            
            // sw
            3'b010: begin 
                RegWrite = 0;
                ImmSrc = 2'b01;
                $display("sw", op, " ", funct3);
            end
            
            default: begin
                RegWrite = 0;
                ImmSrc = 2'b01;
                $display("S type default", op, " ", funct3);
            end
            endcase
        end
        
        // B type instructions
        7'b1100011: begin
            case(funct3)
            
            // beq
            3'b000: begin
                ImmSrc = 2'b10;
                PCsrc = 1;
                $display("beq", op, " ", funct3);
            end
            
            // bne
            3'b001: begin
                ImmSrc = 2'b10;
                PCsrc = 1;
                $display("bne", op, " ", funct3);
            end
            
            default: begin
                ALUsrc = 0;
                PCsrc = 1;
                RegWrite = 0;
                ImmSrc = 2'b10;
                $display("B type default", op, " ", funct3);
            end
            endcase
        end

        // J type instructions
        7'b1101111: begin
            //jal
            ALUsrc = 1;
            RegWrite = 1;
            jump = 1'b1;
            $display("jal", op, " ", funct3);
        end

        // U type instructions
        7'b0110111: begin
            // lui
            ALUsrc = 1;
            RegWrite = 1;
            $display("lui", op, " ", funct3);
        end

        // Environment type instructions
        7'b1110011: begin
            // ecall
            ALUsrc = 1;
            $display("ecall", op, " ", funct3);
        end

        //Other instructions
        default: begin
            RegWrite = 1'b0;
            ImmSrc = 3'b000;
            ALUsrc = 1'b0;
            ALUctrl = 3'b000;
            MemWrite = 1'b0;
            jump = 1'b0;
            $display("General default", op, " ", funct3);
        end
    endcase
end

endmodule
// Control Unit is not clocked and decodes the instruction to provide control signals to various modules

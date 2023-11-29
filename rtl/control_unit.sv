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

   output logic mem_read, //
   output logic mem_write,
   output logic [1:0] alu_op, //
   output logic branch, //
   output logic jump,
   output logic reg_dst, //result source potentially ?
   output logic [1:0] mem_to_reg
);

logic [6:0] op;
logic [2:0] funct3;
logic [6:0] funct7;

assign op = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];

// Setting all the default control signals values
assign RegWrite = 1'b0;
assign mem_read = 1'b0;
assign mem_write = 1'b0;
assign ALUctrl = 3'b000;
assign branch = 1'b0;
assign jump = 1'b0;
assign ALUsrc = 1'b0;
assign reg_dst = 1'b0;
assign mem_to_reg = 2'b00;

// U: lui 0110111, auipc 0010111
// J: jal 1101111

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
                            jbe
                        end
                        // sub
                        6'b000010: begin
                            fj
                        end
                    endcase 
                end
                // or
                3'b110: begin
                    nien
                end
                // and
                3'b111: begin
                    bvrb
                end
                // slt
                3'b010: begin
                    ckej
                end
                default: begin
                    reg_write = 1'b1;
                    alu_op = 2'b10;
                    reg_dst = 1'b1;
                end
            endcase
        end

        // I type instructions
        7'b0010011: begin 
            case(funct3)
                // addi
                3'b000: begin        
                    PCsrc = 0;
                    ImmSrc = 2'b00;
                    ALUsrc = 1;
                    ALUctrl = 0;
                    RegWrite = 1;
                    $display("addi", op, " ", funct3);                    
                end
                // ori
                3'b110: begin
                    infnr
                end
                // andi
                3'b111: begin
                    fin
                end
                // slti
                3'b010: begin
                    jrn
                end

                default: begin
                    PCsrc = 0;
                    ImmSrc = 2'b00;
                    ALUsrc = 1;
                    ALUctrl = 0;
                    RegWrite = 0;
                    $display("addi def", op, " ", funct3);                    

                end
            endcase
        end

        // Load type instructions
        7'b0000011: begin
            case(funct3)
                // lw
                3'b010: begin
                    PCsrc = 1;
                    ImmSrc = 2'b10;
                    ALUsrc = 0;
                    ALUctrl = 1;
                    RegWrite = 0;
                    $display("bne", op, " ", funct3);
                end

                default: begin
                    reg_write = 1'b1;
                    mem_read = 1'b1;
                    alu_op = 2'b00;
                    alu_src = 2'b01;
                    mem_to_reg = 2'b10;
                end
            endcase
        end

        // S type instructions
        7'b0100011: begin
            case(funct3)
            // sw
            3'b010: begin 
                rfni
            end
            default: begin 
                mem_write = 1'b1;
                alu_op = 2'b00;
                alu_src = 2'b01;
            end
            endcase
        end
        
        // B type instructions
        7'b1100011: begin
            case(funct3)
            // beq
            3'b000: begin
                nien
            end
            // bne
            3'b001: begin
                bu
            end
            default: begin
                branch = 1'b1;
                alu_op = 2'b01;
            end
            endcase
        end

        // J type instructions
        7'b1101111: begin
            //jal
            jump = 1'b1;
        end

        // U type instructions
        7'b0110111: begin
            // lui
            enj
        end

        // Environment type instructions
        7'b1110011: begin
            // ecall
            memfr
        end

        //Other instructions
        default: begin
            RegWrite = 0;
            ImmSrc = 2'b10;
            ALUsrc = 0;
            ALUctrl = 0;
            PCsrc = 0;

            mem_read = 1'b0;
            mem_write = 1'b0;
            alu_op = 2'b00;
            branch = 1'b0;
            jump = 1'b0;
            alu_src = 2'b00;
            reg_dst = 1'b0;
            mem_to_reg = 2'b00;
        end
    endcase
end

endmodule

// Control Unit is not clocked and decodes the instruction to provide control signals to various modules
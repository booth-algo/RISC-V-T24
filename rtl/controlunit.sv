module controlunit #(
    parameter DATA_WIDTH = 32
) (
   input logic [DATA_WIDTH-1:0] instr,
   input logic EQ,
   output logic ALUctrl,
   output logic ALUsrc,
   output logic [1:0] ImmSrc,
   output logic PCsrc,
   output logic RegWrite
);

logic [6:0] op;
logic [2:0] funct3;

always_comb begin
    op = instr[6:0];
    funct3 = instr[14:12];

    case(op)
        7'b0010011: begin
            case(funct3)
                3'b000: begin        //addi operation
                    PCsrc = 0;
                    ImmSrc = 2'b00;
                    ALUsrc = 1;
                    ALUctrl = 0;
                    RegWrite = 1;
                end

                default: begin
                    PCsrc = 0;
                    ImmSrc = 2'b00;
                    ALUsrc = 1;
                    ALUctrl = 0;
                    RegWrite = 0;
                end
            endcase
        end

        7'b1100011: begin
            case(funct3)
                3'b001: begin       //bne operation
                    PCsrc = 1;
                    ImmSrc = 2'b10;
                    ALUsrc = 0;
                    ALUctrl = 1;
                    RegWrite = 0;
                end

                default: begin
                    PCsrc = 0;
                    ImmSrc = 2'b10;
                    ALUsrc = 1;
                    ALUctrl = 0;
                    RegWrite = 0;
                end
            endcase
        end

        default: begin
            RegWrite = 0;
            ImmSrc = 2'b10;
            ALUsrc = 0;
            ALUctrl = 0;
            PCsrc = 0;
        end
    endcase
end

endmodule

// Control Unit is not clocked and decodes the instruction to provide control signals to various modules
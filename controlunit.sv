module controlunit #(
    parameter DATA_WIDTH = 32
) (
   input logic [6:0] op,
   input logic EQ, //not sure what this is for
   output logic ALUctrl, //this missing
   output logic ALUsrc, //ok
   output logic [1:0] ImmSrc, //ok
   output logic PCsrc, //this missing
   output logic RegWrite //ok
);

always_comb begin
    case(op)
        7'b0000011: begin           //lw
            RegWrite = 1;
            ImmSrc = 2'b00;
            ALUSrc = 1;
            ALUOp = 2'b00;
        end

        7'b0100011: begin           //sw
            RegWrite = 0;
            ImmSrc = 2'b01;
            ALUSrc = 1;
            ALUOp = 2'b00;
        end

        7'b0110011: begin           //R-type
            RegWrite = 1;
            //ImmSrc = 2'b00;
            ALUSrc = 0;
            ALUOp = 2'b10;
        end

        7'b1100011: begin           //beq
            RegWrite = 0;
            ImmSrc = 2'b10;
            ALUSrc = 0;
            ALUOp = 2'b01;
        end

        default: begin
            RegWrite = 0;
            ImmSrc = 2'b10;
            ALUSrc = 0;
            ALUOp = 2'b00;
        end
    endcase
end

endmodule

// Control Unit is not clocked and decodes the instruction to provide control signals to various modules
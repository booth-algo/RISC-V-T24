module controlunit #(
    parameter DATA_WIDTH = 32
) (
   input logic [DATA_WIDTH-1:0] instr,
   input logic EQ,
   output logic ALUctrl, 
   output logic ALUsrc,
   output logic ImmSrc,
   output logic PCsrc,
   output logic RegWrite //not sure about the size of this one
);
    
endmodule

// Control Unit is not clocked and decodes the instruction to provide control signals to various modules
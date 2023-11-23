module alu #( 
    parameter WIDTH = 32
)( 
    input logic [WIDTH - 1:0]   ALUop1,      // ALU input 1
    input logic                 ALUctrl,     // select signal for ALU       
    input logic [WIDTH - 1:0]   regOp2,      
    input logic [WIDTH - 1:0]   ImmOp,
    input logic                 ALUsrc,
    output logic                EQ,
    output logic [WIDTH - 1:0]  ALUout
);

logic   ALUop2[WIDTH - 1:0],      // ALU input 2

always_comb 
    ALUop2 <= ALUsrc ? ImmOp: regOp2; // if instruction is ADDI, ALUsrc = 1
    if (ALUctrl) begin
         ALUout <= ALUop1 + ALUop2;// addi
    end
    else begin
        ALUout <= ALUop1 - ALUop2;
        if (ALUout == 0'b0) EQ = 1;
        else EQ = 0; // EQ is going to define whether the status of the last operation was 0 or 1. I think this is used for bne, where if the answer to the compare is equal to 0, EQ = 1 
    end
endmodule

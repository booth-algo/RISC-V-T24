module alu #( 
    parameter WIDTH = 32
)( 
    input logic [WIDTH - 1:0]   ALUop1,      // ALU input 1
    input logic [2:0]           ALUctrl,     // select signal for ALU       
    input logic [WIDTH - 1:0]   regOp2,      
    input logic [WIDTH - 1:0]   ImmOp,
    input logic                 ALUsrc,
    output logic                EQ,
    output logic [WIDTH - 1:0]  ALUout
);

logic [WIDTH - 1:0] ALUop2;      // ALU input 2

always_comb begin
    ALUop2 = ALUsrc ? ImmOp: regOp2;       // if instruction is ADDI, ALUsrc = 1
        
    case(ALUctrl)
        3'b000:     ALUout = ALUop1 + ALUop2;
        3'b001:     ALUout = ALUop1 - ALUop2;
        3'b010:     ALUout = ALUop1 & ALUop2;
        3'b011:     ALUout = ALUop1 | ALUop2;
        3'b101:     ALUout = (ALUop1 < ALUop2) ? 1 : 0;
        default:    ALUout = 0;   
    endcase

    // EQ is going to define whether the status of the last operation was 0 or 1. 
    // I think this is used for bne, where if the answer to the compare is equal to 0, EQ = 1 
    EQ = (ALUout == 0'b0) ? 1 : 0;    
end

endmodule

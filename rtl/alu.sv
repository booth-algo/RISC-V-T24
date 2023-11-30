module alu #( 
    parameter WIDTH = 32
)( 
    input logic [WIDTH - 1:0]   a,      // ALU input 1
    input logic [WIDTH - 1:0]   b,
    input logic [2:0]           ALUctrl,     // select signal for ALU       
    output logic                EQ,
    output logic [WIDTH - 1:0]  ALUout
);

always_comb begin        
    case(ALUctrl)
        3'b000:     ALUout = a + b;
        3'b001:     ALUout = a - b;
        3'b010:     ALUout = a & b;
        3'b011:     ALUout = a | b;
        3'b101:     ALUout = (a < b) ? 1 : 0;
        default:    ALUout = 0;   
    endcase

    // EQ is going to define whether the status of the last operation was 0 or 1. 
    // I think this is used for bne, where if the answer to the compare is equal to 0, EQ = 1 
    EQ = (ALUout == 0'b0) ? 1 : 0;    
end

endmodule

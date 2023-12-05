`include "def.sv"

module alu #( 
    parameter WIDTH = 32
)( 
    input logic [WIDTH - 1:0]   a,      // ALU input 1
    input logic [WIDTH - 1:0]   b,
    input logic [3:0]           ALUctrl,     // select signal for ALU       
    output logic                EQ,
    output logic [WIDTH - 1:0]  ALUout
);

// Verilog operators < > <= >= have different behaviours for signed
wire signed [WIDTH -1:0] a_signed;
assign a_signed = a;

wire signed [WIDTH -1:0] b_signed;
assign b_signed = b;

always_comb begin

    case(ALUctrl)
        `ALU_OPCODE_ADD:        ALUout = a + b;
        `ALU_OPCODE_SUB:        ALUout = a - b;
        `ALU_OPCODE_AND:        ALUout = a & b;
        `ALU_OPCODE_OR:         ALUout = a | b;
        `ALU_OPCODE_XOR:        ALUout = a ^ b;
        `ALU_OPCODE_LSL:        ALUout = a << b;
        `ALU_OPCODE_LSR:        ALUout = a >> b;
        `ALU_OPCODE_ASR:        ALUout = a_signed >>> b;
        `ALU_OPCODE_SLT:        ALUout = (a_signed < b_signed) ? 1 : 0;
        `ALU_OPCODE_SLTU:       ALUout = (a < b) ? 1 : 0;
        `ALU_OPCODE_B:          ALUout = b;
        default:                ALUout = 0;   
    endcase

    // EQ is going to define whether the status of the last operation was 0 or 1. 
    // I think this is used for bne, where if the answer to the compare is equal to 0, EQ = 1 
    EQ = (ALUout == 0'b0) ? 1 : 0;    
end

endmodule

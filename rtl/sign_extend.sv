module sign_extend #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] instr,
    input logic [1:0] ImmSrc,
    output logic [DATA_WIDTH-1:0] ImmOp
);

always_comb //non-synchronous
    if (ImmSrc == 0'b00)
        ImmOp = {{DATA_WIDTH-12{instr[31]}}, instr[31:20]}; //i type instructions
    else if (ImmSrc == 0'b01)
        ImmOp = {{DATA_WIDTH-12{instr[31]}}, instr[31:25], instr[11:7]}; //s type instructions
    else if (ImmSrc == 0'b11)
        ImmOp = {instr[31:12], {DATA_WIDTH-20{1'b0}}}; //u type instructions
    else
        ImmOp = {{DATA_WIDTH-12{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0}; //b type instructions
    
endmodule

//takes relevant fields from instruction and composes the immediate operand depending on the instruction

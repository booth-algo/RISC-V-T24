module signextend #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] instr,
    input logic ImmSrc,
    output logic [DATA_WIDTH-1:0] ImmOp
);

always_comb //non-synchronous
    if (ImmSrc)
        ImmOp = {{DATA_WIDTH-12{instr[11]}}, instr[11:0]};
    
endmodule

//takes relevant fields from instruction and composes the immediate operand depending on the instruction
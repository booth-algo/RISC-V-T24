module signextend #(
    parameter WIDTH = 12
) (
    input logic [WIDTH-1:0] instr,
    input logic ImmSrc,
    output logic [31:0] ImmOp
);

  
    
endmodule


//takes relevant fields from instruction and composes the immediate operand depending on the instruction
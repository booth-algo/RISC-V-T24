module pipeline_IF_ID #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic [WIDTH - 1:0] instr_F, // from instruction memory port RD
    input logic [WIDTH - 1:0] PC_F,
    input logic [WIDTH - 1:0] PCP4_F, // PC plus 4
    output logic [WIDTH - 1:0] instr_D,
    output logic [WIDTH - 1:0] PC_D,
    output logic [WIDTH - 1:0] PCP4_D
);

    always_ff @(posedge clk) begin
        instr_D <= instr_F;
        PC_D <= PC_F;
        PCP4_D <= PCP4_F;
    end

endmodule

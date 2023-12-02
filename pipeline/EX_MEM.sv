module EX_MEM #(
    parameter WIDTH = 32
)(
    input logic clk,
    // others 

    // Control unit
    input logic RegWrite_E,
    input logic [1:0] ResultSrc_E,
    input logic MemWrite_E,
    input logic Jump_E,
    input logic Branch_E,
    input logic [2:0] ALUctrl_E,
    input logic ALUsrc_E,
    output logic RegWrite_M,
    output logic [1:0] ResultSrc_M,
    output logic MemWrite_M,
);

endmodule

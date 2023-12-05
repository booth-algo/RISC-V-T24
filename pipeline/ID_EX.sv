module ID_EX #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic [WIDTH - 1:0] RD1_D,
    input logic [WIDTH - 1:0] RD2_D,
    input logic [WIDTH - 1:0] PC_D,
    input logic Rd_D, // new, check width
    input logic ImmExtD_D, // check width
    input logic [WIDTH - 1:0] PCP4_D,
    output logic [WIDTH - 1:0] RD1_E,
    output logic [WIDTH - 1:0] RD2_E,
    output logic [WIDTH - 1:0] PC_E,
    output logic Rd_E,
    output logic ImmExtD_E,
    output logic [WIDTH - 1:0] PCP4_E,

    // Control unit
    input logic RegWrite_D,
    input logic [1:0] ResultSrc_D,
    input logic MemWrite_D,
    input logic Jump_D,
    input logic Branch_D,
    input logic [2:0] ALUctrl_D,
    input logic ALUsrc_D,
    output logic RegWrite_E,
    output logic [1:0] ResultSrc_E,
    output logic MemWrite_E,
    output logic Jump_E,
    output logic Branch_E,
    output logic [2:0] ALUctrl_E,
    output logic ALUsrc_E
);

    always_ff @(posedge clk) begin
        RegWrite_E <= RegWrite_D;
        ResultSrc_E <= ResultSrc_D;
        MemWrite_E <= MemWrite_D;
        Jump_E <= Jump_D;
        Branch_E <= Branch_D;
        ALUctrl_E <= ALUctrl_D;
        ALUsrc_E <= ALUsrc_D;
    end

endmodule

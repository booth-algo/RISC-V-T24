module pipeline_ID_EX #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic [WIDTH - 1:0] RD1_D,
    input logic [WIDTH - 1:0] RD2_D,
    input logic [WIDTH - 1:0] PC_D,
    input logic [4:0] Rs1_D,
    input logic [4:0] Rs2_D,
    input logic [4:0] Rd_D,
    input logic [WIDTH - 1:0] ImmExt_D,
    input logic [WIDTH - 1:0] PCP4_D,
    output logic [WIDTH - 1:0] RD1_E,
    output logic [WIDTH - 1:0] RD2_E,
    output logic [WIDTH - 1:0] PC_E,
    output logic [4:0] Rs1_E,
    output logic [4:0] Rs2_E,
    output logic [4:0] Rd_E,
    output logic [WIDTH - 1:0] ImmExt_E,
    output logic [WIDTH - 1:0] PCP4_E,

    // Control unit
    input logic RegWrite_D,
    input logic [1:0] ResultSrc_D,
    input logic MemWrite_D,
    input logic [2:0] PCsrc_D,
    input logic [3:0] ALUctrl_D,
    input logic ALUsrc_D,
    output logic RegWrite_E,
    output logic [1:0] ResultSrc_E,
    output logic MemWrite_E,
    output logic [2:0] PCsrc_E,
    output logic [3:0] ALUctrl_E,
    output logic ALUsrc_E
);

    always_ff @(posedge clk) begin
        // Control unit
        RegWrite_E <= RegWrite_D;
        ResultSrc_E <= ResultSrc_D;
        MemWrite_E <= MemWrite_D;
        PCsrc_E <= PCsrc_D;
        ALUctrl_E <= ALUctrl_D;
        ALUsrc_E <= ALUsrc_D;

        // Data path
        RD1_E <= RD1_D;
        RD2_E <= RD2_D;
        PC_E <= PC_D;
        Rs1_E <= Rs1_D;
        Rs2_E <= Rs2_D;
        Rd_E <= Rd_D;
        ImmExt_E <= ImmExt_D;
        PCP4_E <= PCP4_D;

    end

endmodule

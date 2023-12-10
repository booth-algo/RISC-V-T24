module pipeline_ID_EX #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic flush,
    input logic LWflush,

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
    input logic MemRead_D,
    input logic [2:0] AddrMode_D,
    input logic [2:0] PCsrc_D,
    input logic [3:0] ALUctrl_D,
    input logic ALUsrc_D,
    output logic RegWrite_E,
    output logic [1:0] ResultSrc_E,
    output logic MemWrite_E,
    output logic MemRead_E,
    output logic [2:0] AddrMode_E,
    output logic [2:0] PCsrc_E,
    output logic [3:0] ALUctrl_E,
    output logic ALUsrc_E
);

    always_ff @(posedge clk) begin
        // Control unit
        if (!flush && !LWflush) begin
            RegWrite_E <= RegWrite_D;
            MemWrite_E <= MemWrite_D;
            PCsrc_E <= PCsrc_D;
        end
        else begin
            RegWrite_E <= 0;
            MemWrite_E <= 0;
            PCsrc_E <= `PC_NEXT;
        end
        ResultSrc_E <= ResultSrc_D;
        MemRead_E <= MemRead_D;
        ALUctrl_E <= ALUctrl_D;
        ALUsrc_E <= ALUsrc_D;
        AddrMode_E <= AddrMode_D;

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

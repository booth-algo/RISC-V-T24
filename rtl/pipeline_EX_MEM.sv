module pipeline_EX_MEM #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic [WIDTH - 1:0] ALUResult_E,
    input logic [WIDTH - 1:0] WriteData_E, // RD2_
    input logic [4:0] Rd_E,
    input logic [WIDTH - 1:0] PCP4_E,
    output logic [WIDTH - 1:0] ALUResult_M,
    output logic [WIDTH - 1:0] WriteData_M,
    output logic [4:0] Rd_M,
    output logic [WIDTH - 1:0] PCP4_M,

    // Control unit
    input logic RegWrite_E,
    input logic MemRead_E,
    input logic [1:0] ResultSrc_E,
    input logic MemWrite_E,
    input logic [2:0] AddrMode_E,
    output logic RegWrite_M,
    output logic MemRead_M,
    output logic [1:0] ResultSrc_M,
    output logic MemWrite_M,
    output logic [2:0] AddrMode_M
);

always_ff @(posedge clk) begin
    // Control unit
    RegWrite_M <= RegWrite_E;
    MemRead_M <= MemRead_E;
    ResultSrc_M <= ResultSrc_E;
    MemWrite_M <= MemWrite_E;
    AddrMode_M <= AddrMode_E;

    // Data path
    ALUResult_M <= ALUResult_E;
    WriteData_M <= WriteData_E;
    Rd_M <= Rd_E;
    PCP4_M <= PCP4_E;

end

endmodule

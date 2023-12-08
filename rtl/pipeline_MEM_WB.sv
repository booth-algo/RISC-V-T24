module pipeline_MEM_WB #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic [WIDTH - 1:0] ALUResult_M,
    input logic [WIDTH - 1:0] ReadData_M,
    input logic [4:0] Rd_M,
    input logic [WIDTH - 1:0] PCP4_M,
    output logic [WIDTH - 1:0] ALUResult_W,
    output logic [WIDTH - 1:0] ReadData_W,
    output logic [4:0] Rd_W,
    output logic [WIDTH - 1:0] PCP4_W,

    // Control unit
    input logic RegWrite_M,
    input logic [1:0] ResultSrc_M,
    output logic RegWrite_W,
    output logic [1:0] ResultSrc_W
);

always_ff @(posedge clk) begin
    // Control unit
    RegWrite_W <= RegWrite_M;
    ResultSrc_W <= ResultSrc_M;

    // Data path
    ALUResult_W <= ALUResult_M;
    ReadData_W <= ReadData_M;
    Rd_W <= Rd_M;
    PCP4_W <= PCP4_M;
    
end

endmodule

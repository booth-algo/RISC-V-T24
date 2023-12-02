module MEM_WB #(
    parameter WIDTH = 32
)(
    input logic clk,
    // others 

    // Control unit
    input logic RegWrite_M,
    input logic [1:0] ResultSrc_M,
    input logic MemWrite_M,
    output logic RegWrite_W,
    output logic [1:0] ResultSrc_W
);

endmodule

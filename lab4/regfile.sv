module regfile #(
    parameter WIDTH = 32
) (
    input logic [4:0]           AD1,
    input logic [4:0]           AD2,
    input logic [4:0]           AD3,
    input logic                 WE3,
    input logic [WIDTH - 1:0]   WD3,
    input logic                 clk,
    output logic [WIDTH - 1:0]  RD1,
    output logic [WIDTH - 1:0]  RD2,
    output logic [WIDTH - 1:0]  a0
);

logic [WIDTH - 1:0] reg;
// add 32 registers 
always_ff @ (posedge clk)
    a0 <= reg[9];
    RD1 <= reg[AD1];
    RD2 <= reg[AD2]; 
    if(WE3 & AD3 != 0'b0) 
        reg[AD3] <= WD3;

endmodule

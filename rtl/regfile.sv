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

logic [WIDTH - 1:0] reg_arr [WIDTH - 1:0]; // declare as array of 32 logic variables (i.e. registers)

assign a0 = reg_arr[10]; // assign a0 outside the always_ff block

always_ff @ (posedge clk) begin
    RD1 <= reg_arr[AD1];
    RD2 <= reg_arr[AD2]; 
    if(WE3 & AD3 != 5'b0) 
        reg_arr[AD3] <= WD3;
end

endmodule

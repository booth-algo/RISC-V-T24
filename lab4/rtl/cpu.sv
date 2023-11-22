module cpu #(
    parameter WIDTH = 8
) (
    // interface signals
    input logic clk,
    input logic rst,
    output logic[WIDTH-1:0] a0
);

always_ff @(posedge clk)
   if (rst) a0 <= {WIDTH{1'b0}};
   else a0 <= a0 + {{WIDTH-1{1'b0}}, '1}; 

endmodule

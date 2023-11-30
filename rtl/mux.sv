module mux #(
    parameter WIDTH = 1
)(
    input logic                 sel,
    input logic [WIDTH-1:0]     in0,
    input logic [WIDTH-1:0]     in1,
    output logic [WIDTH-1:0]    out

);
    assign out = sel ? in1 : in0;
    
endmodule

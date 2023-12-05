module mux4 #(
    parameter WIDTH = 1
)(
    input logic [1:0]           sel,
    input logic [WIDTH-1:0]     in0,
    input logic [WIDTH-1:0]     in1,
    input logic [WIDTH-1:0]     in2,
    input logic [WIDTH-1:0]     in3,
    output logic [WIDTH-1:0]    out

);
    always_comb begin
        case (sel)
            0:          out = in0;
            1:          out = in1;
            2:          out = in2;
            default:    out = in3;
        endcase
    end
    
endmodule

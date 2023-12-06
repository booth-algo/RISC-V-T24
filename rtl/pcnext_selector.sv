`include "def.sv"

module pcnext_selector #(
    parameter WIDTH = 32
)(
    input logic [2:0] PCsrc,
    input logic EQ,
    input logic [WIDTH-1:0] in0,
    input logic [WIDTH-1:0] in1,
    input logic [WIDTH-1:0] in2,
    output logic [WIDTH-1:0] out
);
    always_comb begin
        case (PCsrc)
            `PC_NEXT:               out = in0;
            `PC_ALWAYS_BRANCH:      out = in1;
            `PC_JALR:               out = in2;
            `PC_INV_COND_BRANCH:    out = (EQ) ? in0 : in1;
            `PC_COND_BRANCH:        out = (EQ) ? in1 : in0;
            default: begin
                out = 0;
                $display("Invalid PCsrc: use the ones defined in def.sv");
            end
        endcase
    end
    
endmodule

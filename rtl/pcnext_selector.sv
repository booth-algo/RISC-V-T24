`include "def.sv"

module pcnext_selector #(
    parameter WIDTH = 32
)(
    input logic [2:0] PCsrc,
    input logic EQ,
    input logic [WIDTH-1:0] in0,
    input logic [WIDTH-1:0] in1,
    input logic [WIDTH-1:0] in2,
    output logic branch,
    output logic [WIDTH-1:0] out
);
    always_comb begin        
        case (PCsrc)
            `PC_NEXT: begin
                out = in0;
                branch = 0;
            end              
            `PC_ALWAYS_BRANCH: begin
                out = in1;
                branch = 1;
            end     
            `PC_JALR: begin
                out = in2;
                branch = 1;
            end              
            `PC_INV_COND_BRANCH: begin
                if (EQ) begin
                    out = in0;
                    branch = 0;
                end
                else begin
                    out = in1;
                    branch = 1;
                end
            end   
            `PC_COND_BRANCH: begin
                if (EQ) begin
                    out = in1;
                    branch = 1;
                end
                else begin
                    out = in0;
                    branch = 0;
                end
            end
            default: begin
                out = 0;
                branch = 0;
                $display("Invalid PCsrc: use the ones defined in def.sv");
            end
        endcase

        // // Analysis of branching - uncomment to get data
        // if (branch && !(PCsrc == `PC_NEXT)) $display("BRANCH");
        // else if (~branch && !(PCsrc == `PC_NEXT)) $display("NOT BRANCH");
    end
    
endmodule

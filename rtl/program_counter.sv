module program_counter #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic rst,
    input logic stall,
    input logic [WIDTH-1:0] PCnext,
    output logic [WIDTH-1:0] PC
);
    
    always_ff @(posedge clk) begin
        if (!stall) begin
            PC <= rst ? 32'h0 : PCnext;
        end
    end

endmodule

module program_counter #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic rst,
    input logic PCsrc,
    input logic [WIDTH-1:0] ImmOp,
    output logic [WIDTH-1:0] PC
);
    
    logic [WIDTH-1:0] next_PC;

    always_ff @(posedge clk) begin
        PC <= rst ? 32'h0 : next_PC;
    end

    always_comb begin
        if (PCsrc)
            next_PC = PC + ImmOp;
        else
            next_PC = PC + 4;
    end

endmodule

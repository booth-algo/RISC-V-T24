module instr_mem #(
    parameter   ADDRESS_WIDTH = 32,
                ADDRESS_REAL_WIDTH = 12,
                DATA_WIDTH = 32
) (
    input logic [ADDRESS_WIDTH-1:0] A,
    output logic [DATA_WIDTH-1:0] RD
);

logic [ADDRESS_REAL_WIDTH:0] addr = A[ADDRESS_REAL_WIDTH:0];

logic [DATA_WIDTH-1:0] array [2**ADDRESS_REAL_WIDTH-1:0];

initial begin
    $display("Loading program into instruction memory...");
    $readmemh("../rtl/program.mem", array);
end

assign RD = array[A];
    
endmodule

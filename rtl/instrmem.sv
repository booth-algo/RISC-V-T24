module instrmem #(
    parameter ADDRESS_WIDTH = 32,
    DATA_WIDTH = 32
) (
    input logic [ADDRESS_WIDTH-1:0] A,
    output logic [DATA_WIDTH-1:0] RD
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];

always_comb //non-synchronous
    RD = rom_array[A]; //the word address is increased by 4, but this should be implemented in the PCreg
    
endmodule

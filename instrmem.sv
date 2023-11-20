module instrmem #(
    parameter ADDRESS_WIDTH = 32,
    DATA_WIDTH = 32
) (
    input logic [ADDRESS_WIDTH-1:0] pc,
    output logic [DATA_WIDTH-1:0] instr
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];

always_comb //non-synchronous
    instr <= rom_array[pc]; //the word address is increased by 4, but thsi should be implemented in the PCreg i think
    
endmodule

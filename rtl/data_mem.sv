`include "def.sv"

module data_mem #(
        parameter   DATA_WIDTH = 32, 
                    ADDR_WIDTH = 32,
                    MEM_WIDTH = 8
)(
        input  logic                    clk,
        input  logic [2:0]              AddrMode, // for byte addressing
        input  logic [ADDR_WIDTH-1:0]   A, // address
        input  logic [DATA_WIDTH-1:0]   WD, // write data
        input  logic                    WE, // write enable (memwrite from control_unit)
        output logic [DATA_WIDTH-1:0]   RD // read data
);

    // Define the data array
    // Each bit is 1 byte (8 bits) wide, with 2^17 bytes memory locations
    logic [MEM_WIDTH-1:0] array [2**17-1:0];

    initial begin
        $display("Loading data into data memory...");
        $readmemh("../rtl/data.hex", array, 17'h10000, 17'h1FFFF);
    end

    always_ff @* begin
        // Needs to be addressed in multiples of 4
        // 17 bits of addressing
        RD = {
            array[{A[16:2], 2'b11}],
            array[{A[16:2], 2'b10}], 
            array[{A[16:2], 2'b01}],    
            array[{A[16:2], 2'b00}] 
        };
    end

    // Read and write operations
    always_ff @(posedge clk) begin
        if (WE && AddrMode == 3'b01x) begin // Write only least significant byte (8 bits)
            array[A] <= WD[7:0];
        end

        else if (WE) begin // Write whole word
            array[{A[16:2], 2'b00}] <= WD[7:0];
            array[{A[16:2], 2'b01}] <= WD[15:8];
            array[{A[16:2], 2'b10}] <= WD[23:16];
            array[{A[16:2], 2'b11}] <= WD[31:24];
        end
    end

endmodule

module data_mem #(
        parameter   DATA_WIDTH = 32, 
                    ADDR_WIDTH = 32,
                    MEM_WIDTH = 8
)(
        input  logic                    clk,
        input  logic [ADDR_WIDTH-1:0]   A, // address
        input  logic [DATA_WIDTH-1:0]   WD, // write data
        input  logic                    WE, // write enable (memwrite from control_unit)
        output logic [DATA_WIDTH-1:0]   RD // read data
);

    // Define the data array
    // Each bit is 1 byte (8 bits) wide, with 2^16 = 65536 bytes memory locations
    logic [MEM_WIDTH-1:0] array [2**16-1:0];

    initial begin
        $display("Loading data into data memory...");
        $readmemh("../rtl/data.hex", array);
    end

    assign RD = {array[A+3], array[A+2], array[A+1], array[A]}; // Read

    // Read and write operations
    always_ff @(posedge clk) begin
        if (WE) begin // Write
            array[A] <= WD[7:0];
            array[A+1] <= WD[15:8];
            array[A+2] <= WD[23:16];
            array[A+3] <= WD[31:24];
        end
    end

endmodule

module data_mem #(
        parameter   DATA_WIDTH = 32, 
                    ADDR_WIDTH = 12,
)(
        input  logic                    clk,
        input  logic [ADDR_WIDTH-1:0]   A, // address
        input  logic [DATA_WIDTH-1:0]   WD, // write data
        input  logic                    WE, // write enable (memwrite from control_unit)
        output logic [DATA_WIDTH-1:0]   RD // read data
);

    // Define the data array
    logic [DATA_WIDTH-1:0] array [2**12-1:0];

    assign RD = array[A]; // Read

    // Read and write operations
    always_ff @(posedge clk) begin
        if (WE) begin // Write
            array[A] <= WD;
        end
    end

endmodule

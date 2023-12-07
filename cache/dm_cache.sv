module cache #(
    parameter   ADDR_WIDTH = 32,
                DATA_WIDTH = 32,
) (
    input logic clk,
    input logic read_en,
    input logic write_en,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] write_data,
    output logic [DATA_WIDTH-1:0] read_data,
    output logic hit,
    output logic miss
);

/* direct mapped cache 
        |  v  | tag  | data | 
        | [1] | [27] | [32] | 
    
        // Two ways, and in each way there are 2 blocks

        Memory address: (byte addressing) (32 bits)
            | tag | set | byte offset |
            | [27] | [3] | [2] |
            | a[31:5] | a[4:2] | a[1:0] |
            // is the number of cache registers = 32 so they are referenced like this?
*/

typedef struct packed {
    logic valid;
    logic [26:0] tag;
    logic [31:0] data;
} cache_entry_t;

typedef struct packed {
    logic [26:0] tag = addr[ADDR_WIDTH-1:5]
    logic [2:0] set = addr[4:2]
    logic [1:0] byte_offset = addr[1:0]
}

logic [60-1:0] cache_store [16];

always_comb begin

// Cache read logic
    if (read_en) begin
        // Obtain information from memory address input
        logic [26:0] tag = addr[ADDR_WIDTH-1:5];
        logic [2:0] set = addr[4:2];
        logic [1:0] byte_offset = addr[1:0];
        logic hit;
        if (cache_store[60] && cache_store[56:32] == tag) begin
            hit = 1;
            read_data = cache_store[31:0];
        end
        else begin
            miss = 1;
            read_data = addr;
        end
    end
`end


// Cache write logic
    // Write through cache

    if (write_en) begin
        cache_store[60] = 1;
        cache_store = {1'b1, addr[31:5], };
        // write to some section of main memory to 
    end

endmodule


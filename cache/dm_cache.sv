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
        logic [26:0] tag = addr[ADDR_WIDTH-1:5]
        logic [2:0] set = addr[4:2]
        logic [1:0] byte_offset = addr[1:0]
        // Check if the requested data is present in the cache # if v = 1
        logic hit;
        if (v)
            read_data = hit ? read_data : addr;


        if (cache_entry_t.valid && cache_entry_t.tag == tag)
            hit = 1;
        else
            hit = 0;
        

        if hit begin
            read_data = cache_entry_t;
        end else begin
            hit = 0;
            miss = 1;
            // Handle a cache miss
            // Read from main memory
            // Update cache


        end

    end

// Cache write logic
    // Write through cache

    if (write_en) 
        v = 1;
        cache_store[] = 
        // write to some section of main memory to 
        

// Replacement policy
    // Using U bit, so:
    // If used, U bit = 2, if it is not used for the next cycle, 2-1 = 1, if not used for another cycle, 1-1 = 0, then overwrite in cache
    // Basically compare and decrement U bits of different recently used memory addresses


end

endmodule


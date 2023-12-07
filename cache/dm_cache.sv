module dm_cache #(
    parameter   ADDR_WIDTH = 32,
                DATA_WIDTH = 32
) (
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
            | [27]| [3] |     [2]     |
            | a[31:5] | a[4:2] | a[1:0] |
            // is the number of cache registers = 32 so they are referenced like this?
*/
 
assign hit = 0;
assign miss = 0;

typedef struct packed {
    logic valid;
    logic [26:0] tag;
    logic [31:0] data;
} cache_store;

cache_store cache [8];

always_latch begin
// Cache read logic

    if (read_en) begin
        // Obtain information from memory address input
        logic [26:0] tag = addr[ADDR_WIDTH-1:5];
        logic [2:0] set = addr[4:2];
        logic [1:0] byte_offset = addr[1:0];
        if (cache[set].valid && cache[set].tag == tag) begin
            hit = 1;
            read_data = cache[set].data;
        end
        else if (byte_offset == 0'b00) hit = hit; // to compile
        else begin
            miss = 1;
            read_data = write_data;
        end
    end
end

// Cache write logic
    // Write through cache
always_latch begin
        if (write_en) begin
            //cache[addr[4:2]] = {1'b1, addr[31:5], write_data};
            logic [2:0] set = addr[4:2];
            cache[set].valid = 1;
            cache[set].tag = addr[31:5];
            cache[set].data = write_data;
        end
    end


endmodule
// the address contains a addr[4:2] and the way to check through the cache is to chheck just the set with set = addr[4:2] so we dont need to check through the whole cache
// this should be implemented at a higher level, once this is working we shall work on conflicts

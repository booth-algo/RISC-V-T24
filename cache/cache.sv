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

/* two-way set associative cache (54 bits x2)
        | v | u | tag | data | v | u | tag | data |
        | [1] | [1] | [20] | [32] | [1] | [1] | [20] | [32] |
    
        Each cache entry is cache line / block, i.e. each way

        Memory address: (byte addressing) (32 bits)
            | tag | set | block offset | byte offset |
            | [20] | [4] | [6] | [2] |
            | a[31:12] | a[11:8] | a[7:2] | a[1:0] |
*/

typedef struct packed {
    logic valid;
    logic use;
    logic [19:0] tag;
    logic [31:0] data;
} cache_entry_t;

typedef struct packed {
    cache_entry_t entry1;
    cache_entry_t entry0;
} cache_set_t;

always_comb begin

// Cache read logic
    if (read_en) begin
        // Obtain information from memory address input
        logic [19:0] tag = addr[ADDR_WIDTH-1:ADDR_WIDTH-20]
        logic [3:0] set = addr[ADDR_WIDTH-21:ADDR_WIDTH-24]
        logic [5:0] block_offset = addr[ADDR_WIDTH-25:ADDR_WIDTH-30]
        logic [1:0] byte_offset = addr[ADDR_WIDTH-31:ADDR_WIDTH-32]

        // Check if the requested data is present in the cache
        logic hit_1;
        logic hit_0;

        if (cache_set[set_index].entry1.valid && cache_set[set_index].entry1.tag == tag) begin
            hit_1 = 1;
        end else begin
            hit_1 = 0;
        end

        if (cache_set[set_index].entry0.valid && cache_set[set_index].entry0.tag == tag) begin
            hit_0 = 1;
        end else begin
            hit_0 = 0;
        end

        assign hit = hit_1 | hit_0;

        if hit_1 begin
            read_data = cache_set[set_index].entry1.data;
        end else if hit_0 begin
            read_data = cache_set[set_index].entry0.data;
        end else begin
            hit = 0;
            miss = 1;
        end
    end

// Cache write logic

// Handle cache misses

// Replacement policy

end

endmodule


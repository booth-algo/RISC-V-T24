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
    cache_entry_t entry2;
} cache_set_t;


endmodule


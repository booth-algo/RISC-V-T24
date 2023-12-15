`include "def.sv"

module way2_cache #(
    parameter   ADDR_WIDTH = 32,
                DATA_WIDTH = 32,
                NUM_WAYS = 2
) (
    input logic clk,
    input logic [2:0] addr_mode,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] write_data,
    input logic read_en,
    input logic write_en,

    output logic hit,
    output logic [DATA_WIDTH-1:0] out
);

/* two-way set associative cache (62 bits x2 so 124 total)
        |  v  |  u  |  tag |   data   |  v  |  u  | tag  |  data  |
        | [1] | [2] | [27] |   [32]   | [1] | [2] | [27] |  [32]  |
    
        // Two ways, and in each way there is 1 block

        Memory address: (byte addressing) (32 bits)
            | tag     | set    | byte offset |
            | [27]    | [3]    |      [2]    |
            | a[31:5] | a[4:2] | a[1:0]      |
*/

// need to write to different tags 

typedef struct packed{
    logic valid;
    logic [1:0] Ubits;
    logic [26:0] tag;
    logic [7:0] byte3;
    logic [7:0] byte2;
    logic [7:0] byte1;
    logic [7:0] byte0;
} cache_store;

cache_store cache [NUM_WAYS][8];

logic [DATA_WIDTH-1:0] read_data;
logic [26:0] tag;
logic [2:0] set;
logic [1:0] byte_offset;
logic [1:0] Ubits; 

logic replace;

typedef enum logic [1:0] {
    just_hit, 
    recently_hit, 
    long_hit
} my_state;

// Cache read logic
always_comb begin
    set = addr[4:2];
    byte_offset = addr[1:0];
    hit = 0;

    if(cache[0][set].Ubits > cache[1][set].Ubits) begin
        replace = 1;
    end
    else begin
        replace = 0;
    end

    // Calculate hits
    tag = addr[ADDR_WIDTH-1:5];
    for (int i = 0; i < NUM_WAYS; i++) begin
        if (cache[replace][set].valid && cache[replace][set].tag == tag) begin
            hit = 1;
            cache[replace][set].Ubits = 2;
            cache[!replace][set].Ubits = cache[!replace][set].Ubits - 1;
            out = {
                cache[replace][set].byte3, 
                cache[replace][set].byte2, 
                cache[replace][set].byte1, 
                cache[replace][set].byte0
            };
            break;
        end 
    end


    // Get the data- if there's no hit, fetch from main memory.
    if (hit == 0) begin
        out = read_data;
        if(cache[0][set].Ubits > 0) begin
            cache[0][set].Ubits = cache[0][set].Ubits - 1;
        end
         if(cache[1][set].Ubits > 0) begin
            cache[1][set].Ubits = cache[1][set].Ubits - 1;
        end
    end
end

// Cache write logic: Write through cache
// LRU: random
always_ff @(posedge clk) begin
    if (write_en) begin
        // Pulls data in from sw/sb
        cache[replace][set].valid <= 1'b1;
        cache[replace][set].tag <= addr[31:5];

        case (addr_mode)
            // Byte addressing
            `DATA_ADDR_MODE_B, `DATA_ADDR_MODE_BU: begin
                case (byte_offset)
                    2'b11:  cache[replace][set].byte3 <= write_data[7:0];
                    2'b10:  cache[replace][set].byte2 <= write_data[7:0];
                    2'b01:  cache[replace][set].byte1 <= write_data[7:0];
                    2'b00:  cache[replace][set].byte0 <= write_data[7:0];
                endcase
            end
            // Word addressing
            default: begin
                cache[replace][set].byte3 <= write_data[31:24];
                cache[replace][set].byte2 <= write_data[23:16];
                cache[replace][set].byte1 <= write_data[15:8];
                cache[replace][set].byte0 <= write_data[7:0];
            end
        endcase
    end
    // We still have to check if the "valid_way" is valid- this could just be random
    else if (read_en && !hit) begin
        // Pulls data in from main memory
        cache[replace][set].valid <= 1;
        cache[replace][set].tag <= addr[31:5];

        cache[replace][set].byte3 <= read_data[31:24];
        cache[replace][set].byte2 <= read_data[23:16];
        cache[replace][set].byte1 <= read_data[15:8];
        cache[replace][set].byte0 <= read_data[7:0];
    end

    // Edge case - what if byte addressing AND invalid.
    // Then we would have to pull in data from main memory AS WELL
    
    if (write_en && addr_mode == 3'b01x && !(cache[replace][set].tag == tag)) begin
        case (byte_offset)
            2'b11:  begin
                cache[replace][set].byte2 <= read_data[23:16];
                cache[replace][set].byte1 <= read_data[15:8];
                cache[replace][set].byte0 <= read_data[7:0];
            end
            2'b10:  begin
                cache[replace][set].byte3 <= read_data[31:24];
                cache[replace][set].byte1 <= read_data[15:8];
                cache[replace][set].byte0 <= read_data[7:0];
            end
            2'b01:  begin
                cache[replace][set].byte3 <= read_data[31:24];
                cache[replace][set].byte2 <= read_data[23:16];
                cache[replace][set].byte0 <= read_data[7:0];
            end
            2'b00:  begin
                cache[replace][set].byte3 <= read_data[31:24];
                cache[replace][set].byte2 <= read_data[23:16];
                cache[replace][set].byte1 <= read_data[15:8];
            end
        endcase
    end
    
    if(cache[!replace][set].Ubits > 0) begin
        cache[!replace][set].Ubits <= cache[!replace][set].Ubits - 1;
    end
    else begin
        cache[replace][set].Ubits <= 2;
    end
    // store
end

// check appropriate set
// store - write
// if matches tag and v = 1, replace info, u = 2, u -= 1
// if doesnt match tag or v = 0, replace with smallest u bit, u = 2, u -=1

// load - read
// if matches tag and v = 1, load, u = 2, u -=1 [Y]
// if doesnt match tag or v = 0, replace smallest u bit, read from main memory


data_mem data_mem_inst (
    .clk(clk),
    .AddrMode(addr_mode), 
    .A(addr),
    .WD(write_data),
    .WE(write_en),
    .RD(read_data) 
);

endmodule

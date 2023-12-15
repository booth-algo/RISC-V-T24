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

logic [$clog2(NUM_WAYS)-1:0] counter;

typedef enum logic [1:0] {
    just_hit, 
    recently_hit, 
    long_hit
} my_state;

my_state [NUM_WAYS-1:0] current_state;
my_state [NUM_WAYS-1:0] next_state;


// Initialise FSM
initial begin
    for (int i = 0; i < NUM_WAYS; i++) begin
        current_state[i] = long_hit;
        next_state[i] = long_hit;
    end
end


// Cache read logic
always_comb begin
    set = addr[4:2];
    byte_offset = addr[1:0];
    hit = 0;

    // Calculate hits
    for (int i = 0; i < NUM_WAYS; i++) begin
        tag = addr[ADDR_WIDTH-1:5];
        if (cache[i][set].valid && cache[i][set].tag == tag) begin
            hit = 1;
            out = {
                cache[i][set].byte3, 
                cache[i][set].byte2, 
                cache[i][set].byte1, 
                cache[i][set].byte0
            };
            break;
        end 
    end

    // Get the data- if there's no hit, fetch from main memory.
    if (hit == 0) begin
        out = read_data;
    end
end

logic i;
i = 0;

// Cache write logic: Write through cache
// LRU: random
always_ff @(posedge clk) begin
    if (write_en) begin
        // Pulls data in from sw/sb
        for (int i = 0; i < NUM_WAYS; i++) begin
            cache[i][set].valid <= 1'b1;
            cache[i][set].tag <= addr[31:5];

            case (addr_mode)
                // Byte addressing
                `DATA_ADDR_MODE_B, `DATA_ADDR_MODE_BU: begin
                    case (byte_offset)
                        2'b11:  cache[i][set].byte3 <= write_data[7:0];
                        2'b10:  cache[i][set].byte2 <= write_data[7:0];
                        2'b01:  cache[i][set].byte1 <= write_data[7:0];
                        2'b00:  cache[i][set].byte0 <= write_data[7:0];
                    endcase
                end
                // Word addressing
                default: begin
                    cache[i][set].byte3 <= write_data[31:24];
                    cache[i][set].byte2 <= write_data[23:16];
                    cache[i][set].byte1 <= write_data[15:8];
                    cache[i][set].byte0 <= write_data[7:0];
                end
            endcase
        end
    end

    // We still have to check if the "valid_way" is valid- this could just be random
    else if (read_en && !hit) begin
        // Pulls data in from main memory
        for (int i = 0; i < NUM_WAYS; i++) begin
            cache[i][set].valid <= 1;
            cache[i][set].tag <= addr[31:5];

            cache[i][set].byte3 <= read_data[31:24];
            cache[i][set].byte2 <= read_data[23:16];
            cache[i][set].byte1 <= read_data[15:8];
            cache[i][set].byte0 <= read_data[7:0];
        end
    end

    // Edge case - what if byte addressing AND invalid.
    // Then we would have to pull in data from main memory AS WELL

    if (write_en && addr_mode == 3'b01x && !(cache[i][set].tag == tag)) begin
        case (byte_offset)
            2'b11:  begin
                cache[i][set].byte2 <= read_data[23:16];
                cache[i][set].byte1 <= read_data[15:8];
                cache[i][set].byte0 <= read_data[7:0];
            end
            2'b10:  begin
                cache[i][set].byte3 <= read_data[31:24];
                cache[i][set].byte1 <= read_data[15:8];
                cache[i][set].byte0 <= read_data[7:0];
            end
            2'b01:  begin
                cache[i][set].byte3 <= read_data[31:24];
                cache[i][set].byte2 <= read_data[23:16];
                cache[i][set].byte0 <= read_data[7:0];
            end
            2'b00:  begin
                cache[i][set].byte3 <= read_data[31:24];
                cache[i][set].byte2 <= read_data[23:16];
                cache[i][set].byte1 <= read_data[15:8];
            end
        endcase
    end

    // Drive the FSM
    for (int i = 0; i < NUM_WAYS; i++) begin
        current_state[i] <= next_state[i];
    end

    counter <= counter + 1;
end


// FSM
/*
always_comb begin
    for (int i = 0; i < NUM_WAYS; i++) begin
        case (current_state)
            just_hit: begin
                if (hit[i]) begin
                    cache[set].Ubits = `JUST_HIT;
                end
                else begin
                    cache[set].Ubits = `RECENTLY_HIT;
                end
            end
            recently_hit: begin
                if (hit[i]) begin
                    cache[i][set].Ubits = `JUST_HIT;
                end
                else begin
                    cache[i][set].Ubits = `LONG_HIT;
                end
            end
            long_hit: begin
                if (hit[i]) begin
                    cache[i][set].Ubits = `JUST_HIT;
                end
                else begin
                    // counter = i;
                end
            end
            default: begin
                cache[i][set].Ubits = `LONG_HIT; 
            end
        endcase
    end
end
*/

data_mem data_mem_inst (
    .clk(clk),
    .AddrMode(addr_mode), 
    .A(addr),
    .WD(write_data),
    .WE(write_en),
    .RD(read_data) 
);

endmodule

`include "def.sv"

module way2_cache #(
    parameter   ADDR_WIDTH = 32,
                DATA_WIDTH = 32
) (
    input logic clk,
    input logic [2:0] addr_mode,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] write_data,
    input logic write_en,
    output logic [DATA_WIDTH-1:0] out
);

/* two-way set associative cache (61 bits x2 so 122 total)
        |  v  |  u  |  tag |   data   |  v  |  u  | tag  |  data  |
        | [1] | [2] | [26] |   [32]   | [1] | [2] | [26] |  [32]  |
    
        // Two ways, and in each way there is 1 block

        Memory address: (byte addressing) (32 bits)
            | tag     | set    | byte offset |
            | [26]    | [4]    |      [2]    |
            | a[31:6] | a[5:2] | a[1:0]      |
*/

// need to write to different tags 

typedef struct packed {
    logic valid;
    logic [1:0] Ubits;
    logic [25:0] tag;
    logic [7:0] byte0;
    logic [7:0] byte1;
    logic [7:0] byte2;
    logic [7:0] byte3;
} cache_entry_t;

typedef struct packed {
    cache_entry_t entry1; // way 1
    cache_entry_t entry0; // way 0
} cache_set_t;

cache_set_t cache [16];

logic [DATA_WIDTH-1:0] read_data;
logic hit; 
logic hit_1;
logic hit_0;
logic [25:0] tag;
logic [3:0] set;
logic [1:0] byte_offset;
logic [1:0] Ubits; 
logic select_way_1;


typedef enum logic [1:0] {just_hit0, recently_hit0, long_hit0} my_state_0;
    my_state_0 current_state0, next_state0;

typedef enum logic [1:0] {just_hit1, recently_hit1, long_hit1} my_state_1;
    my_state_1 current_state1, next_state1;

initial begin
    current_state0 = long_hit0;
    next_state0 = long_hit0;
    current_state1 = long_hit1;
    next_state1 = long_hit1;
    select_way_1 = 0;
end

always_latch begin // debug terminal wanted change to always_latch
   
    tag = addr[ADDR_WIDTH-1:6];
    set = addr[5:2];
    byte_offset = addr[1:0];

// Cache read logic
        if (cache[set].entry1.valid && cache[set].entry1.tag == tag) begin
            //$display("hit_1");
            hit_1 = 1;
            out = {
                cache[set].entry1.byte3, 
                cache[set].entry1.byte2, 
                cache[set].entry1.byte1, 
                cache[set].entry1.byte0
            };
        end 
        else begin
            //$display("misrecently_hit");
            hit_1 = 0;
            out = read_data;
        end

        if (cache[set].entry0.valid && cache[set].entry0.tag == tag) begin
            //$display("hit0");
            hit_0 = 1;
            out = {
                cache[set].entry0.byte3, 
                cache[set].entry0.byte2, 
                cache[set].entry0.byte1, 
                cache[set].entry0.byte0
            };
        end 
        else begin
            //$display("misjust_hit");
            hit_0 = 0;
            out = read_data;
        end

        hit = hit_1 | hit_0;

        if (hit) begin
            read_data = hit_1 ? {cache[set].entry1.byte3, cache[set].entry1.byte2, cache[set].entry1.byte1, cache[set].entry1.byte0} : {cache[set].entry0.byte3, cache[set].entry0.byte2, cache[set].entry0.byte1, cache[set].entry0.byte0};
        end
    end

// Cache write logic: Write through cache
always_ff @(posedge clk) begin
    if (write_en) begin
        // Pulls data in from sw/sb
        if (select_way_1) begin
            cache[set].entry1.valid <= 1;
            cache[set].entry1.tag <= addr[31:6];
            //$display("replace entry 1");
            case (addr_mode)
            // Byte addressing
            `DATA_ADDR_MODE_B, `DATA_ADDR_MODE_BU: begin
                case (byte_offset)
                    2'b00:  cache[set].entry1.byte0 <= write_data[7:0];
                    2'b01:  cache[set].entry1.byte1 <= write_data[7:0];
                    2'b10:  cache[set].entry1.byte2 <= write_data[7:0];
                    2'b11:  cache[set].entry1.byte3 <= write_data[7:0];
                endcase
            end
            // Word addressing
            default: begin
                cache[set].entry1.byte0 <= write_data[7:0];
                cache[set].entry1.byte1 <= write_data[15:8];
                cache[set].entry1.byte2 <= write_data[23:16];
                cache[set].entry1.byte3 <= write_data[31:24];
            end
        endcase
        end

        else begin
            cache[set].entry0.valid <= 1;
            cache[set].entry0.tag <= addr[31:6];
            
             case (addr_mode)
            // Byte addressing
            `DATA_ADDR_MODE_B, `DATA_ADDR_MODE_BU: begin
                case (byte_offset)   
                    2'b00:  cache[set].entry0.byte0 <= write_data[7:0];
                    2'b01:  cache[set].entry0.byte1 <= write_data[7:0];
                    2'b10:  cache[set].entry0.byte2 <= write_data[7:0];
                    2'b11:  cache[set].entry0.byte3 <= write_data[7:0];
                endcase
            end
            // Word addressing
            default: begin
                cache[set].entry0.byte0 <= write_data[7:0];
                cache[set].entry0.byte1 <= write_data[15:8];
                cache[set].entry0.byte2 <= write_data[23:16];
                cache[set].entry0.byte3 <= write_data[31:24];
            end
            endcase
        end
    end

    else if (!cache[set].entry1.valid || !(cache[set].entry1.tag == tag)) begin
        // Pulls data in from main memory
        // $display("pull from mem1");
        cache[set].entry1.valid <= 1;
        cache[set].entry1.tag <= addr[31:6];
        cache[set].entry1.byte0 <= read_data[7:0];
        cache[set].entry1.byte1 <= read_data[15:8];
        cache[set].entry1.byte2 <= read_data[23:16];
        cache[set].entry1.byte3 <= read_data[31:24];
    end

    else if (!cache[set].entry0.valid || !(cache[set].entry0.tag == tag)) begin
        // Pulls data in from main memory
        // $display("pull from mem0");
        cache[set].entry0.valid <= 1;
        cache[set].entry0.tag <= addr[31:6];
        cache[set].entry0.byte0 <= read_data[7:0];
        cache[set].entry0.byte1 <= read_data[15:8];
        cache[set].entry0.byte2 <= read_data[23:16];
        cache[set].entry0.byte3 <= read_data[31:24];
    end

    current_state0 <= next_state0;
    current_state1 <= next_state1;
end

always_comb begin
    case (current_state0)
        just_hit0: begin
            if (hit) begin
                    cache[set].entry0.Ubits = `JUST_HIT;
                    next_state0 = just_hit0;
            end
            else begin
                cache[set].entry0.Ubits = `RECENTLY_HIT;
                next_state0 = recently_hit0;
            end
        end
        recently_hit0: begin
            if (hit) begin
                    cache[set].entry0.Ubits = `JUST_HIT;
                    next_state0 = just_hit0;
            end
            else begin
                cache[set].entry0.Ubits = `LONG_HIT;
                next_state0 = long_hit0;
            end
        end
        long_hit0: begin
            if (hit) begin
                    cache[set].entry0.Ubits = `JUST_HIT;
                    next_state0 = just_hit0;
            end
            else begin
                //write_en = 1;
                select_way_1 = 0;
            end
        end
        default: begin
            next_state0 = long_hit0;
            cache[set].entry0.Ubits = `LONG_HIT; 
        end       
    endcase
end

always_comb begin
    case (current_state1)
        just_hit1: begin
            if (hit) begin
                    cache[set].entry1.Ubits = `JUST_HIT; // think about Ubits purpose
                    next_state1 = just_hit1;
                    //$display("U=2 state1");
            end
            else begin
                cache[set].entry1.Ubits = `RECENTLY_HIT;
                next_state1 = recently_hit1;
                //$display("U=1 state1");
            end
        end
        recently_hit1: begin
            if (hit) begin
                    cache[set].entry1.Ubits = `JUST_HIT;
                    next_state1 = just_hit1;
            end
            else begin
                    cache[set].entry1.Ubits = `LONG_HIT;
                    next_state1 = long_hit1;
            end
        end
        long_hit1: begin
            if (hit) begin
                cache[set].entry1.Ubits = `JUST_HIT;
                next_state1 = just_hit1;
                
            end
            else begin
                //write_en = 1;
                select_way_1 = 1;
                // $display("U=0 state1");
            end
        end
         default: begin
            next_state1 = long_hit1;
            cache[set].entry1.Ubits = `LONG_HIT; 
        end
    endcase
end

data_mem data_mem_inst (
    .clk(clk),
    .AddrMode(addr_mode), 
    .A(addr),
    .WD(write_data),
    .WE(write_en),
    .RD(read_data) 
);

endmodule

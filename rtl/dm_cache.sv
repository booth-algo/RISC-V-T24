module dm_cache #(
    parameter   ADDR_WIDTH = 32,
                DATA_WIDTH = 32
) (
    input logic clk,
    input logic write_en,
    input logic read_en,
    input logic [2:0] addr_mode,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] write_data,

    output logic hit,
    output logic [DATA_WIDTH-1:0] out
);

/* direct mapped cache 
        |  v  | tag  | data | 
        | [1] | [27] | [32] | 
    
        Memory address: (byte addressing) (32 bits)
            | tag | set | byte offset |
            | [27]| [3] |     [2]     |
            | a[31:5] | a[4:2] | a[1:0] |
            // is the number of cache registers = 32 so they are referenced like this?
*/
 
typedef struct packed {
    logic valid;
    logic [26:0] tag;
    logic [7:0] byte3;
    logic [7:0] byte2;
    logic [7:0] byte1;
    logic [7:0] byte0;
} cache_store;

cache_store cache [8];

logic [DATA_WIDTH-1:0] read_data;
logic [26:0] tag;
logic [2:0] set;
logic [1:0] byte_offset;


// Cache read logic
always_comb begin
    tag = addr[ADDR_WIDTH-1:5];
    set = addr[4:2];
    byte_offset = addr[1:0];

    if (cache[set].valid && cache[set].tag == tag) begin
        hit = 1;
        out = {
            cache[set].byte3, 
            cache[set].byte2, 
            cache[set].byte1, 
            cache[set].byte0
        };
    end
    
    else begin

        // NOTE:
        // This requires a read to and from main memory
        // Normally this would be done by stalling for some clock cycles
        // However, in this model, we will not stall.
        
        hit = 0;
        out = read_data;
    end

    // Analysis of cache
    if (read_en && hit)           $display("HIT");
    else if (read_en && ~hit)     $display("MISS");
    else if (write_en)            $display("STORE");
end


// Cache write logic: Write through cache
always_ff @(posedge clk) begin
    if (write_en) begin
        // Pulls data in from sw/sb
        cache[set].valid <= 1;
        cache[set].tag <= addr[31:5];
        
        case (addr_mode)
            // Byte addressing
            `DATA_ADDR_MODE_B, `DATA_ADDR_MODE_BU: begin
                case (byte_offset)
                    2'b11:  cache[set].byte3 <= write_data[7:0];
                    2'b10:  cache[set].byte2 <= write_data[7:0];
                    2'b01:  cache[set].byte1 <= write_data[7:0];
                    2'b00:  cache[set].byte0 <= write_data[7:0];
                endcase
            end
            // Word addressing
            default: begin
                cache[set].byte3 <= write_data[31:24];
                cache[set].byte2 <= write_data[23:16];
                cache[set].byte1 <= write_data[15:8];
                cache[set].byte0 <= write_data[7:0];
            end
        endcase
    end
    
    else if (read_en && (!cache[set].valid || !(cache[set].tag == tag))) begin
        // Pulls data in from main memory
        cache[set].valid <= 1;
        cache[set].tag <= addr[31:5];

        cache[set].byte3 <= read_data[31:24];
        cache[set].byte2 <= read_data[23:16];
        cache[set].byte1 <= read_data[15:8];
        cache[set].byte0 <= read_data[7:0];
    end

    // Edge case - what if byte addressing AND invalid.
    // Then we would have to pull in data from main memory AS WELL
    if (write_en && addr_mode == 3'b01x && !(cache[set].tag == tag)) begin
        case (byte_offset)
            2'b11:  begin
                cache[set].byte2 <= read_data[23:16];
                cache[set].byte1 <= read_data[15:8];
                cache[set].byte0 <= read_data[7:0];
            end
            2'b10:  begin
                cache[set].byte3 <= read_data[31:24];
                cache[set].byte1 <= read_data[15:8];
                cache[set].byte0 <= read_data[7:0];
            end
            2'b01:  begin
                cache[set].byte3 <= read_data[31:24];
                cache[set].byte2 <= read_data[23:16];
                cache[set].byte0 <= read_data[7:0];
            end
            2'b00:  begin
                cache[set].byte3 <= read_data[31:24];
                cache[set].byte2 <= read_data[23:16];
                cache[set].byte1 <= read_data[15:8];
            end
        endcase
    end
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

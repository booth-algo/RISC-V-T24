`include "def.sv"

module top_memory #(
    parameter   ADDR_WIDTH = 32,
                DATA_WIDTH = 32
) (
    input logic clk,
    input logic write_en,
    input logic [2:0] addr_mode,
    input logic [ADDR_WIDTH-1:0] addr,
    input logic [DATA_WIDTH-1:0] write_data,

    output logic [DATA_WIDTH-1:0] out
);

logic [DATA_WIDTH-1:0] out_cache;
logic [7:0] byte3, byte2, byte1, byte0;

always_comb begin
    byte3 = out_cache[31:24];
    byte2 = out_cache[23:16];
    byte1 = out_cache[15:8];
    byte0 = out_cache[7:0];

    // Read logic
    case (addr_mode)
        `DATA_ADDR_MODE_W: begin
            out = out_cache; 
        end
        `DATA_ADDR_MODE_B: begin
            case (addr[1:0])
                2'b00: begin
                    out = {{24{byte0[7]}}, byte0};
                end
                2'b01: begin
                    out = {{24{byte1[7]}}, byte1};
                end
                2'b10: begin
                    out = {{24{byte2[7]}}, byte2};
                end
                2'b11: begin
                    out = {{24{byte3[7]}}, byte3};
                end
            endcase
        end
        `DATA_ADDR_MODE_BU: begin
            case (addr[1:0])
                2'b00: begin
                    out = {24'b0, byte0};
                end
                2'b01: begin
                    out = {24'b0, byte1};
                end
                2'b10: begin
                    out = {24'b0, byte2};
                end
                2'b11: begin
                    out = {24'b0, byte3};
                end
            endcase
        end
        // `DATA_ADDR_MODE_H
        // `DATA_ADDR_MODE_HU
        default: $display("WARNING: unrecognised addr_mode in memory.sv");
    endcase
end


dm_cache #(ADDR_WIDTH, DATA_WIDTH) dm_cache_inst (
    .clk(clk),
    .write_en(write_en),
    .addr_mode(addr_mode),
    .addr(addr),
    .write_data(write_data),

    .out(out_cache)
);

endmodule

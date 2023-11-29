module fetch_cycle #(
    parameter WIDTH = 32
)(
  input logic clk,
  input logic reset,
  input logic [WIDTH-1:0] pc_in,
  output logic [WIDTH-1:0] pc_out,
  output logic [WIDTH-1:0] instruction
);

  // Registers
  reg [WIDTH-1:0] pc_reg;
  reg [WIDTH-1:0] instruction_reg;

  // Fetch stage logic
  always @(posedge clk) begin
    if (reset) begin
      pc_reg <= 32'h0;
      instruction_reg <= 32'h0;
    end else begin
      pc_reg <= pc_in;
      instruction_reg <= instruction;
    end
  end

  assign pc_out = pc_reg;
  assign instruction = instruction_reg;

endmodule

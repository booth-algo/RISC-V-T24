module pipeline_top (
  input logic clk,
  input logic reset,
  // ... other input and output ports ...
);

fetch_cycle fetch_cycle_inst (
  .clk(clk),
  .reset(reset),
  .pc_in(pc_in),
  .pc_out(pc_out),
  .instruction(instruction)
);

// decode_cycle 

// execute_cycle

// mem_cycle

// writeback_cycle

endmodule

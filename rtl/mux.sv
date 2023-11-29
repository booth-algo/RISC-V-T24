module mux (
  input logic   sel,
  input logic   in0,
  input logic   in1,
  output logic  out
);

  assign out = sel ? in1 : in0;

endmodule

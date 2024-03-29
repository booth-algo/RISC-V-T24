`include "def.sv"

/* verilator lint_off UNUSED */

module sign_extend #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] instr,
    input logic [2:0] ImmSrc,
    output logic [DATA_WIDTH-1:0] ImmOp
);

always_comb //non-synchronous
    case (ImmSrc)
        `SIGN_EXTEND_I:     ImmOp = {{DATA_WIDTH-12{instr[31]}}, instr[31:20]};
        `SIGN_EXTEND_S:     ImmOp = {{DATA_WIDTH-12{instr[31]}}, instr[31:25], instr[11:7]};
        `SIGN_EXTEND_B:     ImmOp = {{DATA_WIDTH-12{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        `SIGN_EXTEND_U:     ImmOp = {instr[31:12], {DATA_WIDTH-20{1'b0}}};
        `SIGN_EXTEND_J:     ImmOp = {{DATA_WIDTH-21{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
        `SIGN_EXTEND_I5:    ImmOp = {{DATA_WIDTH-5{1'b0}}, instr[24:20]};
        
        default: begin
            ImmOp = 0;
            $display("Invalid ImmOp: use the ones defined in def.sv");
        end
    endcase
    
endmodule

//takes relevant fields from instruction and composes the immediate operand depending on the instruction

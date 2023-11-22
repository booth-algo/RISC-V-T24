module cpu #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic rst,
    output logic a0,
);
    // Program counter
    logic PCsrc;
    logic [WIDTH-1:0] ImmOp;

    // ALU
    logic ALUop1;
    logic ALUctrl;
    logic regOp2;
    logic ALUsrc;
    logic EQ;
    logic ALUout;
    logic [WIDTH-1:0] PC;

    // Regfile
    logic rs1;
    logic rs2;
    logic rd;
    logic RegWrite;

    // Sign Extend
    logic ImmSrc;

    // Instruction Memory
    logic [WIDTH-1:0] instr;

    program_counter program_counter_inst (
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc)
        .ImmOp(ImmOp),
        .PC(PC)
    )
    
    alu alu_inst (
        .ALUop1(ALUop1),
        // ALUop2 should not be an input based on your design
        .ALUctrl(ALUctrl),
        // should not have a clk
        .regOp2(regOp2),
        .ImmOp(ImmOp),
        .ALUsrc(ALUsrc),
        .EQ(EQ),
        .ALUout(ALUout) // should technically be SUM, not ALUout, but it's fine, we can fix it later
    );

    reg_file reg_file_inst (
        // your input and output in your module declaration of "regfile" is inaccurate - you should define by portname, not signal name
        .AD1(rs1),
        .AD2(rs2),
        .AD3(rd),
        .WE3(RegWrite),
        .WD3(ALUout),
        .RD1(ALUop1),
        .RD2(regOp2)
    );

    instr_mem instr_mem_inst (
        // similar issue - port name declaration is inaccurate
        .A(PC),
        .RD(instr)
    );

    control_unit control_unit_inst (
        .RegWrite(RegWrite),
        .ALUctrl(ALUctrl),
        .ALUsrc(ALUsrc),
        .ImmSrc(ImmSrc),
        .PCsrc(PCsrc),
        .EQ(EQ),
        .instr(instr)
    );

    sign_extend sign_extend_inst (
        .ImmOp(ImmOp),
        .ImmOpSrc(ImmSrc),
        .instr(instr)
    );

endmodule

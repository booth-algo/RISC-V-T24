module cpu #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic rst,
    output logic [WIDTH-1:0] a0
);
    // Program counter
    logic PCsrc;
    logic [WIDTH-1:0] ImmOp;

    // ALU
    logic [WIDTH-1:0] ALUop1;
    logic ALUctrl;
    logic [WIDTH-1:0] regOp2;
    logic ALUsrc;
    logic EQ;
    logic [WIDTH-1:0] ALUout;
    logic [WIDTH-1:0] PC;

    // Regfile
    logic [4:0] rs1 = instr[19:15];
    logic [4:0] rs2 = instr[24:20];
    logic [4:0] rd = instr[11:7];
    logic RegWrite;

    // Sign Extend
    logic [1:0] ImmSrc;

    // Instruction Memory
    logic [WIDTH-1:0] instr;

    program_counter program_counter_inst (
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc),
        .ImmOp(ImmOp),
        .PC(PC)
    );
    
    alu alu_inst (
        .ALUop1(ALUop1),
        .ALUctrl(ALUctrl),
        .regOp2(regOp2),
        .ImmOp(ImmOp),
        .ALUsrc(ALUsrc),
        .EQ(EQ),
        .ALUout(ALUout) 
    );

    regfile reg_file_inst (
        .clk(clk),
        .AD1(rs1),
        .AD2(rs2),
        .AD3(rd),
        .WE3(RegWrite),
        .WD3(ALUout),
        .RD1(ALUop1),
        .RD2(regOp2),
        .a0(a0)
    );

    instrmem instr_mem_inst (
        .A(PC),
        .RD(instr)
    );

    controlunit control_unit_inst (
        .RegWrite(RegWrite),
        .ALUctrl(ALUctrl),
        .ALUsrc(ALUsrc),
        .ImmSrc(ImmSrc),
        .PCsrc(PCsrc),
        .EQ(EQ),
        .instr(instr)
    );

    signextend sign_extend_inst (
        .ImmOp(ImmOp),
        .ImmSrc(ImmSrc),
        .instr(instr[31:7]) // erm I am not sure about this, Lec 7 Slide 16 says this should only supply 25 bits
    );

endmodule

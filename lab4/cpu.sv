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
    logic rs1 = instr[19:15];
    logic rs2 = instr[24:20];
    logic rd = instr[11:7];
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
        .ALUctrl(ALUctrl),
        .regOp2(regOp2),
        .ImmOp(ImmOp),
        .ALUsrc(ALUsrc),
        .EQ(EQ),
        .ALUout(ALUout) 
    );

    reg_file reg_file_inst (
        .AD1(rs1),
        .AD2(rs2),
        .AD3(rd),
        .WE3(RegWrite),
        .WD3(ALUout),
        .RD1(ALUop1),
        .RD2(regOp2)
    );

    instr_mem instr_mem_inst (
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
        .ImmSrc(ImmSrc),
        .instr(instr[31:7])
    );

endmodule

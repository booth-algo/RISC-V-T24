module top #(
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
    logic [WIDTH-1:0] ALUin1;
    logic [WIDTH-1:0] ALUin2;
    logic [2:0] ALUctrl;
    logic [WIDTH-1:0] regOp2;
    logic ALUsrc;
    /* verilator lint_off UNOPTFLAT */
    logic EQ;
    logic [WIDTH-1:0] ALUout;
    logic [WIDTH-1:0] PC;

    // Instruction Memory
    logic [WIDTH-1:0] instr;

    // Regfile
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;

    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign rd = instr[11:7];

    logic RegWrite;

    // Sign Extend
    logic [1:0] ImmSrc;

    program_counter program_counter_inst (
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc),
        .ImmOp(ImmOp),

        .PC(PC)
    );
    
    instr_mem instr_mem_inst (
        .A(PC),

        .RD(instr)
    );
    /* verilator lint_off PINMISSING */
    control_unit control_unit_inst (
        .instr(instr),
        .EQ(EQ),

        .RegWrite(RegWrite),
        .ALUctrl(ALUctrl),
        .ALUsrc(ALUsrc),
        .ImmSrc(ImmSrc),
        .PCsrc(PCsrc)
    );
    /* verilator lint_on PINMISSING */
    sign_extend sign_extend_inst (
        .instr(instr),
        .ImmSrc(ImmSrc),

        .ImmOp(ImmOp)
    );

    mux #(WIDTH) mux_inst (
        .in0(regOp2),
        .in1(ImmOp),
        .sel(ALUsrc),

        .out(ALUin2)
    );

    alu alu_inst (
        .a(ALUin1),
        .b(ALUin2),
        .ALUctrl(ALUctrl),

        .EQ(EQ),
        .ALUout(ALUout) 
    );

    regfile regfile_inst (
        .clk(clk),
        .AD1(rs1),
        .AD2(rs2),
        .AD3(rd),
        .WE3(RegWrite),
        .WD3(ALUout),

        .RD1(ALUin1),
        .RD2(regOp2),
        .a0(a0)
    );

endmodule

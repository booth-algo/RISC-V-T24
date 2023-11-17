module cpu #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic rst,
    input logic PCsrc,
    input logic [WIDTH-1:0] ImmOp,
    input logic ALUop1,
    input logic ALUop2,
    input logic ALUsrc,
    input logic AD1,
    input logic AD2,
    input logic AD3,
    input logic WE3,
    input logic WD3, 
    output logic [WIDTH-1:0] PC,
    output logic ALUout,
    output logic EQ,
    output logic a0,
    output logic RD1,
    output logic RD2
);

    // Declaration of internal wires to interconnect submodules
    logic [31:0] rs1;
    logic [31:0] rs2;
    logic [31:0] rd;
    logic [31:0] RegWrite;
    logic [31:0] regOp2;
    logic [31:0] ALUop1;
    logic [31:0] ALUop2;
    logic [31:0] ALUsrc; // should this be here on in the module declaration???

    program_counter program_counter_inst (
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc)
        .ImmOp(ImmOp),
        .PC(pc)
    )
    
    alu alu_inst (
        .ALUop1(ALUop1),
        .ALUop2(ALUop2),
        .ALUsrc(ALUsrc),
        // probably need interconnecting stuff like regOp2, etc.
        .sum(ALUout),
        .EQ(EQ)
    );

    reg_file reg_file_inst (
        .clk(clk),
        .rst(rst),
        .AD1(AD1),
        .AD2(AD2),
        .AD3(AD3),
        .WE3(RegWrite),
        .WD3(ALUout), // hmmmmmmmmmmm
    );

    instr_mem instr_mem_inst (
        .A(PC),
        .RD(instr) // not declared i think
    );

    control_unit control_unit_inst (
        .ImmSrc(ImmSrc), // not declared
        .ALUctrl(ALUctrl),
        .ALUsrc(ALUsrc),
        .PCsrc(PCsrc),
        .ImmSrc(ImmSrc),
        .EQ(EQ),
        .reg_write(reg_write), // a lot not declared
    );

    sign_extend sign_extend_inst (
        .ImmOp(ImmOp),
        .ImmOpSrc(ImmOpSrc)
    );

endmodule

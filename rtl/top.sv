module top #(
    parameter WIDTH = 32
)(
    input logic clk,
    input logic rst,
    output logic [WIDTH-1:0] a0
);
    // Program counter
    logic [2:0] PCsrc_D;
    logic [2:0] PCsrc_E;

    logic [WIDTH-1:0] ImmExt_D;
    logic [WIDTH-1:0] ImmExt_E;

    logic [WIDTH-1:0] PCP4_F;
    logic [WIDTH-1:0] PCP4_D;
    logic [WIDTH-1:0] PCP4_E;
    logic [WIDTH-1:0] PCP4_M;
    logic [WIDTH-1:0] PCP4_W;

    // ALU    
    logic [3:0] ALUctrl_D;
    logic [3:0] ALUctrl_E;
    
    logic [WIDTH-1:0] SrcA_E;
    logic [WIDTH-1:0] SrcB_E;
    
    logic ALUsrc_D;
    logic ALUsrc_E;
    
    /* verilator lint_off UNOPTFLAT */
    logic Zero_E;
    
    logic [WIDTH-1:0] PC_F;
    logic [WIDTH-1:0] PC_D;
    logic [WIDTH-1:0] PC_E;
    
    logic [WIDTH-1:0] PCnext;
    
    logic [WIDTH-1:0] ALUResult_E;
    logic [WIDTH-1:0] ALUResult_M;
    logic [WIDTH-1:0] ALUResult_W;

    // Instruction Memory
    logic [WIDTH-1:0] instr_F;
    logic [WIDTH-1:0] instr_D;

    // Regfile
    logic [4:0] Rs1_D;
    logic [4:0] Rs1_E;
    logic [4:0] Rs2_D;
    logic [4:0] Rs2_E;

    logic [4:0] Rd_D;
    logic [4:0] Rd_E;
    logic [4:0] Rd_M;
    logic [4:0] Rd_W;

    logic [WIDTH-1:0] RD1_D;
    logic [WIDTH-1:0] RD1_E;
    logic [WIDTH-1:0] RD2_D;
    logic [WIDTH-1:0] RD2_E;

    // Data memory
    logic MemWrite_D;
    logic MemWrite_E;
    logic MemWrite_M;
    logic MemRead_D;
    logic MemRead_E;

    logic [WIDTH-1:0] WriteData_E;
    logic [WIDTH-1:0] WriteData_M;
    
    logic [WIDTH-1:0] ReadData_M;
    logic [WIDTH-1:0] ReadData_W;

    logic RegWrite_D;
    logic RegWrite_E;
    logic RegWrite_M;
    logic RegWrite_W;

    // Sign Extend
    logic [2:0] ImmSrc_D;

    // Result
    logic [1:0] ResultSrc_D;
    logic [1:0] ResultSrc_E;
    logic [1:0] ResultSrc_M;
    logic [1:0] ResultSrc_W;
    logic [WIDTH-1:0] Result_W;

    // Hazard Unit
    logic [1:0] forwardA_E;
    logic [1:0] forwardB_E;
    logic stall;

    // Spacing intentional, seperates input and output

    // Pipeline 1 - Fetch (IF)
    
    assign PCP4_F = PC_F + 4;

    pcnext_selector #(WIDTH) PCnext_selector_inst ( 
        // Implements: PCnext = PCsrc ? PC + ImmOp : PC + 4;
        .in0(PCP4_F),                         // incPC = PC + 4
        .in1(PC_E + ImmExt_E),              // branchPC = PC + ImmOp
        .in2(ALUResult_E),                  // jalr
        .EQ(Zero_E),
        .PCsrc(PCsrc_E),

        .out(PCnext)                // PC_F'
    );
    
    program_counter program_counter_inst (
        .clk(clk),
        .rst(rst),
        .stall(stall),
        .PCnext(PCnext),

        .PC(PC_F)
    );

    instr_mem instr_mem_inst (
        .A(PC_F),

        .RD(instr_F)
    );

    pipeline_IF_ID pipeline_IF_ID_inst (
        .clk(clk),
        .stall(stall),
        .instr_F(instr_F),
        .PC_F(PC_F),
        .PCP4_F(PCP4_F),

        .instr_D(instr_D),
        .PC_D(PC_D),
        .PCP4_D(PCP4_D)
    );

    // Pipeline 2 - Decode (ID)

    /* verilator lint_off UNUSED */
    control_unit control_unit_inst (
        .instr(instr_D),
        .stall(stall),

        .RegWrite(RegWrite_D),
        .MemWrite(MemWrite_D),
        .MemRead(MemRead_D),
        .ALUctrl(ALUctrl_D),
        .ALUsrc(ALUsrc_D),
        .ImmSrc(ImmSrc_D),
        .PCsrc(PCsrc_D),
        .ResultSrc(ResultSrc_D)
    );
    /* verilator lint_on UNUSED */

    sign_extend sign_extend_inst (
        .instr(instr_D),
        .ImmSrc(ImmSrc_D),

        .ImmOp(ImmExt_D)
    );

    assign Rs1_D = instr_D[19:15];
    assign Rs2_D = instr_D[24:20];
    assign Rd_D = instr_D[11:7];
    
    regfile regfile_inst (
        .clk(clk),
        .AD1(Rs1_D),
        .AD2(Rs2_D),
        .AD3(Rd_W),
        .WE3(RegWrite_W),
        .WD3(Result_W),

        .RD1(RD1_D),
        .RD2(RD2_D),
        .a0(a0)
    );

    pipeline_ID_EX pipeline_ID_EX_inst (
        .clk(clk),
        .RD1_D(RD1_D),
        .RD2_D(RD2_D),
        .PC_D(PC_D),
        .Rs1_D(Rs1_D),
        .Rs2_D(Rs2_D),
        .Rd_D(Rd_D),
        .ImmExt_D(ImmExt_D),
        .PCP4_D(PCP4_D),

        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .PC_E(PC_E),
        .Rs1_E(Rs1_E),
        .Rs2_E(Rs2_E),
        .Rd_E(Rd_E),
        .ImmExt_E(ImmExt_E),
        .PCP4_E(PCP4_E),

        .RegWrite_D(RegWrite_D),
        .ResultSrc_D(ResultSrc_D),
        .MemWrite_D(MemWrite_D),
        .MemRead_D(MemRead_D),
        .PCsrc_D(PCsrc_D),
        .ALUctrl_D(ALUctrl_D),
        .ALUsrc_D(ALUsrc_D),

        .RegWrite_E(RegWrite_E),
        .ResultSrc_E(ResultSrc_E),
        .MemWrite_E(MemWrite_E),
        .MemRead_E(MemRead_E),
        .PCsrc_E(PCsrc_E),
        .ALUctrl_E(ALUctrl_E),
        .ALUsrc_E(ALUsrc_E)
    );

    // Pipeline 3 - Execute (EX)

    mux4 #(WIDTH) mux_hazard_A_inst (
        .in0(RD1_E),
        .in1(Result_W),
        .in2(ALUResult_M),
        .in3(0),
        .sel(forwardA_E),

        .out(SrcA_E)
    );

    mux4 #(WIDTH) mux_hazard_B_inst (
        .in0(RD2_E),
        .in1(Result_W),
        .in2(ALUResult_M),
        .in3(0),
        .sel(forwardB_E),

        .out(WriteData_E)
    );

    mux #(WIDTH) mux_alu_inst (
        .in0(WriteData_E),
        .in1(ImmExt_E),
        .sel(ALUsrc_E),

        .out(SrcB_E)
    );

    alu alu_inst (
        .a(SrcA_E),
        .b(SrcB_E),
        .ALUctrl(ALUctrl_E),

        .EQ(Zero_E),
        .ALUout(ALUResult_E)
    );

    pipeline_EX_MEM pipeline_EX_MEM_inst (
        .clk(clk),
        .ALUResult_E(ALUResult_E),
        .WriteData_E(WriteData_E),
        .Rd_E(Rd_E),
        .PCP4_E(PCP4_E),

        .ALUResult_M(ALUResult_M),
        .WriteData_M(WriteData_M),
        .Rd_M(Rd_M),
        .PCP4_M(PCP4_M),

        .RegWrite_E(RegWrite_E),
        .ResultSrc_E(ResultSrc_E),
        .MemWrite_E(MemWrite_E),

        .RegWrite_M(RegWrite_M),
        .ResultSrc_M(ResultSrc_M),
        .MemWrite_M(MemWrite_M)
    );

    // Pipeline 4 - Memory (MEM)
    
    data_mem data_mem_inst (
        .clk(clk),
        .A(ALUResult_M),
        .WD(WriteData_M),
        .WE(MemWrite_M),

        .RD(ReadData_M)
    );

    pipeline_MEM_WB pipeline_MEM_WB_inst (
        .clk(clk),
        .ALUResult_M(ALUResult_M),
        .ReadData_M(ReadData_M),
        .Rd_M(Rd_M),
        .PCP4_M(PCP4_M),

        .ALUResult_W(ALUResult_W),
        .ReadData_W(ReadData_W),
        .Rd_W(Rd_W),
        .PCP4_W(PCP4_W),

        .RegWrite_M(RegWrite_M),
        .ResultSrc_M(ResultSrc_M),

        .RegWrite_W(RegWrite_W),
        .ResultSrc_W(ResultSrc_W)
    );

    // Pipeline 5 - Writeback (WB)

    mux4 #(WIDTH) mux_result_inst (
        .in0(ALUResult_W),
        .in1(ReadData_W),
        .in2(PCP4_W),
        .in3(0),
        .sel(ResultSrc_W),

        .out(Result_W)
    );

    // Hazard Unit


    hazard_unit hazard_unit_inst (
        .Rs1_E(Rs1_E),
        .Rs2_E(Rs2_E),
        .Rs1_D(Rs1_D),
        .Rs2_D(Rs2_D),
        .Rd_E(Rd_E),
        .Rd_M(Rd_M),
        .Rd_W(Rd_W),
        .RegWrite_M(RegWrite_M),
        .RegWrite_W(RegWrite_W),
        .MemRead_E(MemRead_E),

        .forwardA_E(forwardA_E),
        .forwardB_E(forwardB_E),
        .stall(stall)
    );

endmodule

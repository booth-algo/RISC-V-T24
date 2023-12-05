/*
 *  Verifies the results of the control unit, exits with a 0 on success.
 *
 *  Reference to RISC-V codes
 *  https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf
 * 
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "base_testbench.h"
#include <bitset>

#define NAME            "control_unit"

#define OPCODE_I1       0b001'0011          // addi, xori, ori... (ALU imm)
#define OPCODE_I2       0b000'0011          // lb, lh, lw... (load imm)
#define OPCODE_I3       0b110'0111          // jalr
#define OPCODE_I4       0b111'0011          // ecall, ebreak

#define OPCODE_U1       0b011'0111          // lui (load upper imm)
#define OPCODE_U2       0b001'0111          // auipc (add imm to pc)

#define OPCODE_S        0b010'0011          // sb, sh, sw (store)
#define OPCODE_B        0b110'0011          // beq, bne, blt (branch)
#define OPCODE_R        0b011'0011          // add, sub, xor... (register)
#define OPCODE_J        0b110'1111          // jal  (jump and link)


class ControlunitTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->instr = 0;
        top->EQ = 0;
        // outputs: 
        // ALUctrl - controls the alu
        // ALUsrc - selects between rd2 (0) and ImmOp (1)
        // ImmSrc - selects between I (0), S (1) and B (2) type
        // PCsrc - selects next PC (0) or branch (1)
        // RegWrite - enables writing of register
        // MemWrite - enables writing of data memory
        // ResultSrc - chooses ALUout (0) or memory read (1)
    }
};


TEST_F(ControlunitTestbench, ALUControl)
{
    // ADD (000)    - add, addi, lw, sw
    // SUB (001)    - sub, beq
    // AND (010)    - and
    // OR  (011)     - or
    // --  (100)
    // SLT (101)    - slt
    // --  (110)
    // --  (111)

    // This is to make sure it pulls down rather than taking default
    top->instr = OPCODE_B + (0b001 << 12);
    top->eval();

    // lw should always signify an ADD
    top->instr = OPCODE_I2;
    top->eval();
    EXPECT_EQ(top->ALUctrl, 0) << "Test 1";

    // This is to make sure it pulls down rather than taking default
    top->instr = OPCODE_B + (0b001 << 12);
    top->eval();

    // sw should always signify an ADD
    top->instr = OPCODE_S;
    top->eval();
    EXPECT_EQ(top->ALUctrl, 0) << "Test 2";
    
    // beq should always signify an SUB
    top->instr = OPCODE_B + (0b000 << 12);
    top->eval();
    EXPECT_EQ(top->ALUctrl, 1) << "Test 3";

    // bne should always signify an SUB
    top->instr = OPCODE_B + (0b001 << 12);
    top->eval();
    EXPECT_EQ(top->ALUctrl, 1) << "Test 4";

    // TODO check more instructions
}


TEST_F(ControlunitTestbench, RegWriteTest)
{   
    // RegWrite = 1: R-type, I-type, U-type, J-type 
    // RegWrite = 0: S-type, B-type

    for (int opcode : { 
        OPCODE_I1, OPCODE_I2, OPCODE_I3, OPCODE_I4, 
        OPCODE_R, OPCODE_U1, OPCODE_U2, OPCODE_J 
    }) {
        // This assumes OPCODE_S sets it to 1
        // This makes sure it actually SETS it to 0 instead of default 0
        top->instr = OPCODE_S;
        top->eval();

        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->RegWrite, 1) << "Opcode: " << std::bitset<7>(opcode);
    }

    for (int opcode : { OPCODE_S, OPCODE_B }) 
    {
        // This assumes OPCODE_I1 sets it to 0
        top->instr = OPCODE_I1;
        top->eval();
        
        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->RegWrite, 0) << "Opcode: " << std::bitset<7>(opcode);
    }
}


TEST_F(ControlunitTestbench, ALUsrcTest)
{
    // ALUsrc = 1 (chooses immediate): I-type, U-type, J-type, S-type
    // ALUsrc = 0 (chooses rd2): R-type, B-type
    
    for (int opcode : { 
        OPCODE_I1, OPCODE_I2, OPCODE_I3, OPCODE_I4, 
        OPCODE_U1, OPCODE_U2, OPCODE_J, OPCODE_S
    }) {
        top->instr = OPCODE_R;
        top->eval();

        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->ALUsrc, 1) << "Opcode: " << std::bitset<7>(opcode);
    }

    for (int opcode : { OPCODE_R, OPCODE_B }) 
    {
        top->instr = OPCODE_I1;
        top->eval();
        
        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->ALUsrc, 0) << "Opcode: " << std::bitset<7>(opcode);
    }
}


TEST_F(ControlunitTestbench, PCsrcTest)
{
    // PCsrc = 1: FLAG_ZERO & (B-Type or J-type)
    // Pcsrc = 0: Otherwise
    
    top->EQ = 1;
    top->instr = OPCODE_B;
    top->eval();

    EXPECT_EQ(top->PCsrc, 1) << "Test 1";
    
    top->EQ = 1;
    top->instr = OPCODE_J;
    top->eval();

    EXPECT_EQ(top->PCsrc, 1) << "Test 2";
    
    // EQ is OFF now
    top->EQ = 0;
    top->instr = OPCODE_B;
    top->eval();

    EXPECT_EQ(top->PCsrc, 0) << "Test 3";
    
    // EQ is on but OPCODE is wrong now
    for (int opcode : { 
        OPCODE_I1, OPCODE_I2, OPCODE_I3, OPCODE_I4, 
        OPCODE_U1, OPCODE_U2, OPCODE_R, OPCODE_S
    }) {
        // Make sure PCsrc pulls DOWN instead of leave hanging
        top->EQ = 1;
        top->instr = OPCODE_B;
        top->eval();

        top->EQ = 1;
        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->PCsrc, 0) << "Opcode: " << std::bitset<7>(opcode);
    }
}


TEST_F(ControlunitTestbench, ImmSrc0Test)
{   
    // Checks the I instructions
    for (int opcode : { OPCODE_I1, OPCODE_I2, OPCODE_I3, OPCODE_I4 })
    {
        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->ImmSrc, 0) << "Opcode: " << std::bitset<7>(opcode);
    }
}


TEST_F(ControlunitTestbench, ImmSrc1Test)
{   
    // Checks the S instructions
    top->instr = OPCODE_S;
    top->eval();

    EXPECT_EQ(top->ImmSrc, 1);
}


TEST_F(ControlunitTestbench, ImmSrc2Test)
{   
    // Checks the B instructions
    top->instr = OPCODE_B;
    top->eval();

    EXPECT_EQ(top->ImmSrc, 2);
}


TEST_F(ControlunitTestbench, MemWriteTest)
{   
    // MemWrite = 1: all store instructions
    // MemWrite = 0: else

    top->instr = OPCODE_S;
    top->eval();

    EXPECT_EQ(top->MemWrite, 1) << "Opcode = OPCODE_S";

    for (int opcode : { 
        OPCODE_I1, OPCODE_I2, OPCODE_I3, OPCODE_I4, 
        OPCODE_U1, OPCODE_U2, OPCODE_J, OPCODE_R, OPCODE_J
    }) {
        // Make sure MemWrite pulls DOWN instead of leave hanging
        top->instr = OPCODE_S;
        top->eval();

        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->MemWrite, 0) << "Opcode: " << std::bitset<7>(opcode);
    }
}


TEST_F(ControlunitTestbench, ResultSrcTest)
{   
    // TODO : ResultSrc = 2: jal, jalr
    // ResultSrc = 1: all load instructions
    // ResultSrc = 0: else

    top->instr = OPCODE_I2;
    top->eval();

    EXPECT_EQ(top->ResultSrc, 1) << "Opcode = OPCODE_I2";

    for (int opcode : { 
        OPCODE_I1, OPCODE_I4, 
        OPCODE_U1, OPCODE_U2, OPCODE_R
    }) {
        // Make sure ResultSrc pulls DOWN instead of leave hanging
        top->instr = OPCODE_I2;
        top->eval();

        top->instr = opcode;
        top->eval();

        EXPECT_EQ(top->ResultSrc, 0) << "Opcode: " << std::bitset<7>(opcode);
    }
}


int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    testing::InitGoogleTest(&argc, argv);
    Verilated::mkdir("logs");
    auto res = RUN_ALL_TESTS();
    VerilatedCov::write(
        ("logs/coverage_" + std::string(NAME) + ".dat").c_str()
    );

    return res;
}
/*
 *  Verifies the results of the ALU and exits with a 0 on success
 *  Author: Noam Weitzman <nw521@ic.ac.uk>
*/

#include "base_testbench.h"

#define NAME            "alu"

#define OPCODE_ADD      0b0000
#define OPCODE_SUB      0b0001
#define OPCODE_AND      0b0010
#define OPCODE_OR       0b0011
#define OPCODE_XOR      0b0100
#define OPCODE_LSL      0b0101
#define OPCODE_LSR      0b0110
#define OPCODE_ASR      0b0111
#define OPCODE_SLT      0b1000
#define OPCODE_B        0b1001

class ALUTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->a = 0;
        top->b = 0;
        top->ALUctrl = 0;

        // output logic                EQ,
        // output logic [WIDTH - 1:0]  ALUout
    }
};


TEST_F(ALUTestbench, AdditionTest)
{
    int op1 = 5;
    int op2 = 10;
    
    //inputs for addition operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_ADD;

    top->eval();

    //check the ALU output and EQ signal for addition
    EXPECT_EQ(top->ALUout, op1 + op2);
    EXPECT_EQ(top->EQ, op1 + op2 == 0);
}


TEST_F(ALUTestbench, SubtractionTest)
{
    int op1 = 5;
    int op2 = 5;
    
    //inputs for subtraction operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_SUB;

    top->eval();

    //check the ALU output and EQ signal for subtraction
    EXPECT_EQ(top->ALUout, op1 - op2);
    EXPECT_EQ(top->EQ, op1 - op2 == 0);
}


TEST_F(ALUTestbench, BinaryAndTest)
{
    int op1 = 0b0110;
    int op2 = 0b0101;
    
    //inputs for binary AND operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_AND;

    top->eval();

    //check the ALU output and EQ signal for AND
    EXPECT_EQ(top->ALUout, op1 & op2);
    EXPECT_EQ(top->EQ, (op1 & op2) == 0);
}


TEST_F(ALUTestbench, BinaryOrTest)
{
    int op1 = 0b0110;
    int op2 = 0b0101;
    
    //inputs for binary OR operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_OR;

    top->eval();

    //check the ALU output and EQ signal for OR
    EXPECT_EQ(top->ALUout, op1 | op2);
    EXPECT_EQ(top->EQ, (op1 | op2) == 0);
}


TEST_F(ALUTestbench, BinaryXorTest)
{
    int op1 = 0b0110;
    int op2 = 0b0101;
    
    //inputs for binary XOR operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_XOR;

    top->eval();

    //check the ALU output and EQ signal for XOR
    EXPECT_EQ(top->ALUout, op1 ^ op2);
    EXPECT_EQ(top->EQ, (op1 ^ op2) == 0);
}


TEST_F(ALUTestbench, LogicalShiftLeftTest)
{
    int op1 = 0b0110;
    int op2 = 4;
    
    //inputs for LSL operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_LSL;

    top->eval();

    //check the ALU output and EQ signal for LSL
    EXPECT_EQ(top->ALUout, op1 << op2);
    EXPECT_EQ(top->EQ, (op1 << op2) == 0);
}


TEST_F(ALUTestbench, LogicalShiftRightTest)
{
    unsigned int op1 = 0b0110;
    unsigned int op2 = 4;
    
    //inputs for LSR operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_LSR;

    top->eval();

    //check the ALU output and EQ signal for LSR
    EXPECT_EQ(top->ALUout, op1 >> op2);
    EXPECT_EQ(top->EQ, (op1>> op2) == 0);
}

TEST_F(ALUTestbench, ASRTest)
{
    int op1 = 0xffffd8f1;
    int op2 = 0x5;
    
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_ASR;

    top->eval();

    EXPECT_EQ((int)top->ALUout, op1 >> op2);
    EXPECT_EQ(top->EQ, op2 == 0);
}


TEST_F(ALUTestbench, SetIfLessThanTest)
{
    int op1 = 0b0110;
    int op2 = 0b0101;
    
    //inputs for binary SLT operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_SLT;

    top->eval();

    //check the ALU output and EQ signal for SLT
    EXPECT_EQ(top->ALUout, (op1 < op2) ? 1 : 0);
    EXPECT_EQ(top->EQ, (op1 < op2) == 0);
}


TEST_F(ALUTestbench, LoadUpperImmTest)
{
    int op1 = 0b0110;
    int op2 = 0b1101;
    
    //inputs for LUI operation
    top->a = op1;
    top->b = op2;
    top->ALUctrl = OPCODE_B;

    top->eval();

    //check the ALU output and EQ signal for LUI
    EXPECT_EQ(top->ALUout, op2);
    EXPECT_EQ(top->EQ, op2 == 0);
}


int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    testing::InitGoogleTest(&argc, argv);
    Verilated::mkdir("logs");
    auto res = RUN_ALL_TESTS();
    VerilatedCov::write(("logs/coverage_" + std::string(NAME) + ".dat").c_str());

    return res;
}

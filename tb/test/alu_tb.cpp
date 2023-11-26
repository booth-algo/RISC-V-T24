/*
 *  Verifies the results of the ALU and exits with a 0 on success
 *  Author: Noam Weitzman <nw521@ic.ac.uk>
*/

#include "base_testbench.h"

#define NAME            "alu"
#define OPCODE_ADD      0b000
#define OPCODE_SUB      0b001

class ALUTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->ALUop1 = 0;
        top->ALUop2 = 0;
        top->ALUctrl = 0;
        top->regOp2 = 0;
        top->ImmOp = 0;
        top->ALUsrc = 0;
    }
};

TEST_F(ALUTestbench, AdditionTest)
{
    //inputs for addition operation
    top->ALUop1 = 5;
    top->ALUctrl = OPCODE_ADD;
    top->regOp2 = 10;
    top->ImmOp = 0;
    top->ALUsrc = 0;

    top->eval();

    //check the ALU output and EQ signal for addition
    EXPECT_EQ(top->ALUout, 15);
    EXPECT_EQ(top->EQ, 0);
}


TEST_F(ALUTestbench, SubtractionTest)
{
    //inputs for subtraction operation
    top->ALUop1 = 5;
    top->ALUctrl = OPCODE_SUB;
    top->regOp2 = 5;
    top->ImmOp = 0;
    top->ALUsrc = 0;

    top->eval();

    //check the ALU output and EQ signal for subtraction
    EXPECT_EQ(top->ALUout, 0);
    EXPECT_EQ(top->EQ, 1);
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

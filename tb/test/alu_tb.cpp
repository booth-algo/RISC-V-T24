/*
 *  Verifies the results of the ALU and exits with a 0 on success
 *  Author: Noam Weitzman <nw521@ic.ac.uk>
*/

#include "base_testbench.h"

#define NAME            "alu"
#define OPCODE_ADD      0b000
#define OPCODE_SUB      0b001
#define OPCODE_AND      0b010
#define OPCODE_OR       0b011
#define OPCODE_SLT      0b111

class ALUTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->ALUop1 = 0;
        top->ALUctrl = 0;
        top->regOp2 = 0;
        top->ImmOp = 0;
        top->ALUsrc = 0;

        // output logic                EQ,
        // output logic [WIDTH - 1:0]  ALUout
    }
};


TEST_F(ALUTestbench, AdditionTest)
{
    int op1 = 5;
    int op2 = 10;
    
    //inputs for addition operation
    top->ALUop1 = op1;
    top->ALUctrl = OPCODE_ADD;
    top->regOp2 = op2;
    top->ImmOp = 0;
    top->ALUsrc = 0;

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
    top->ALUop1 = op1;
    top->ALUctrl = OPCODE_SUB;
    top->regOp2 = op2;
    top->ImmOp = 0;
    top->ALUsrc = 0;

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
    top->ALUop1 = op1;
    top->ALUctrl = OPCODE_AND;
    top->regOp2 = op2;
    top->ImmOp = 0;
    top->ALUsrc = 0;

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
    top->ALUop1 = op1;
    top->ALUctrl = OPCODE_OR;
    top->regOp2 = op2;
    top->ImmOp = 0;
    top->ALUsrc = 0;

    top->eval();

    //check the ALU output and EQ signal for OR
    EXPECT_EQ(top->ALUout, op1 | op2);
    EXPECT_EQ(top->EQ, (op1 | op2) == 0);
}


TEST_F(ALUTestbench, SetIfLessThanTest)
{
    int op1 = 0b0110;
    int op2 = 0b0101;
    
    //inputs for binary SLT operation
    top->ALUop1 = op1;
    top->ALUctrl = OPCODE_OR;
    top->regOp2 = op2;
    top->ImmOp = 0;
    top->ALUsrc = 0;

    top->eval();

    //check the ALU output and EQ signal for SLT
    EXPECT_EQ(top->ALUout, (op1 < op2) ? 1 : 0);
    EXPECT_EQ(top->EQ, (op1 < op2) == 0);
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

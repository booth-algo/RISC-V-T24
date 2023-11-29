/*
 *  Verifies the results of the instruction memory, exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "base_testbench.h"

#define NAME            "instrmem"


class InstrMemTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->A = 0;
    }
};


TEST_F(InstrMemTestbench, InstructionExistsTest)
{    
    top->eval();
    EXPECT_NE(top->RD, 0);
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
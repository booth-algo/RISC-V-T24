/*
 *  Verifies the results of the CPU for F1 lights program and exits with a 0 on success.
 *  Author: Kevin Lau <khl22@ic.ac.uk>
*/

#include "sync_testbench.h"
#include <cstdlib>

#define NAME            "top"


class CpuTestbench : public SyncTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 1;
        top->rst = 0;

        // We compile the program here, so the whole thing can use it.
        system("./compile.sh --input asm/f1_lights.s");
    }
};


TEST_F(CpuTestbench, InitialStateTest)
{
    top->eval();
    
    EXPECT_EQ(top->clk, 1);
    EXPECT_EQ(top->rst, 0);
    EXPECT_EQ(top->a0, 0);
}

/*  Archived test for later
TEST_F(CpuTestbench, ResetStateTest)
{
    // Can be random number
    runSimulation(60);

    top->rst = 1;
    runSimulation(1);

    EXPECT_EQ(top->a0, 0);
}
*/

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
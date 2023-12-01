/*
 *  Verifies the results of various unit tests
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "sync_testbench.h"
#include <cstdlib>

#define NAME            "top-instr"


class CpuTestbench : public SyncTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 1;
        top->rst = 0;
    }
};


TEST_F(CpuTestbench, PositiveAdditionIsCorrectTest)
{
    system("./compile.sh --input asm/1-add_positive.s");
    
    runSimulation(200);
    
    EXPECT_EQ(top->a0, 246);
}


TEST_F(CpuTestbench, PositiveAdditionIsCorrect2Test)
{
    system("./compile.sh --input c/1-add_positive.c");
    
    runSimulation(200);
    
    EXPECT_EQ(top->a0, 246);
}


TEST_F(CpuTestbench, NegativeAdditionIsCorrectTest)
{
    system("./compile.sh --input asm/2-add_negative.s");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, -246);
}


TEST_F(CpuTestbench, DataMemoryIsCorrectTest)
{
    system("./compile.sh --input asm/3-load_and_store.s");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, -122);
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
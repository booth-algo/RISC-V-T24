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


TEST_F(CpuTestbench, PositiveAdditionTest)
{
    system("./compile.sh --input asm/001-add_positive.s");
    
    runSimulation(200);
    
    EXPECT_EQ(top->a0, 246);
}


TEST_F(CpuTestbench, PositiveAddition2Test)
{
    system("./compile.sh --input c/001-add_positive.c");
    
    runSimulation(200);
    
    EXPECT_EQ(top->a0, 246);
}


TEST_F(CpuTestbench, NegativeAdditionTest)
{
    system("./compile.sh --input asm/002-add_negative.s");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, -246);
}


TEST_F(CpuTestbench, DataMemoryIsCorrectTest)
{
    system("./compile.sh --input asm/003-load_and_store.s");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, -122);
}


TEST_F(CpuTestbench, SubtractionTest)
{
    system("./compile.sh --input c/002-subtract.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 889);
}


TEST_F(CpuTestbench, XORTest)
{
    system("./compile.sh --input asm/004-xor.s");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 20);
}

TEST_F(CpuTestbench, XORTest2)
{
    system("./compile.sh --input c/003-xor.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 7942);
}


// TEST_F(CpuTestbench, ORTest)
// {
//     system("./compile.sh --input c/004-or.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 8191);
// }


// TEST_F(CpuTestbench, ShiftTest)
// {
//     system("./compile.sh --input c/005-shift_left_right.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 534);
// }


// TEST_F(CpuTestbench, SLTTest)
// {
//     system("./compile.sh --input c/006-slt.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 6);
// }


// TEST_F(CpuTestbench, WhileLoopTest)
// {
//     system("./compile.sh --input c/007-while_loop.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 460881);
// }


// TEST_F(CpuTestbench, ForLoopTest)
// {
//     system("./compile.sh --input c/008-for_loop.c");
    
//     runSimulation(2000);
    
//     EXPECT_EQ((int)top->a0, 5050);
// }


// TEST_F(CpuTestbench, FibonnaciTest)
// {
//     system("./compile.sh --input c/010-fibonnaci.c");
    
//     runSimulation(2000);
    
//     EXPECT_EQ((int)top->a0, 832040);
// }


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
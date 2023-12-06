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
    system("./compile.sh --input c/003-xor.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 7942);
}


TEST_F(CpuTestbench, ORTest)
{
    system("./compile.sh --input c/004-or.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 8191);
}


TEST_F(CpuTestbench, SLLTest)
{
    system("./compile.sh --input c/005-sll.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 74496);
}


TEST_F(CpuTestbench, SRLTest)
{
    system("./compile.sh --input c/006-srl.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 4658);
}


TEST_F(CpuTestbench, SRATest)
{
    system("./compile.sh --input c/007-sra.c");
    
     runSimulation(200);
    
    EXPECT_EQ((int)top->a0, -1250);
}


TEST_F(CpuTestbench, SLTTest)
{
    system("./compile.sh --input c/008-slt.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 1);
}


TEST_F(CpuTestbench, LUITest)
{
    system("./compile.sh --input c/010-lui.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 17257);
}

/*
*   No test at the moment for auipc
*/

TEST_F(CpuTestbench, BEQTest)
{
    system("./compile.sh --input c/012-beq.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 1);
}


TEST_F(CpuTestbench, BNETest)
{
    system("./compile.sh --input c/013-bne.c");
    
    runSimulation(2000);
    
    EXPECT_EQ((int)top->a0, 50);
}


TEST_F(CpuTestbench, BLTTest)
{
    system("./compile.sh --input c/014-blt.c");
    
    runSimulation(2000);
    
    EXPECT_EQ((int)top->a0, 273);
}


TEST_F(CpuTestbench, BGETest)
{
    system("./compile.sh --input c/015-bge.c");
    
    runSimulation(2000);
    
    EXPECT_EQ((int)top->a0, 300);
}


TEST_F(CpuTestbench, BLTUTest)
{
    system("./compile.sh --input c/016-bltu.c");
    
    runSimulation(300);
    
    EXPECT_EQ((int)top->a0, 0);
}


TEST_F(CpuTestbench, ForLoopTest)
{
    system("./compile.sh --input c/018-for_loop.c");
    
    runSimulation(2000);
    
    EXPECT_EQ((int)top->a0, 5050);
}


TEST_F(CpuTestbench, JALRTest)
{
    system("./compile.sh --input c/019-jalr.c");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, 4096);
}


TEST_F(CpuTestbench, FibonnaciTest)
{
    system("./compile.sh --input c/020-fibonnaci.c");
    
    runSimulation(50000);
    
    EXPECT_EQ((int)top->a0, 55);
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
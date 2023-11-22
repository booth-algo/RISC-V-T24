/*
 *  Verifies the results of the program counter and exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "sync_testbench.h"

#define NAME            "cpu"


class PCTestbench : public SyncTestbench
{
    void initializeInputs()
    {
        top->clk = 1;
        top->rst = 0;
        top->PCsrc = 0;
        top->ImmOp = 0;
    }
};


TEST_F(PCTestbench, InitialStateTest)
{
    EXPECT_EQ(top->PC, 0x0000);
}


TEST_F(PCTestbench, ResetStateTest)
{
    // Can be random number
    runSimulation(60);

    top->rst = 1;
    runSimulation(1);

    EXPECT_EQ(top->PC, 0);
}


TEST_F(PCTestbench, PCSrcEqualsZeroTest)
{
    // Can be random number
    runSimulation(60);

    int PC = top->PC;

    top->PCsrc = 0;
    runSimulation(1);

    EXPECT_EQ(top->PC, PC + 4);             // Uses byte addressing
}

TEST_F(PCTestbench, PCSrcEqualsOneAndImmSrcWorksTest)
{
    // Can be random number
    runSimulation(60);

    // Also can be random number
    int immediate = 45;

    int branchPC = top->PC + immediate;
    
    top->ImmOp = immediate;
    top->PCsrc = 1;
    
    runSimulation(1);

    EXPECT_EQ(top->PC, branchPC);
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
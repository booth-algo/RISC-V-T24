/*
 *  Verifies the results of the program counter and exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "sync_testbench.h"

#define NAME            "program_counter"


class PCTestbench : public SyncTestbench
{
    void initializeInputs()
    {
        top->clk = 1;
        top->rst = 0;
        top->stall = 0;
        top->PCnext = 0;
        
        // output logic [WIDTH-1:0] PC
    }
};


TEST_F(PCTestbench, InitialStateTest)
{
    EXPECT_EQ(top->PC, 0x0000);
}


TEST_F(PCTestbench, ResetStateTest)
{
    // Can be random number
    top->PCnext = 0x5555'5555;
    runSimulation(60);

    top->rst = 1;
    runSimulation(1);

    EXPECT_EQ(top->PC, 0);
}


TEST_F(PCTestbench, StallTest)
{
    top->PCnext = 0xAAAA'AAAA;
    runSimulation(2);

    top->PCnext = 0x1234;
    top->stall = 1;

    // Can be random number
    runSimulation(100);

    // PC doesn't change as it is stalled
    EXPECT_EQ(top->PC, 0xAAAA'AAAA);
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
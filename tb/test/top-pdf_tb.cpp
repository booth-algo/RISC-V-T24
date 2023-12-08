/*
 *  Verifies the results of the CPU and exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "sync_testbench.h"
#include <iostream>
#include <cstdlib>

#define NAME            "top-pdf"


class CpuTestbench : public SyncTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 1;
        top->rst = 0;

        // We compile the program here, so the whole thing can use it.
        system("./compile.sh --input asm/pdf.s");
    }
};


TEST_F(CpuTestbench, InitialStateTest)
{
    // Before the simulation takes place, place correct data in right place
    system("cp data/gaussian.mem ../rtl");

    for (int i = 0; i < 10000; ++i)
    {
        runSimulation(1);
        if (top->a0 != 0)
        {
            std::cout << top->a0 << std::endl;
        }
    }

    SUCCEED();
}


int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    testing::InitGoogleTest(&argc, argv);
    Verilated::mkdir("logs");
    auto res = RUN_ALL_TESTS();
    
    return res;
}
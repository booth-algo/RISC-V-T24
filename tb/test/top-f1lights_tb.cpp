/*
 *  Verifies the results of the CPU for F1 lights program
 *  Author: Kevin Lau <khl22@ic.ac.uk>
*/

#include "sync_testbench.h"

#define NAME            "top-f1lights"


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



TEST_F(CpuTestbench, LoopTest)
{
    int max_cycles = 1000;

    for (int i = 0; i < max_cycles; ++i)
    {
        runSimulation(); // Evaluate the model

        // Checking for subroutine execution (e.g., a0 reaching 0xff)
        if (top->a0 == 0xff) // Subroutine's final value
        {
            // Check if loop continues by resetting a0 and observing it in subsequent cycles
            top->a0 = 0;
        }
        else if (top->a0 != 0)
        {
            SUCCEED(); // Indicates the loop has iterated at least once
            return;
        }

        top->clk = !top->clk; // Toggle the clock
    }

    FAIL() << "The iloop did not demonstrate expected behavior within " << max_cycles << " cycles.";
}


TEST_F(CpuTestbench, SubroutineFinalValueTest)
{
    int max_cycles = 1000; // Define a maximum number of cycles to simulate

    for (int i = 0; i < max_cycles; ++i)
    {
        runSimulation(); // Evaluate the model

        if (top->a0 == 0x7f) // Check if a0 has the correct final value
        {
            SUCCEED();
            return;
        }
    }

    FAIL() << "The register a0 did not reach the expected value within " << max_cycles << " cycles.";
}


int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    testing::InitGoogleTest(&argc, argv);
    Verilated::mkdir("logs");
    auto res = RUN_ALL_TESTS();
    
    // VerilatedCov::write(
    //     ("logs/coverage_" + std::string(NAME) + ".dat").c_str()
    // );

    return res;
}
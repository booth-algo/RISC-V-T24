/*
 *  Verifies the results of the CPU and exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "sync_testbench.h"
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
    runSimulation(1000);
    SUCCEED();
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
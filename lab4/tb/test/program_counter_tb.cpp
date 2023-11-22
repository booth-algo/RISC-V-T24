/*
 *  Verifies the results of the program counter and exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "Vdut.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "gtest/gtest.h"

#define MAX_SIM_CYCLES  10000
#define NAME            "program_counter"

class PCTestbench : public ::testing::Test
{
protected:
    Vdut* top;

    void SetUp() override
    {
        // Init top verilog instance
        top = new Vdut;

        // Init trace dump
        Verilated::traceEverOn(true);
        tfp = new VerilatedVcdC;
        top->trace(tfp, 99);
        tfp->open("waveform.vcd");

        initializeInputs();
    }

    void TearDown() override
    {
        top->final();
        tfp->close();

        delete top;
        delete tfp;
    }

    void initializeInputs()
    {
        top->clk = 1;
        top->rst = 0;
        top->PCsrc = 0;
        top->ImmOp = 0;
    }

    void runSimulation(int num_cycles = 1)
    {
        // Run simuation for many clock cycles
        for (int i = 0; i < num_cycles; ++i)
        {
            // dump variables into VCD file and toggle clock
            for (int clk = 0; clk < 2; ++clk)
            {
                tfp->dump(2*ticks + clk);    // picoseconds
                top->clk = !top->clk;
                top->eval();
            }

            ticks++;

            if (Verilated::gotFinish())
            {
                exit(0);
            }
        }
    }

private:
    VerilatedVcdC* tfp;
    int ticks;
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
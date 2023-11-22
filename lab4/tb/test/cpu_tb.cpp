/*
 *  Verifies the results of the CPU and exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "Vcpu.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "gtest/gtest.h"

#define MAX_SIM_CYCLES  10000


class CpuTestbench : public ::testing::Test
{
protected:
    Vcpu* top;

    void SetUp() override
    {
        // Init top verilog instance
        top = new Vcpu;

        // Init trace dump
        Verilated::traceEverOn(true);
        tfp = new VerilatedVcdC;
        top->trace(tfp, 99);
        tfp->open("logs/waveform.vcd");

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


TEST_F(CpuTestbench, InitialStateTest)
{
    EXPECT_EQ(top->clk, 1);
    EXPECT_EQ(top->rst, 0);
    EXPECT_EQ(top->a0, 0);
}


TEST_F(CpuTestbench, ResetStateTest)
{
    // Can be random number
    runSimulation(60);

    top->rst = 1;
    runSimulation(1);

    EXPECT_EQ(top->a0, 0);
}


TEST_F(CpuTestbench, CounterGetsTo1)
{
    for (int i = 0; i < MAX_SIM_CYCLES; ++i)
    {
        runSimulation(1);
        
        if (top->a0 == 1)
        {
            SUCCEED();
            return;
        }
        else if (top->a0 > 1)
        {
            FAIL() << "a0 exceeded 1 at sim cycle " << i;
            return;
        }
        else
        {
            /* Do nothing */
        }
    }
    
    FAIL() << "a0 did not reach 1 within the maximum number of sim cycles";
}


TEST_F(CpuTestbench, CounterGetsTo254)
{
    for (int i = 0; i < MAX_SIM_CYCLES; ++i)
    {
        runSimulation(1);
        
        if (top->a0 == 254)
        {
            SUCCEED();
            return;
        }
    }
    
    FAIL() << "a0 did not reach 254 within the maximum number of sim cycles";
}


TEST_F(CpuTestbench, CounterResetsAfter254)
{
    int cycles_at_254;

    for (int i = 0; i < MAX_SIM_CYCLES; ++i)
    {
        runSimulation(1);
        
        if (top->a0 == 254)
        {
            cycles_at_254++;
        }
        else if (top->a0 > 254)
        {
            FAIL() << "a0 exceeded 254 at simulation cycle" << i;
            return;
        }
    }
    
    FAIL() << "a0 did not reset after 254";
}


int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    testing::InitGoogleTest(&argc, argv);
    Verilated::mkdir("logs");
    auto res = RUN_ALL_TESTS();
    VerilatedCov::write("logs/coverage_cpu.dat");

    return res;
}
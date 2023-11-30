/*
 *  Verifies the results of the regfile and exits with a 0 on success.
 *
 *  ADDITIONAL INFORMATION ----------------------------------------------------
 * 
 *  The register file is a asynchronous dual port read and synchronous write.
 *  ---------------------------------------------------------------------------
 * 
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "sync_testbench.h"

#define NAME            "regfile"


class RegfileTestbench : public SyncTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 1;
        
        top->AD1 = 0;
        top->AD2 = 0;
        top->AD3 = 0;
        top->WE3 = 0;
        top->WD3 = 0;

        // output logic [WIDTH - 1:0] RD1,
        // output logic [WIDTH - 1:0] RD2,
        // output logic [WIDTH - 1:0] a0
    }
};


TEST_F(RegfileTestbench, RegZeroHardWiredTest)
{
    int randomNumber = 0x12345678;

    // Modify x0 (zero)
    top->AD3 = 1;
    top->WD3 = randomNumber;
    top->WE3 = 1;

    runSimulation(1);
    
    // Both dual ports looking for x0
    top->AD1 = 0;
    top->AD2 = 0;

    runSimulation(1);

    EXPECT_EQ(top->RD1, 0);
    EXPECT_EQ(top->RD2, 0);
}


TEST_F(RegfileTestbench, AllRegsFunctionTest)
{
    int randomNumber = 0x12345678;

    // Modify x0 (zero)
    top->WD3 = randomNumber;
    top->WE3 = 1;

    for (int i = 1; i < 32; ++i)
    {
        top->AD3 = i;
        runSimulation(1);
        
        // Both dual ports looking for x_i
        top->AD1 = i;
        top->AD2 = i;

        runSimulation(1);

        EXPECT_EQ(top->RD1, randomNumber);
        EXPECT_EQ(top->RD2, randomNumber);
    }
}


TEST_F(RegfileTestbench, a0FunctionTest)
{
    int randomNumber = 0x12345678;

    // Modify a0 (x10)
    top->AD3 = 10;
    top->WD3 = randomNumber;
    top->WE3 = 1;

    runSimulation(1);
    
    EXPECT_EQ(top->a0, randomNumber);
}


TEST_F(RegfileTestbench, asyncReadTest)
{
    int randomNumber = 0x12345678;

    // Modify a0 (x10)
    top->AD3 = 10;
    top->WD3 = randomNumber;
    top->WE3 = 1;

    runSimulation(1);

    top->AD1 = 10;
    top->AD2 = 10;

    // Async operation
    top->eval();
    
    EXPECT_EQ(top->RD1, randomNumber);
    EXPECT_EQ(top->RD2, randomNumber);
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
/*
 *  Verifies that the data memory reads and writes correctly
 *  Author: Kevin Lau <khl22@ic.ac.uk>
*/

#include "sync_testbench.h"

#define NAME            "data_mem"


class DataMemTestbench : public SyncTestbench
{

protected:
    void initializeInputs() override
    {
        top->A = 0;
        top->WD = 0;
        top->WE = 0;

    }
};

TEST_F(DataMemTestbench, WriteAndReadTest)
{
    top->A = 1;
    top->WD = 0x12345678;
    top->WE = 1;
    runSimulation(10);

    top->WE = 0;
    runSimulation(10);

    EXPECT_EQ(top->RD, 0x12345678);

    std::cout << "top->RD (hex): " 
            << std::setw(8) << std::setfill('0')
            << std::hex << top->RD 
            << std::endl;
}

TEST_F(DataMemTestbench, ReloadDataTest)
{
    top->A = 1;
    top->WD = 0x12345678;
    top->WE = 1;
    runSimulation(10);

    top->WE = 0;
    runSimulation(10);

    EXPECT_EQ(top->RD, 0x12345678);

    std::cout << "top->RD (hex): " 
            << std::setw(8) << std::setfill('0')
            << std::hex << top->RD 
            << std::endl;

    top->A = 1;
    top->WD = 0x87654321;
    top->WE = 1;
    runSimulation(10);

    top->WE = 0;
    runSimulation(10);

    EXPECT_EQ(top->RD, 0x87654321);

    std::cout << "top->RD (hex): " 
            << std::setw(8) << std::setfill('0')
            << std::hex << top->RD 
            << std::endl;
}

TEST_F(DataMemTestbench, MemoryInitTest)
{
    top->A = 2;
    runSimulation(10);

    EXPECT_EQ(top->RD, 0x00000000);

    std::cout << "top->RD (hex): "
            << std::setw(8) << std::setfill('0')
            << std::hex << top->RD
            << std::endl;
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
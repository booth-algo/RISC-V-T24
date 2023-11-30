/*
 *  Verifies the results of the mux, exits with a 0 on success.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "base_testbench.h"

#define NAME            "mux"


class MuxTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->sel = 0;
        top->in0 = 0;
        top->in1 = 0;
        // output: out
    }
};


TEST_F(MuxTestbench, Mux0WorksTest)
{
    top->sel = 0;
    top->in0 = 1;
    top->in1 = 0;
    
    top->eval();
    
    EXPECT_EQ(top->out, 1);
}


TEST_F(MuxTestbench, Mux1WorksTest)
{
    top->sel = 1;
    top->in0 = 0;
    top->in1 = 1;
    
    top->eval();
    
    EXPECT_EQ(top->out, 1);
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
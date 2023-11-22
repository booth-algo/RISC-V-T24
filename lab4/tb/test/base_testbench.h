/*
 *  Contains the important functions in order to write tests
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#ifndef BASE_TESTBENCH_H
#define BASE_TESTBENCH_H


#include "Vdut.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "gtest/gtest.h"


#define MAX_SIM_CYCLES  10000


class BaseTestbench : public ::testing::Test
{
protected:
    Vdut* top;
    VerilatedVcdC* tfp;

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

    virtual void initializeInputs() = 0;
};


#endif      /* BASE_TESTBENCH_H */

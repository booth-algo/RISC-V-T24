/*
 *  Verifies the results of various unit tests
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "sync_testbench.h"
#include <cstdlib>

#define NAME            "top-instr"


class CpuTestbench : public SyncTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 1;
        top->rst = 0;
    }
};


TEST_F(CpuTestbench, PositiveAdditionTest)
{
    system("./compile.sh --input asm/001-add_positive.s");
    
    runSimulation(200);
    
    EXPECT_EQ(top->a0, 246);
}


TEST_F(CpuTestbench, PositiveAddition2Test)
{
    system("./compile.sh --input c/001-add_positive.c");
    
    runSimulation(200);
    
    EXPECT_EQ(top->a0, 246);
}


TEST_F(CpuTestbench, NegativeAdditionTest)
{
    system("./compile.sh --input asm/002-add_negative.s");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, -246);
}


TEST_F(CpuTestbench, DataMemoryIsCorrectTest)
{
    system("./compile.sh --input asm/003-load_and_store.s");
    
    runSimulation(200);
    
    EXPECT_EQ((int)top->a0, -122);
}


// TEST_F(CpuTestbench, SubtractionTest)
// {
//     system("./compile.sh --input c/002-subtract.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 889);
// }


// TEST_F(CpuTestbench, XORTest)
// {
//     system("./compile.sh --input c/003-xor.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 7942);
// }


// TEST_F(CpuTestbench, ORTest)
// {
//     system("./compile.sh --input c/004-or.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 8191);
// }


// TEST_F(CpuTestbench, SLLTest)
// {
//     system("./compile.sh --input c/005-sll.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 74496);
// }


// TEST_F(CpuTestbench, SRLTest)
// {
//     system("./compile.sh --input c/006-srl.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 4658);
// }


// TEST_F(CpuTestbench, SRATest)
// {
//     system("./compile.sh --input c/007-sra.c");
    
//      runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, -1250);
// }


// TEST_F(CpuTestbench, SLTTest)
// {
//     system("./compile.sh --input c/008-slt.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 1);
// }


// TEST_F(CpuTestbench, LUITest)
// {
//     system("./compile.sh --input c/010-lui.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 17257);
// }

// /*
// *   No test at the moment for auipc
// */

// TEST_F(CpuTestbench, BEQTest)
// {
//     system("./compile.sh --input c/012-beq.c");
    
//     runSimulation(200);
    
//     EXPECT_EQ((int)top->a0, 1);
// }


// TEST_F(CpuTestbench, BNETest)
// {
//     system("./compile.sh --input c/013-bne.c");
    
//     runSimulation(2000);
    
//     EXPECT_EQ((int)top->a0, 50);
// }


// TEST_F(CpuTestbench, BLTTest)
// {
//     system("./compile.sh --input c/014-blt.c");
    
//     runSimulation(20000);
    
//     EXPECT_EQ((int)top->a0, 273);
// }


// TEST_F(CpuTestbench, BGETest)
// {
//     system("./compile.sh --input c/015-bge.c");
    
//     runSimulation(20000);
    
//     EXPECT_EQ((int)top->a0, 300);
// }


// TEST_F(CpuTestbench, BLTUTest)
// {
//     system("./compile.sh --input c/016-bltu.c");
    
//     runSimulation(20000);
    
//     EXPECT_EQ((int)top->a0, 0);
// }


// TEST_F(CpuTestbench, ForLoopTest)
// {
//     system("./compile.sh --input c/018-for_loop.c");
    
//     runSimulation(20000);
    
//     EXPECT_EQ((int)top->a0, 5050);
// }


// TEST_F(CpuTestbench, JALRTest)
// {
//     system("./compile.sh --input c/019-jalr.c");
    
//     runSimulation(20000);
    
//     EXPECT_EQ((int)top->a0, 2048);
// }


// TEST_F(CpuTestbench, FibonnaciTest)
// {
//     system("./compile.sh --input c/020-fibonnaci.c");
    
//     runSimulation(200000);
    
//     EXPECT_EQ((int)top->a0, 55);
// }


// TEST_F(CpuTestbench, LB_and_SB_Test)
// {
//     system("./compile.sh --input asm/006-lb-lbu-sb.s");
    
//     runSimulation(50000);
    
//     EXPECT_EQ((int)top->a0, -122);
// }


// TEST_F(CpuTestbench, LB_and_SB_Test2)
// {
//     system("./compile.sh --input asm/007-lbu-sb.s");
    
//     runSimulation(50000);
    
//     EXPECT_EQ((int)top->a0, 134);
// }


// TEST_F(CpuTestbench, ByteArrayTest)
// {
//     system("./compile.sh --input c/021-byte_array.c");
    
//     runSimulation(5000);
    
//     EXPECT_EQ((int)top->a0, 255);
// }

// TEST_F(CpuTestbench, Combined)
// {
//     system("./compile.sh --input c/022-combined.c");
    
//     runSimulation(5000);
    
//     EXPECT_EQ((int)top->a0, 34);
// }

// TEST_F(CpuTestbench, LinkedListTest)
// {
//     system("./compile.sh --input c/023-linked_list.c");
    
//     runSimulation(50000);
    
//     EXPECT_EQ((int)top->a0, 158);
// }


// TEST_F(CpuTestbench, LwTest008)
// {
//     system("./compile.sh --input asm/008-lw_test_1.s");
    
//     runSimulation(50);
    
//     EXPECT_EQ((int)top->a0, 2);
// }


// TEST_F(CpuTestbench, PointerTest)
// {
//     system("./compile.sh --input c/024-pointer_deref.c");
    
//     runSimulation(50000);
    
//     EXPECT_EQ((int)top->a0, 17);
// }


// TEST_F(CpuTestbench, PDFTest)
// {
//     system("./compile.sh --input c/025-pdf.c");
    
//     runSimulation(100000);
    
//     EXPECT_EQ((int)top->a0, 2560);
// }

// TEST_F(CpuTestbench, dm_cache_test)
// {
//     system("./compile.sh --input asm/009-dm_cache.s");
    
//     runSimulation(100);
    
//     EXPECT_EQ((int)top->a0, 0);
// }

// TEST_F(CpuTestbench, cache_read_test)
// {
//     system("./compile.sh --input asm/010-dm_cache_read.s");
    
//     runSimulation(50);
    
//     EXPECT_EQ((int)top->a0, 0);
// }

// TEST_F(CpuTestbench, cache_write_test)
// {
//     system("./compile.sh --input asm/011-dm_cache_write.s");
    
//     runSimulation(50);
    
//     EXPECT_EQ((int)top->a0, 0);
// }

// TEST_F(CpuTestbench, cache_temporal_locality_test)
// {
//     system("./compile.sh --input asm/012-dm_cache_temp_locality.s");
    
//     runSimulation(50);
    
//     EXPECT_EQ((int)top->a0, 0);
// }

// TEST_F(CpuTestbench, overwrite_cache_test)
// {
//     system("./compile.sh --input asm/013-overwrite_byte.s");
    
//     runSimulation(100);
    
//     EXPECT_EQ((int)top->a0, 0x0403FFFF);
// }

// TEST_F(CpuTestbench, cache_endian_test)
// {
//     system("./compile.sh --input asm/014-endian.s");
    
//     runSimulation(50);
    
//     EXPECT_EQ((int)top->a0, 0x12);
// }

// TEST_F(CpuTestbench, cache_boundary_test)
// {
//     system("./compile.sh --input asm/015-boundary.s");
    
//     runSimulation(100);
    
//     EXPECT_EQ((int)top->a0, 0);
// }

// TEST_F(CpuTestbench, cache_coherence_test)
// {
//     system("./compile.sh --input asm/016-coherence.s");
    
//     runSimulation(100);
    
//     EXPECT_EQ((int)top->a0, 0x2);
// }

// TEST_F(CpuTestbench, cache_hazard_test)
// {
//     system("./compile.sh --input asm/017-cache_hazard.s");
    
//     runSimulation(100);
    
//     EXPECT_EQ((int)top->a0, 0x3);
// }

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    testing::InitGoogleTest(&argc, argv);
    Verilated::mkdir("logs");
    auto res = RUN_ALL_TESTS();

    return res;
}
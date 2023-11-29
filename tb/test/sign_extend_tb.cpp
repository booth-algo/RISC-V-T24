/*
 *  Verifies the results of the sign extender, exits with a 0 on success.
 *
 *  ADDITIONAL INFORMATION ----------------------------------------------------
 * 
 *  ImmSrc = 0 signifies an I-Type instruction (bits 31:20)
 *  ImmSrc = 1 signifies a S-Type instruction (bits 31:25 and 11:7).
 *  ImmSrc = 2 signifies a B-Type instruction (bits 31:25 and 11:7) arranged
 *  as [12][10:5] ... [4:1][11] + implied 0
 *  ---------------------------------------------------------------------------
 *  
 * Author: William Huynh <wh1022@ic.ac.uk>
*/

#include "base_testbench.h"
#include <random>

#define NAME            "sign_extend"


class SignextendTestbench : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->instr = 0;
        top->ImmSrc = 0;
    }
};


TEST_F(SignextendTestbench, ImmSrcEqualsZeroAndPositiveImmediateTest)
{
    // Seed the random number generator
    std::random_device rd;
    std::mt19937 gen(rd());

    // Generate a random positive 12-bit number
    std::uniform_int_distribution<int> twelveBitDist(0, 0x7FF);
    int randomImmediate = twelveBitDist(gen);

    // Generate a random 20-bit number
    std::uniform_int_distribution<int> twentyBitDist(0, 0xFFFFF);
    int randomNumbers = twelveBitDist(gen);
    
    int instruction = (randomImmediate << 20) + randomNumbers; 
    
    top->instr = instruction;
    top->ImmSrc = 0;

    top->eval();

    EXPECT_EQ(top->ImmOp, randomImmediate);
}


TEST_F(SignextendTestbench, ImmSrcEqualsZeroAndNegativeImmediateTest)
{
    // Seed the random number generator
    std::random_device rd;
    std::mt19937 gen(rd());

    // Generate a random negative 12-bit number
    std::uniform_int_distribution<int> twelveBitDist(0x800, 0xFFF);
    int randomImmediate = twelveBitDist(gen);

    // Generate a random 20-bit number
    std::uniform_int_distribution<int> twentyBitDist(0, 0xFFFFF);
    int randomNumbers = twelveBitDist(gen);
    
    int instruction = (randomImmediate << 20) + randomNumbers; 
    
    top->instr = instruction;
    top->ImmSrc = 0;
    
    top->eval();

    // Sign extend the 12-bit immediate to 32 bits
    int expectedImmOp = randomImmediate | 0xFFFFF000;

    EXPECT_EQ((int)top->ImmOp, expectedImmOp);
}


TEST_F(SignextendTestbench, ImmSrcEqualsOneAndPositiveImmediateTest)
{
    // Seed the random number generator
    std::random_device rd;
    std::mt19937 gen(rd());

    // Generate a random positive 12-bit number
    std::uniform_int_distribution<int> twelveBitDist(0, 0x7FF);
    int randomImmediate = twelveBitDist(gen);

    // Generate a random 20-bit number
    std::uniform_int_distribution<int> twentyBitDist(0, 0xFFFFF);
    int randomNumbers = twelveBitDist(gen);
    
    // Place upper 7 bits in 31:25, lower 5 bits in 11:7
    int instruction = ((randomNumbers & 0x01FFF07F) | 
                        ((randomImmediate & 0xFE0) << 20) | 
                        ((randomImmediate & 0x1F) << 7)
                    );
    
    top->instr = instruction;
    top->ImmSrc = 1;
    
    // Output the results
    std::cout << "Random 12-bit number (ImmSrc): " << std::bitset<12>(randomImmediate) << std::endl;
    std::cout << "Random 20-bit number: " << std::bitset<20>(randomNumbers) << std::endl;
    std::cout << "Combined instruction: " << std::bitset<32>(instruction) << std::endl;
    top->eval();

    EXPECT_EQ(top->ImmOp, randomImmediate);
}


TEST_F(SignextendTestbench, ImmSrcEqualsOneAndNegativeImmediateTest)
{
    // Seed the random number generator
    std::random_device rd;
    std::mt19937 gen(rd());

    // Generate a random positive 12-bit number
    std::uniform_int_distribution<int> twelveBitDist(0x800, 0xFFF);
    int randomImmediate = twelveBitDist(gen);

    // Generate a random 20-bit number
    std::uniform_int_distribution<int> twentyBitDist(0, 0xFFFFF);
    int randomNumbers = twelveBitDist(gen);
    
    // Place upper 7 bits in 31:25, lower 5 bits in 11:7
    int instruction = ((randomNumbers & 0x01FFF07F) | 
                        ((randomImmediate & 0xFE0) << 20) | 
                        ((randomImmediate & 0x1F) << 7)
                    );
    
    top->instr = instruction;
    top->ImmSrc = 1;

    top->eval();

    // Sign extend the 12-bit immediate to 32 bits
    int expectedImmOp = randomImmediate | 0xFFFFF000;

    EXPECT_EQ((int)top->ImmOp, expectedImmOp);
}


TEST_F(SignextendTestbench, ImmSrcEqualsTwoAndPositiveImmediateTest)
{
    // Seed the random number generator
    std::random_device rd;
    std::mt19937 gen(rd());

    // Generate a random positive 13-bit 
    std::uniform_int_distribution<int> thirteenBitDist(0, 0x0FFF);
    int randomImmediate = thirteenBitDist(gen) & 0x1FFE;

    // Generate a random 20-bit number
    std::uniform_int_distribution<int> twentyBitDist(0, 0xFFFFF);
    int randomNumbers = thirteenBitDist(gen);

    int bit12   =   (randomImmediate & 0b1'0000'0000'0000) >> 12;
    int bit11   =   (randomImmediate & 0b0'1000'0000'0000) >> 11;
    int bit10_5 =   (randomImmediate & 0b0'0111'1110'0000) >> 5;
    int bit4_1  =   (randomImmediate & 0b0'0000'0001'1110) >> 1;
    
    // Place bit 12 into bit 31, bits 10:5 into 30:25, 
    // bits 4:1 into 11:8, bit 11 into 7
    int instruction = ((randomNumbers & 0x01FFF07F) | 
                        (bit12 << 31) | 
                        (bit10_5 << 25) |
                        (bit4_1 << 8) |
                        (bit11 << 7)
                    );
    
    top->instr = instruction;
    top->ImmSrc = 2;
    
    top->eval();

    EXPECT_EQ(top->ImmOp, randomImmediate);
} 


TEST_F(SignextendTestbench, ImmSrcEqualsTwoAndNegativeImmediateTest)
{
    // Seed the random number generator
    std::random_device rd;
    std::mt19937 gen(rd());

    // Generate a random negative 13-bit 
    std::uniform_int_distribution<int> thirteenBitDist(-0x1000, -1);
    int randomImmediate = thirteenBitDist(gen) & 0x1FFE;

    // Generate a random 20-bit number
    std::uniform_int_distribution<int> twentyBitDist(0, 0xFFFFF);
    int randomNumbers = thirteenBitDist(gen);
    int bit12   =   (randomImmediate & 0b1'0000'0000'0000) >> 12;
    int bit11   =   (randomImmediate & 0b0'1000'0000'0000) >> 11;
    int bit10_5 =   (randomImmediate & 0b0'0111'1110'0000) >> 5;
    int bit4_1  =   (randomImmediate & 0b0'0000'0001'1110) >> 1;
    
    // Place bit 12 into bit 31, bits 10:5 into 30:25, 
    // bits 4:1 into 11:8, bit 11 into 7
    int instruction = ((randomNumbers & 0x01FFF07F) | 
                        (bit12 << 31) | 
                        (bit10_5 << 25) |
                        (bit4_1 << 8) |
                        (bit11 << 7)
                    );
    
    top->instr = instruction;
    top->ImmSrc = 2;

    top->eval();

    // Sign extend the 13-bit immediate to 32 bits
    int expectedImmOp = randomImmediate | 0xFFFFE000;    

    EXPECT_EQ((int)top->ImmOp, expectedImmOp);
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
/*
 *  Set less than test (slt, sltu, slti, sltiu)
 *  Author: William Huynh <wh0122@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int num1 = 10;
    int num2 = -24;

    // slt (set less than)
    int slt_result = (num1 < num2) ? 1 : 0;

    // sltu (set less than unsigned)
    int sltu_result = ((unsigned int)num1 < (unsigned int)num2) ? 1 : 0;

    // slti (set less than immediate)
    int slti_result = (num2 < 10) ? 1 : 0;

    // sltiu (set less than immediate unsigned)
    int sltiu_result = ((unsigned int)num2 < 30) ? 1 : 0;

    // Concatenate the bits
    int ans = (slt_result << 3) | 
                (sltu_result << 2) | 
                (slti_result << 1) | 
                sltiu_result;

#if !defined(__riscv)
    printf("slt: %d\n", slt_result);
    printf("sltu: %d\n", sltu_result);
    printf("slti: %d\n", slti_result);
    printf("sltiu: %d\n", sltiu_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 6
    return ans;
}
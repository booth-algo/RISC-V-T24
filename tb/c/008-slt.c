/*
 *  Set less than test (slt, slti)
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

    // slti (set less than immediate)
    int slti_result = (num2 < 10) ? 1 : 0;

    // Concatenate the bits
    int ans = (slt_result << 1) + slti_result;

#if !defined(__riscv)
    printf("slt: %d\n", slt_result);
    printf("slti: %d\n", slti_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 1
    return ans;
}
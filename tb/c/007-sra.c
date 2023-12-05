/*
 *  Bit shift test (sra, srai)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    // Negative number
    int num = -9999;
    int shift_amount = 5;

    // sra (arithmetic right shift)
    int sra_result = num >> shift_amount;

    // srai (arithmetic right shift immediate)
    int ans = num >> 3;  // Shift by a constant amount

#if !defined(__riscv)
    printf("sra: %d\n", sra_result);
    printf("ans: %d\n", (int)ans);
#endif

    // EXPECTED OUTPUT = -1250
    return ans;
}
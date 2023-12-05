/*
 *  Bit shift test (srl, srli)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    unsigned int num = 0x123213;
    int shift_amount = 5;

    // srl (logical right shift)
    unsigned int srl_result = num >> shift_amount;

    // srli (logical right shift immediate)
    unsigned int ans = srl_result >> 3;             // Shift by a constant amount

#if !defined(__riscv)
    printf("srl: %d\n", srl_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 4658
    return ans;
}
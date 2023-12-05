/*
 *  Bit shift test (sll, slli)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int num = 0x123;
    int shift_amount = 5;

    // sll (logical left shift)
    int sll_result = num << shift_amount;

    // slli (logical left shift immediate)
    int ans = sll_result << 3;             // Shift by a constant amount

#if !defined(__riscv)
    printf("sll: %d\n", sll_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 74496
    return ans;
}
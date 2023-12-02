/*
 *  Bit shift test (sll, srl, sra, slli, srli, srai)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int num = 42;
    int shift_amount = 2;

    // sll (logical left shift)
    int sll_result = num << shift_amount;

    // srl (logical right shift)
    int srl_result = num >> shift_amount;

    // sra (arithmetic right shift)
    int sra_result = ((unsigned int)num) >> shift_amount;

    // slli (logical left shift immediate)
    int slli_result = num << 3;             // Shift by a constant amount

    // srli (logical right shift immediate)
    int srli_result = num >> 3;             // Shift by a constant amount

    // srai (arithmetic right shift immediate)
    int srai_result = ((unsigned int)num) >> 3;  // Shift by a constant amount

    int ans = (sll_result + srl_result + sra_result 
                + slli_result + srli_result + srai_result);

#if !defined(__riscv)
    printf("sll: %d\n", sll_result);
    printf("srl: %d\n", srl_result);
    printf("sra: %d\n", sra_result);
    printf("slli: %d\n", slli_result);
    printf("srli: %d\n", srli_result);
    printf("srai: %d\n", srai_result);
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 534
    return ans;
}
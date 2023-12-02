/*
 *  XOR test (xor, xori).
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main()
{
    int num1 = 1234;
    int num2 = 4321;
    int num3 = 2345;
    
    int temp1 = num1 ^ num2 ^ num3;
    int ans = temp1 ^ 540;                      // xori instruction
    
#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 7942
    return ans;
}
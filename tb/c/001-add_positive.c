/*
 *  Addition test for positive numbers
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main()
{
    int num1 = 32;
    int num2 = 52;
    int num3 = 101;
    int num4 = 60;
    
    int ans = num1 + num2 + num3 + num4;
    ans += 1;                               // addi

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 246
    return ans;
}
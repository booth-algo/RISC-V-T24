/*
 *  Subtraction test (sub)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main()
{
    int num1 = 1000;
    int num2 = 100;
    int num3 = 10;
    int num4 = 1;
    
    int ans = num1 - num2 - num3 - num4;

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 889
    return ans;
}

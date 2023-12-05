/*
 *  For loop test. Calculates the sum of x from 0 to 100
 *  Author: William Huynh <wh0122@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int ans = 0;

    for (int i = 0; i <= 100; ++i)
    {
        ans += i;
    }

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 5050
    return ans;
}
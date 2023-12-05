/*
 *  While loop test (blt)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int ans = 0x200;
    
    // Test blt
    while (ans > 0x111) 
    {
        ans--;
    }

#if !defined(__riscv)
    // Print the array elements
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 273
    return ans;
}
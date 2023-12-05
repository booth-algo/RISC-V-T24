/*
 *  While loop test (bge)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int ans = 111;
    
    // Test bge
    while (ans >= 3) 
    {
        ans--;
    }

#if !defined(__riscv)
    // Print the array elements
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 2
    return ans;
}
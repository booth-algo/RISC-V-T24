/*
 *  While loop test (beq)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int ans = 0;
    
    // Test beq
    while (ans == 0) 
    {
        ans++;
    }

#if !defined(__riscv)
    // Print the array elements
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 1
    return ans;
}
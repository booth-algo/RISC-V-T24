/*
 *  While loop test (bltu)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int ans = -1;
    
    // Test bltu
    while ((unsigned int)ans >= 0x100) 
    {
        ans++;
    }

#if !defined(__riscv)
    // Print the array elements
    printf("ans: %d\n", ans);
#endif

    // EXPECTED OUTPUT = 0
    return ans;
}
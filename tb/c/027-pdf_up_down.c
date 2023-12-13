/*
 *  Sum of uniform distribution
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/


#if !defined(__riscv)
#include <stdio.h>
#endif

#define SIZE    256


int main() 
{
    unsigned char dataArray[SIZE];

    // Initialise
    for (int ptr = 0; ptr < SIZE; ++ptr)
    {
        dataArray[ptr] = 0;
    }
    
    for (int ptr = 0; ptr < SIZE; ++ptr)
    {
        dataArray[ptr] += 8;
    }

    for (int ptr = SIZE - 1; ptr >= 0; --ptr)
    {
        dataArray[ptr] += 8;
    }
    
    // Calculate sum
    int ans = 0;
    for (int ptr = 0; ptr < SIZE; ++ptr)
    {
        ans += dataArray[ptr];
    }

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 4096 (256 * 2 * 8)
    return ans;
}
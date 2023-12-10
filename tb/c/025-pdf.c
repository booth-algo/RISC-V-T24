/*
 *  Sum of uniform distribution
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/


#if !defined(__riscv)
#include <stdio.h>
#endif

#define SIZE    256
#define VAL     10


int main() 
{
    unsigned char dataArray[SIZE];

    // Initialise
    for (int ptr = 0; ptr < SIZE; ++ptr)
    {
        dataArray[ptr] = 0;
    }
    
    // Increment each val in array to VAL
    for (int i = 0; i < VAL; ++i)
    {
        for (int ptr = 0; ptr < SIZE; ++ptr)
        {
            dataArray[ptr]++;
        }
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

    // EXPECTED OUTPUT = 2560 (256 * 10)
    return ans;
}
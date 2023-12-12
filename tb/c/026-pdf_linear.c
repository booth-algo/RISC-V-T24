/*
 *  Sum of linear distribution
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
        for (int i = 0; i < ptr; ++i)
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

    // EXPECTED OUTPUT = 32640 (sum from 0 to 255 = 255*256/2)
    return ans;
}
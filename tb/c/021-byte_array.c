/*
 *  Test for byte arrays lb and sb.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/


#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int ans = 0;

    unsigned char byteArray[5] = {0x11, 0x22, 0x33, 0x44, 0x55};

    // Take the sum
    for (int i = 0; i < 5; ++i)
    {
        ans += byteArray[i];
    }

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 255
    return ans;
}
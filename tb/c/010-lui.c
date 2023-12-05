/*
 *  For lui test
 *  Author: Noam Weitzman <nw521@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main()
{
    int var = 0x4369;

#if !defined(__riscv)
    printf("%d\n", var);
#endif

    // EXPECTED OUTPUT = 17257
    return var;
}
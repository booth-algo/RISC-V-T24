/*
 *  Test for pointers
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#define MAX_NODES   100

#if !defined(__riscv)
#include <stdio.h>
#else

// entry point (0x0): compiler places earlier functions lower in memory.
int main();


void _start()
{
    main();

    // Infinite loop to prevent undefined access to memory
    while (1) {}
}

#endif


int main() 
{
    char a = 0x11;

    char* aPtr = &a; 
    
    char ans = *aPtr;

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 17
    return ans;
}
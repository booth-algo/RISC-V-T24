/*
 *  Test for nested function calling.
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/


#if !defined(__riscv)
#include <stdio.h>
#else

// entry point (0x0): compiler places earlier functions lower in memory.
void _start()
{
    main();

    // Infinite loop to prevent undefined access to memory
    while (1) {}
}

#endif


int fib(int n)
{
    if (n == 0)
        return 0; 
    else if (n == 1 || n == 2) 
        return 1;
    else
        return fib(n-1) + fib(n-2);
}


int main() 
{
    int ans = fib(10);

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 832040
    return ans;
}
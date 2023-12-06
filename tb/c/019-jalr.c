/*
 *  Test jalr. Test if function calling works.
 *  Note: jal already exists in 018
 * 
 *  Author: William Huynh <wh0122@ic.ac.uk>
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


// Function definition
int add(int a, int b)
{
    return a + b;
}

int main() 
{
    int result = add(0x7FF, 0x1);

#if !defined(__riscv)
    // Print the result
    printf("Result: %d\n", result);
#endif

    // EXPECTED OUTPUT = 4096
    return result;
}
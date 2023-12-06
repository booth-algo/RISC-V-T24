/*
 *  Test jalr. Test if function calling works.
 *  Note: jal already exists in 018
 * 
 *  Author: William Huynh <wh0122@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


// Function definition
int add(int a, int b)
{
    return a + b;
}


int main() 
{
    int result = add(0xFFF, 0x1);

#if !defined(__riscv)
    // Print the result
    printf("Result: %d\n", result);
#endif

    // EXPECTED OUTPUT = 4096
    return result;
}
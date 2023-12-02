/*
 *  While loop test (beq, bne, blt, bge, bltu, bgeu)
 *  Author: William Huynh <wh1022@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif


int main() 
{
    int counter = 0;
    int ans[7] = {0};

    // Test beq
    while (counter == 0) {
        ans[0]++;
        counter++;
    }

    counter = 0;

    // Test bne
    while (counter != 5) {
        ans[1]++;
        counter++;
    }

    counter = 0;

    // Test blt
    while (counter < 8) {
        ans[2]++;
        counter++;
    }

    counter = 0;

    // Test bge
    while (counter >= 3) {
        ans[3]++;
        counter++;
    }

    counter = 0;

    // Test bltu
    while (counter < 7) {
        ans[4]++;
        counter++;
    }

    counter = 0;

    // Test bgeu
    while (counter >= 2) {
        ans[5]++;
        counter++;
    }

    // Bit shift and add to get output
    for (int i = 0; i < 6; ++i)
    {
        ans[i] = ans[i] << 4*i;
    }

    ans[6] = ans[0] + ans[1] + ans[2] + ans[3] + ans[4] + ans[5];

#if !defined(__riscv)
    // Print the array elements
    for (int i = 0; i < 7; ++i) {
        printf("ans[%d] = %d\n", i, ans[i]);
    }
#endif

    // EXPECTED OUTPUT = 460881
    return ans[6];
}
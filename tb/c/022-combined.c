/*
 *  Combined Test for Nested Function Calling and Byte Arrays
 *  Author: Kevin Lau <khl22@ic.ac.uk>
*/

#if !defined(__riscv)
#include <stdio.h>
#endif

int main();

// Entry point for RISC-V
#if defined(__riscv)
void _start()
{
    main();
    while (1) {} // Infinite loop to prevent undefined access to memory
}
#endif

// Helper function to store an integer into a byte array
void storeIntInByteArray(unsigned char *byteArray, int offset, int number)
{
    for (int i = 0; i < sizeof(int); ++i)
    {
        byteArray[offset + i] = (number >> (i * 8)) & 0xFF;
    }
}

// Function to calculate Fibonacci sequence and store in byte array
void calculateFibonacciAndStore(int n, unsigned char *byteArray)
{
    int fib[2] = {0, 1};
    storeIntInByteArray(byteArray, 0, fib[0]); // Store first number
    storeIntInByteArray(byteArray, sizeof(int), fib[1]); // Store second number

    for (int i = 2; i < n; ++i)
    {
        int nextFib = fib[0] + fib[1];
        storeIntInByteArray(byteArray, i * sizeof(int), nextFib);
        fib[0] = fib[1];
        fib[1] = nextFib;
    }
}

// Main function
int main() 
{
    const int fibSequenceLength = 10; // Adjust as needed
    unsigned char byteArray[fibSequenceLength * sizeof(int)]; // Byte array to store Fibonacci sequence

    calculateFibonacciAndStore(fibSequenceLength, byteArray);
    #if !defined(__riscv)
    printf("%d\n", byteArray[(fibSequenceLength - 1) * sizeof(int)]);
    #endif

    int ans = byteArray[(fibSequenceLength - 1) * sizeof(int)];

    // Return the last digit of the byte array
    return ans;

    // expected 34
}

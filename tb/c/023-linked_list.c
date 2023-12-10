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


struct Node
{
    int data;
    struct Node* next;
};

// Define a memory pool for the linked list nodes
struct Node nodePool[MAX_NODES];

// Define a pointer to the head of the linked list
struct Node* head = 0;

// Define a pointer to the current free node in the pool
struct Node* freeNode = nodePool;


void initializeLinkedList() 
{
    head = 0;
    freeNode = nodePool;
}

// Function to insert a new node at the beginning of the linked list
void insertNode(int newData) 
{
    if (freeNode < nodePool + MAX_NODES) 
    {
        freeNode->data = newData;
        freeNode->next = head;

        // Update the head to the new node
        head = freeNode;

        // Move to the next free node in the pool
        freeNode++;
    }
}

// Function to print the linked list
int sumList() 
{
    struct Node* current = head;
    int sum = 0;
    while (current != 0) 
    {
        sum += current->data;
        current = current->next;
    }

    return sum;
}


int main() 
{
    // Initialize the linked list and memory pool
    initializeLinkedList();

    // Insert some nodes
    insertNode(42);
    insertNode(17);
    insertNode(99);

    // Print the linked list
    int ans = sumList();

#if !defined(__riscv)
    printf("%d\n", ans);
#endif

    // EXPECTED OUTPUT = 158
    return ans;
}
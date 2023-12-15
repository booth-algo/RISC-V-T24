# Noam's Logbook 

## Role

I was in charge of designing the **Sign Extension** unit, as well as the **Control Unit** and the **Instruction Memory** unit. I also took on the responsability of writing some of the **testbenches**.

## Timetable details

### 16/11
    - Got familiar with the top level design of RISC V
    - Created a first draft of instrmem.sv and signextend.sv modules

### 21/11
    - Following the lecture, modified specific aspects of the sign extend modules using content from slides
    - Implemented the controlunit.sv module for different types of instructions according to value of ImmSrc

### 24/11
     - Modified and improved the controlunit.sv file to take into consideration all cases both for funct3 and the op
     - Started working on the testbench for the ALU as I had finished all of my modules

### 26/11
    - Submitted the first verion of the ALU testbench. Got some feedback from William. Still implementing it

### 29/11
    - Implemented changes in the ALU testbench file. Added all the operations and functions to check them (ADD, SUB, AND, OR, SLT) and implemented changes in the functions so that the test is easier
    - Worked on the new control unit file

### 30/11 
    - Worked on debugging the control unit. Implemented lots of changes to it for all types of instruction. Have a WORKING version of the control unit module (still missing some instructions)

### 04/12 
    - Worked on implementing all missing instructions (Logical Shift Left, Logical Shift Right, XOR, ...). Created testbenches for those, modified the ALU to implement them

### 05/12
    - Worked with William on implementing and fixing all bugs for missing instructions. Wrote some testbenches, debugged lots of instructions, modified controlunit, sign extend modules

### 06/12
    - Worked on implementation for store word, load word and load word unsigned instructions. Created a testbench in assembly for it, modified the data mem unit, the cotrol unit and the top module. It all works ! This concludes the Single Cycle for the RISC-V

### 07/12
    - Worked on first draft of cache with JAMIE. Finished first draft version, compiles fine, not tested

### 11/12
    - Worked with whole team  on debugging direct mapped cache. Debbuged most tests, 3 still not passsing. Worked on a new implementation of cache because previous one was flawed

### 12/12
    - Worked with team on finishing debugging the direct-mapped cache. Introduced new implementation that works. Started working with Jamie on the two-way set associative cache

### 13/12
    - Continued working on the two-way set associative cache with Jamie, started writing up the report for cache as well as my personal statement

### 14/12
    - Finished my personal statement
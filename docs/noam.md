# Noam's Logbook 

## Role

I was in charge of designing the **Sign Extension** unit, as well as the **Control Unit** and the **Instruction Memory** unit. I also took on the responsability of writing up the **testbench** the ALU.

## Timetable details

- 16/11
    - Got familiar with the top level design of RISC V
    - Created a first draft of instrmem.sv and signextend.sv modules

- 21/11
    - Following the lecture, modified specific aspects of the sign extend modules using content from slides
    - Implemented the controlunit.sv module

- 24/11
     - Modified and improved the controlunit.sv file to take into consideration all cases both for funct3 and the op
     - Started working on the testbench for the ALU as I had finished all of my modules

- 26/11
    - Submitted the first verion of the ALU testbench. Got some feedback from William. Still implementing it

- 29/11
    - Implemented changes in the ALU testbench file. Added all the operations and functions to check them (ADD, SUB, AND, OR, SLT) and implemented changes in the functions so that the test is easier
    

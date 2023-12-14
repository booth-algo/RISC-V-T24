# Personal Statement: Noam Weitzman

**Name:** Noam Weitzman  
**CID:** 02049854   
**Github username:** noamweitz

## Overview
- [Summary of Contributions](#summary-of-contributions)
    - [Lab 4](#lab-4)
    - [Single Cycle CPU](#single-cycle-cpu)
    - [Cache](#cache) 
- [What I learned](#what-i-learned)
- [Mistakes I made](#mistakes-i-made)
- [What I would do differently](#what-i-would-do-differently)


## Summary of Contributions

### Lab 4

In the implementation of the simplified RISC-V for Lab 4, I was in charge of implementing:
- the **Instruction Memory** module (instr_mem.sv)
- the **Control Unit** module (control_unit.sv)
- the **Sign Extension** module (sign_extend.sv)
- the **testbench** for the **ALU** module


In the design of the Control Unit for Lab 4, I only had to implement a very limited number of instructions: 
- R-type instruction: *add* (rd = rs1 + rs2)
- I-type instruction: *addi* (rd = rs1 + imm)
- B-type instruction: *bne* (if (rs1 != rs2) PC += imm)  

The implementation of the instruction memory module was fairly simple, as it is just a RAM.  
The implementation of the sign extension module was a bit more complicated as I had to implement a different sign extension for different types of intructions.  

I also used this lab as an opportunity to write up another kind of testebenches by writing the ALU testbench: [ALU Testbench](/tb/test/alu_tb.cpp).

### Single Cycle CPU

Moving from Lab 4 to the whole Single Cycle implementation meant lots of modules had to be refactored as we needed to implement a whole lot more operations as seen in the RISC-V Instruction Set:
![RISC-V insrtcutions implemented for Single Cycle](/images/RISC-Vcard.png)

This meant effort had to be put into refactoring some modules, especially the **Control Unit** which turned out to be pretty tedious: [Control Unit module](/rtl/control_unit.sv). Implementing the Control Unit involved a deep understanding of the overall design of the design to understand how operations impact the different signals: 
![RISC-V](/images/) Insert image of the whole architecture.

In order to correctly implement the Control Unit, I also got involved in writing testbenches, especially in asssembly language, which allowed me to test one specific RISC-V instruction. This turned out to be extremely useful for debugging: [Exemple of Assembly Testbench I implemented](/tb/asm/006-lb-lbu-sb.s).

The refactoring of the **ALU** and **Sign Extension** modules was fairly straightforward, as we just needed to implement all types of instructions not in the Lab 4 design: [ALU module](/rtl/alu.sv) and [Sign Extend](/rtl/sign_extend.sv).

Finally, the **Data Memory** module also had to be refactored, because we had to implement byte specific instructions like lb and sb, allowing more specific control over bytes instead of just word control: [Data Memory](/rtl/data_mem.sv).

### Cache

Implementing cache helped to increase overall computer performance by hindering *memory performance*. This was done by using the *temporal locality* property of memory. We started by implementing direct-mapped cache, where each set only holds one block of data: [Direct-Mapped Cache module](/rtl/dm_cache.sv).
![dm_cache implementation](/images/schematic3.png)
The implementation of direct-mapped cache was more complicated than expected, especially as we had started with a different, faulty design: 
![faulty dm_cache implementation](/images/schematic1.png)
In this design, 

This causes conflicts many memory addresses will map to the same set. This will result in a lower hit rate than we would have by implementing a two-way set associative cache. 

## What I learned
This project was extremely useful for me in enhancing my technical skills across various areas.

Firstly, it taught me how to properly use Git as a version control system to manage a coding project. I learned how to clone repositories, create and switch branches, push and pull, and merge branches. Git allowed our team to track and save all changes made to the project and overall collaborate more efficiently.

Secondly, it refined my skills in SystemVerilog. I learned how to write clean and well documented code that my teammates could understand easily. I also understood the importance of writing more modular code (more on that later). It also significantly improved my skills in debugging code, as there was a lot of debugging involved in each part of the project. 

Finally, it played a crucial role as my first actual coding project collaborating with a team. Not only did I get to put together and consolidate the theoretical knowledge we had accumulated in past labs, but it was also a great opportunity to work with teammates towards the same goal. It helped me to highlight any misunderstandings I may have had during lectures by applying it to an actual CPU implementation. I believe working as a team allowed me to gain experience in fields I was not familiar with, from teammates that had developed their knowledge through industry experience. I understood how important it was to identify and leverage the strengths and weaknessesses of people in a team. Lastly, the project honed my time planning abilities, underscoring the importance of efficient project management. 

## Mistakes I made



cache first implementation, not global code enough that had to be refactored, misunderstanding of how to handle byte addressing vs word addressing

Taught me importance of thorough understanding before trying to implemetn a faulty design. highlight value of clear and organised design and detail attention.

## What I would do differently

Overall, I believe we worked great as a team, and I am proud of the work we produced in such a short time. I believe every team members feels they contributed to the team and learned a lot from the project 
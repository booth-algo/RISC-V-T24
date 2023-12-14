# Personal Statement - James Mitchell 02226128
## Overview 
[Contributions](#Contributions)
- [Single Cycle](#Single Cycle)
- [Cache](#Cache)
[What I've Leaned](#What I've Learned)
[Mistakes I Made](#Mistakes I Made)
## Contributions
### Single Cycle 
[Single Cycle](/docs/team_statements_sections/single_cycle.md)
In the single cycle design, I was reponsible for the design and implementation of the:
- ALU
- Register file
- Data Memory
- Restructuring
- Top file
- Refactoring of Control Unit
  
---

#### ALU
**insert picture**
For the initial design of the lab 4 ALU, only 3 operations were required **ADD**, **SUB**, **SLT**. However, in the single cycle to accomodate to all of the other instructions, we also required **AND** and **OR** operations. 
```SV
  case(ALUctrl)
        3'b000:     ALUout = a + b;
        3'b001:     ALUout = a - b;
        3'b010:     ALUout = a & b;
        3'b011:     ALUout = a | b;
        3'b101:     ALUout = (a < b) ? 1 : 0;
        default:    ALUout = 0;   
    endcase
```
---

#### Register File
**insert picture**
The initial design of the single cycle required a 32 registers each of width 32 bits. 
[regfile](/rtl/regfile.sv)

---

#### Data Memory
**insert Picture**
A new module **data_mem** was required for the single cycle design so Kevin and I. Designed, implemented and tested the module.
[data_mem](/rtl/data_mem.sv)

---

#### Restructuring
**insert Picture**
When changing the design to single cycle, putting the muxes inside the **Program Counter** and the **ALU** proved problematic. I pulled out the muxes into the top file to make it more readable and writing the top module easier.

---

#### Top Module 
For the single cycle design, I wrote the top module design including the additional modules and wired appropriately.

--- 

### Cache
In the cache design, I was responsible for the design of the
- Direct Mapped Cache
- Two-Way Assosiative Cache
The final implementation was a split contribution between the team.
[Cache](docs/team_statement_sections/cache.md)
  
 ---
 
#### Direct Mapped Cache

The Direct Mapped Cache required a rewrite of the memroy module. From the Harris & Harris textbook, I designed a cacheline and memory addressing for the cache memory and then wrote the dm_cache.sv file with Noam for the direct mapped cache. 

However, after this initial design, it was spotted in the testing that the clock cycles were misaligned so all the members of the team rewrote the top memory module together for this design and implemented it 

#### 2-Way Associative Cache

As I was designing the cache line and memory addressing for the direct mapped cache. I also wrote the code for the two-way associative cache based off an outline Kevin had provided. Noam and I finished this code using what we had learned from the direct mapped cache, the lectures and the textbook. The implementation of the **Replacement Policy** took time to research and Noam assisted with the syntax and logic behind the code  However, due to time, our final code was never fully implemented and tested.

## What I've Learned 
This project has been essential in my learning and development of this module. From the application of the theory in the coursework to the leaning how to manage time, delegate workload and work effectively in a team. This project has been a fantastic oppurtunity to create a CPU with a reduced version of what is used in industry as well as learning how optimisation is important and the implementation of this. The opportunity to learn and work with peers, I had not previously worked with was an opportunity to see how others work and learn from the strengths and weaknesses of the individual members in the team, the group's varying experience allowed for teaching of valuable methodology.

The scope of the project was time appropriate and the workload was difficult. The project allowed me to learn how to code as a team, with transcending the fear of editing or debugging code that one of my peers has written. My skills of debugging, writing readable code and communicating appropriately greatly improved over the scope of the project. This was my first experience with dealing with a project of this scale related to the CPU, so this was a great stepping stone for my future career and alligns to my goals going forward.

After taking a large portion of the workload related to cache, I have leanrt thoroughly through research the workings of the cache and its purpose and performance relating to conflicts of the CPU, some of which are covered in this project and will be used for future projects and has inspired me to move past the scope of this course.

## Mistakes I made 
I made a few mistakes in this project related to my management and skills learned. I regret not taking the opportunity to learning the workings of the testbenches and how to write them at the start of the project from my peers. Learning this skill would've enabled more effective debugging, helping out the team more in this area.  

## What I Would Do Differently
In my opinion, the team worked exellently together and the dynamics of the team were effortless. I believe that the workload of the team was equally distributed and I am thankful for the work that my group have put into this project. If the group was to do this project again, I would ensure that we planned appropriately the design of each module before implementation to reduce time spent redesigning modules in the CPU and unneccessary time spent debugging.

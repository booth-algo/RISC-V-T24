# Team Progress

This file will note down **major meetups** and breakdown the progress completed by those meetups. Note that only meetings with all 4 members present will be documented in this file.

## Lab meetup (16/11)
  - Discussed and allocated lab 4 parts to team members
    ![Alt text](../images/lab4_design.png)
    ![Alt text](../images/lab4_allocation.png)
  - Team goals:
    1. Lab 4 design
    2. Single cycle
    3. 5-stage pipeline
    4. Hazard detection
    5. Cache (2-way set associative) with prefetching

## Lab meetup (23/11)
  - Lab 4 parts were mostly completed before the lab meetup
  - Main issues discussed during meeting:
    - Should we group by making sub-top modules?
      - Not necessary
    - Note carefully the defining of wires and ports, there seems to be some confusion regarding those and also the internal and external interconnecting wires relative to each module.
    - Should we change module names to follow sth_sth.sv underscore standard?
      - Yes

## Group meetup (29/11)
  - Plan (part 1 and 2)
    | Part | Task                                 | Status | Member 1 | Member 2  |
    |------|--------------------------------------|--------|----------|-----------|
    | 1    | Lab 4 control unit debugging         | [ ]    | William  |           |
    | 1    | ALU testbench                        | [x]    | Noam     | William   |
    | 1    | Data memory creation                 | [x]    | Jamie    | Kevin     |
    | 2    | Code refactoring (pulling out muxes) | [ ]    |          |           |
    | 2    | Write ALU for single cycle           | [ ]    |          |           |
    | 2    | Write control unit for single cycle  | [x]    | Noam     | Jamie     |
    | 2    | Write asm code for F1 lights         | [x]    | Jamie    |           |
    | extra| Design two-way set associative cache | [x]    | Kevin    | Jamie     |
    | extra| Code FETCH cycle of pipeline         | [x]    | Kevin    |           |
   - Note:
     - A lot of testbench writing was done by William today for the Lab 4 control unit debugging - this will be further elaborated in William's logbook
     - By the end of meetup, the control unit is NOT FULLY DEBUGGED and it remains the only component in lab4 that has issues, and we are still trying to debug it

## Group meeting (30/11)
  - Notes:
    - Jamie: ALU and top file updated for single-cycle, data_mem fixed, ALU nearly done, top file needs debugging
    - Noam: Control unit for single-cycle done
    - William: Testbenches fixed, "things will be done by tonight"
    - Kevin: Cache discussion with UTA

## Group meeting (7/12)
  - We met from 1pm to 6pm today to: 
    1. Complete the single cycle CPU
    2. Officially start working on pipeline
    3. Create a direct mapped cache
  - Single cycle CPU
    - Over the past few days, all of the single cycle instructions have been debugged (refer to personal .md files)
    - Only the `load byte` and `store byte` instructions had to be implemented since the provided reference program requires these instructions, which was quickly done by Noam
    - We created a snapshot `v0.2.0`, which refers to the completed `Single Cycle Version` of our RISC-V 32I processor, which should be able to run both F1 lights and the reference PDF program
  - Pipelining
    - Working on the previously created pipeline files and completed IF/ID file, the implementation of the 4 pipeline flip-flops was worked on by Kevin and William
    - After using Verilator to debug all the implicitly defined ports and logic in the top module, we managed to pass the `add_positive.s` (in the `tb/asm` file), by adding several `no ops` to the test program (this was done purely to verify that pipeline was working properly)
    - Afterwards, we worked the `hazard unit`, where we combatted data hazard by using `forwardA_E` and `forwardB_E` signals based on whether to forward from ALU result or writeback, so it skips the write to and read from register file (refer to slides)
  - Cache
    - A `direct mapped` version of the cache was being created by Jamie and Noam, where the structure was defined and read/write logic was being discussed
    - There was much discussion about the implementation of the cache - since we don't actually have a physical silicon cache, should we create a cache array to just point to memory in data memory, or should we define one of the areas in unused space as a cache memory

## Group meeting (7/12)
  - Brief meetup between lectures for 2 hours
    - Cache
      - Progress has been made to the cache - the direct mapped cache has been fully created (including the read write logic) and is currently being verified
    - Pipelining
      - Stalling for lw data dependency has now been added to the IF/ID stage through using the `stall` signal from the hazard unit
      - Code modifications for other relevant parts such as the `program counter`, `control unit`, etc.
      - The lw data dependency has been tested and verified to be working
      - Next meetup: Control hazards
      - Decision after discussion:
        - There are three methods to deal with control hazards:
          1. Flushing instructions by assuming branch isn't taken
          2. Branch decision detection at an earlier stage to reduce number of instructions to flush
          3. Branch prediction using 1-bit branch prediction buffer 
        - Our decision is to prioritise finishing the data cache first before going for our own stretched goal
        - Hence we will implement instruction flushing first, finish the cache, then work on branch prediction if we have time 

## Tag v0.3.0 and issue regarding v0.2.0
  - Snapshot with tag `v0.3.0` has been fully tested - it runs through all tests and runs the reference program `pdf.s` perfectly
  - A bug was found with the previous single-cycle version `v0.2.0`, however the snapshot cannot be modified so here is a remark:
    - There was a bug with the `data_mem.sv` which caused the 3 MS bytes of a word to be set to zero when using byte addressing mode - this is unintended behaviour and has been corrected in the pipelined version `v0.3.0`
    - Further details can be found in the debugging notes in `kevin.md`

## Group meeting (11/12)
  - Meetup in the afternoon + online at night
  - Agendas
    - `Hazard unit` has been debugged and finished over the weekend
    - `Direct-mapped cache` needs to be implemented in top module
  - Progress
    - Direct-mapped cache structure drawn and connected to the top module
    - The structure focused on a more parallel structure between the data memory and the cache
    - Cache hit and miss was acting weird when some new tests written the night before was used to test
    - A lot of previous tests were also failing
    - At night, a refactored version of the cache was written, interlinking the data memory with the cache (with cache interacting with the main interface and accessing data memory when needed), and byte adressing was more focused on
    - Unknown byte overwriting errors led to fails in the combined test (fibonacci + byte array) and the PDF test specifically
    - Tests were conjured to test overwriting but found no faults

## Group meeting (12/12)
  - Meetup in the afternoon
  - Agendas
    - Fixing `direct-mapped cache`
  - Code was refactored to address issues with byte-addressing
  - Cache is now more byte-addressing oriented
  - `Direct-mapped cache` was fixed and tested, but CI fixes and more tests of cache hits/misses were needed
  - `Two-way set associative cache` logic structure was implemented

## Group meeting (13/12)
  - Team gym session in the morning!
  - Meetup in the afternoon
  - Agendas
    - Debugging `two-way set associative cache`
    - Complete fixes for CI
    - Cache hit/miss data analysis
    - Write up most of the team statement
  - Results:
    - Team statement
      - Cache written but needs changes
      - Cache hit/miss data analysis written
      - Other parts of the team statement written, including but not limited to: testing

## Group meeting (14/12) (Final Team Meetup)
  - Agendas:
    - Finish up the team statement
      - Single cycle
      - 

# Team Progress

This file will note down major meetups and breakdown the progress completed by those meetups.

- Lab meetup (16/11)
  - Discussed and allocated lab 4 parts to team members
    ![Alt text](../images/lab4_design.png)
    ![Alt text](../images/lab4_allocation.png)
  - Team goals:
    1. Lab 4 design
    2. Single cycle
    3. 5-stage pipeline
    4. Hazard detection
    5. Cache (2-way set associative) with prefetching

- Lab meetup (23/11)
  - Lab 4 parts were mostly completed before the lab meetup
  - Main issues discussed during meeting:
    - Should we group by making sub-top modules?
      - Not necessary
    - Note carefully the defining of wires and ports, there seems to be some confusion regarding those and also the internal and external interconnecting wires relative to each module.
    - Should we change module names to follow sth_sth.sv underscore standard?
      - Yes

- Group meetup (29/11)
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

- Group meeting (30/11)
  - Plan
    | Task                          | Status |
    |-------------------------------|--------|
    | Complete tasks from 29/11     | [ ]    |
    |    
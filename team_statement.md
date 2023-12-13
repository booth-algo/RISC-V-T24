# RISC-V Team 24 Statement

## Team 24
| Kevin Lau (repo manager) | William Huynh | James Mitchell | Noam Weitzman |
|-|-|-|-|

## Final submission
- Our team has successfully completed and verified the following for our RV32I processor:
  - Lab 4 (Tag: v0.1.0)
  - Single Cycle Version (Tag: v0.2.0)
  - Pipelined Version (Tag: v0.3.0)
  - Direct-mapped Cache Version (Tag: v0.4.0)

- Implemented but not completely verified:
  - Two-way set associative Cache Version

## Team Contribution
- Work Contribution Table
- `*` (one star) refers to **partial / minor contribution**
- `**` (two stars) refers to **full / major contribution**

|              |                               | Kevin (booth-algo) | Will (saturn691) | Jamie (jamiemitchell123) | Noam (noamweitz) |
| ------------ | ----------------------------- | ------------------ | ---------------- | ------------------------ | ---------------- |
| Lab 4        | Program Counter               | **                 |                  |                          |                  |
|              | ALU                           |                    |                  | **                       |                  |
|              | Register File                 |                    |                  | **                       |                  |
|              | Instruction Memory            |                    |                  |                          | **               |
|              | Control Unit                  |                    |                  |                          | **               |
|              | Sign Extend                   |                    |                  |                          | **               |
|              | Testbench                     |                    | **               |                          |                  |
| Single Cycle | Data Memory                   | **                 |                  | **                       | *                |
|              | Program Counter (refactor)    |                    | **               |                          |                  |
|              | ALU (refactor)                |                    | **               |                          | **               |
|              | Register File (refactor)      |                    |                  | **                       |                  |
|              | Instruction Memory (refactor) | **                 | *                |                          |                  |
|              | Control Unit (refactor)       | *                  | **               | *                        | **               |
|              | Sign Extend (refactor)        |                    | **               |                          | *                |
| Pipeline     | Pipeline flip-flop stages     | **                 | *                |                          |                  |
|              | Hazard unit                   | **                 | **               |                          |                  |
| Cache        | Memory (refactor)             |                    | **               |                          |                  |
|              | Direct mapped cache           | **                 | **               | **                       | **               |
|              | Two-way set associative cache | *                  |                  | **                       | **               |

- As a team, we all agree that both the list and GitHub commits do not accurately measure the contribution of team members due to the following reasons:
  1. When working together in Room 404 / calling on Discord (online), we would operate on only one of the laptops, so some commits made by team members are often a combined effort of two or more members, while the other laptop might be on another version / tag for testing and debugging
  2. The effort revolving around debugging is often highly overlooked - commits with simple fixes often took hours / days of effort from more than one member to debug a small mistake
  3. Testbench building and writing played a huge role in streamlining our process, and multiple tests were written to specifically do debugging and isolate problematic parts / instructions
- As such, it is highly recommended that readers refer to all of the `logbooks`, `personal statements`, and `commits`, to accurately evaluate the amount of work, effort and contribution of each member

## Team Workflow
### Repo management (using `git`)
- The functions of `git` were fully utilised in this project
- `Branches` were created for implementations of different features to avoid conflict and pushing faulty / poorly written code to `main`
- `Tags` were created for each completed version of the RV32I processor
### Repo organisation 
- `docs`: logbooks, statements, references
- `images`: images for `docs`
- `rtl`: RV32I processor modules
- `tb`: Testbench and scripts
### Workflow
- After `lab4`, modules / work were dynamically allocated to team members
- Team meetings, discussion and progress are logged in `team_log.md`
- All personal contributions and progress (such as debugging notes) are noted down in personal logbooks in `docs/logbooks`

## Content // Need to link to each section
1. Lab 4
2. Single Cycle Version
3. Pipelined Version
4. Cached Version
   - Direct-mapped
   - Two-way set associative

## Lab 4 (v0.1.0)
- 

## Single Cycle Version (v0.2.0)
- 

## Pipelined Version (v0.3.0)
- 

## Cached Version (v0.4.0)


## Testing: Testbench, Scripts, Continuous Integration
- We believe that our rigorous testing process distinguishes our repo from other teams
- Implementations include:
  1. **CI pipeline - GitHub Actions**
  2. **Testbench and bash script writing - GTests**
  3. **ASM and C test writing**
  4. **Cache hit / miss test - Data analysis**
- These implementations which can be seen in GitHub and the `tb` folder has greatly improved the debugging experience and reduced time required for compiling tests for troubleshooting

#### CI pipeline - GitHub Actions
- @William

#### Testbench and bash script writing - GTests
- // how gtest was implemented
- // asm assembled directly
- // c compiled @William
- With this implementation, `asm` and `c` testbenches can be easily written and compiled 

#### ASM and C test writing
- Multiple tests could be run at the same time and debugging was made simple with the GTest implementation
- Tests were written for specific modules and instructions
- Some tests were particularly useful for debugging some hidden bugs, including `c/022-combined.c`, `c/023-linked_list.c`, which provided huge help when debugging `data_mem.sv` and `instr_mem.sv`
- The disassembly text provided after running the top testbench allows us to trace instructions and memory locations easily, which helped a lot especially after pipeline implementation
- These tests avoid confusion after implementation of each new feature, as it allows us to **isolate** bugs down to certain instructions / behaviour


#### Cache hit / miss test - Data analysis
- After debugging, the implementation of direct-mapped cache passed all written tests, but it wasn't clear whether it exhibited the correct behaviour
- To check whether the cache hit / miss behaviour and rate was accurate, data analysis was done using previous tests written in `asm` specifically for cache hit / miss
- ... @William (regression testing)

## Personal statements and other links
(not linked yet lol)
| Kevin | William   | Jamie | Noam  | 
|-------|-----------|-------|-------|
| PS    | PS        | PS    | PS    |
| log   | log       | log   | log   |

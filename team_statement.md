# RISC-V Team 24 Statement

## Team
- James Mitchell
- Kevin Lau (repo master)
- Noam Wietzman
- William Huynh

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
- `*` (one star) refers to partial contribution, `**` (two star) refers to full contribution

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

## Content
1. Lab 4
2. Single Cycle Version
3. Pipelined Version
4. Cached Version
   a. Direct-mapped
   b. Two-way set associative 

## Single Cycle Version


## Pipeline Version


## Cached Version


## Main focuses / Specialities
- We believe that there are several special implementations and highlights which elevates and distinguishes our repo from other teams
- 

Waffle:
- GitHub
  - Branches
  - Tags
  - Actions (CI pipeline)
- Testbenches
  - GTest
  - Writing asm and C tests
  - Regex and parsing


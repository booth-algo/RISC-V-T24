# Kevin's Personal Statement

| Name | Kevin Lau Cheuk Hang |
|-|-|
| CID | 02240867 |
| GitHub handle | booth-algo |

| Table of Contents |
|-|
| [Summary](#summary) |
| [Contributions](#contributions) |
| [Self-reflection](#self-reflection) |
| [Other notes](#other-notes) |

## Summary

- I was the repo manager / master of this project, where I managed branches, merge requests, and noted down meeting notes in the [team logbook](../logbooks/team_log.md), and organised the team's workflow. I also wrote the [team statement](../../README.md).

- I worked on **all parts and sections of the processor**, with my proudest contributions being the `pipeline` and `hazard unit` ([tag v0.3.0](https://github.com/booth-algo/RISC-V-T24/releases/tag/v0.3.0)), which I spent a lot of time debugging with William.

- I **highly recommend** reading my [personal logbook](../logbooks/kevin_log.md), where I not only document all my work sessions, I also note down in detail my observations and thought process during major debugging sessions.

- Instead of going over every single small detail in this statement, I will focus on compiling a concise list of my contributions and self-reflections, and let my `logbook` and `commits` demonstrate my hard work.


## Contributions

NB: Not all of my commits were linked for conciseness since there were too many relevant commits made

### (1) Lab 4

- (a) I was in charge of repo management, where I managed a lot of pull requests and GitHub repo restructuring.

- (b) I wrote the `program counter` and `top` modules.

- (c) I did a lot of debugging for my teammates while coding up `top`.

- (d) I did a lot of documentation in Google Docs / Sheets which I later moved to markdown files in the [team logbook](../logbooks/team_log.md) and other markdown files. 

| Links | Commits | Logbook |
|-|-|-|
| 1a |  | [log](../logbooks/kevin_log.md#1611) |
| 1b | | [log](../logbooks/kevin_log.md#1611) |
| 1c | | [log](../logbooks/kevin_log.md#2411) |
| 1d | | [log](../logbooks/kevin_log.md1611) |

### (2) Single Cycle

- (a) There was not much to be done with the `program counter`, so I helped out with the other modules.

- (b) This includes making decisions such as removing the `mux` out of different modules and refactoring poorly written code to prepare for the `pipeline` implementation.

- (c) I also implemented the `data memory`, and also worked on the testbench for it.

- (d) I spent some time debugging the `JALR` instruction which William was struggling to debug. It proved to be the most challenging instruction to debug, of which I [noted the evidence and process in my logbook].  

| Links | Commits | Logbook |
|-|-|-|
| 2a |  | [log](../logbooks/kevin_log.md#2811) |
| 2b | | [log](../logbooks/kevin_log.md#212) |
| 2c | | [log](../logbooks/kevin_log.md#3011) |
| 2d | | [log](../logbooks/kevin_log.md#5-612-midnight) | 

### (3) Pipeline and Hazard Unit

- (a) I would say that the my workflow was quite *pipelined* (joke intended) - I started working early on bits of the pipeline while waiting for other members to complete the single cycle version.

- (b) I was the **main contributor** for the **entire** `pipeline` (commit) and `hazard unit` (commit), which I spent a lot of time building and debugging with William's help.

- (c) The `hazard unit` took a lot of effort to debug - there is a section in my logbook dedicated to the weekend debugging session (here's the [link](../logbooks/kevin_log.md#912-and-1012)). 
  - The above section details my thought process throghout the debugging session, which I am really proud of. 
  - I think the key is to isolate instructions or components to an area as small as possible, so you can focus on them directly. 
  - For example, there was this specific load word data dependency hazard that occured only when running, which I isolated out from a `disassembly text` after running one of the `c` testbenches. This helped me create the [load word test](../../tb/asm/008-lw_test_1.s).
    ```
    lw	a5,-20(s0)
    lw	a5,0(a5)
    lw	a4,-24(s0)
    ```

| Links | Commits | Logbook |
|-|-|-|
| 3a | | [log](../logbooks/kevin_log.md#2911) |
| 3b | | [log](../logbooks/kevin_log.md#612-afternoon) |
| 3c | | [log](../logbooks/kevin_log.md#712-midnight) |

### (4) Cache

- (a) I worked on the structure of the `cache` and the `write logic` very early on while `single cycle` was being completed. I initially designed a two-way set associative cache structure.

- (b) I helped integrate `direct mapped cache` into the `top` module.

| Links | Commits | Logbook |
|-|-|-|
| 4a | | [log](../logbooks/kevin_log.md#2911) |
| 4b | |  |

### (5) Testbench

- As I spent a lot of time debugging, I conjured up a lot of tests to help test each section.

- (a) Single cycle: I wrote the [data memory testbench](../../tb/test/data_mem_tb.cpp)

- (b) Pipeline: I wrote the `combined.c` test, which combines the fibonacci and byte array test. I also wrote the `lw_test_1.s`, which isolates a load word issue as I mentioned above in the pipelining section.
  - This test turned out to be massively useful in cache, since it was one of the three failing tests other than `pdf.c` which was failing due to a `byte overwriting` issue.

- (c) Cache: I compiled a list of `asm` tests, including  

| Links | Commits | Logbook |
|-|-|-|
| 5a | | [log](../logbooks/kevin_log.md#3011) |
| 5b | https://github.com/booth-algo/RISC-V-T24/commit/1c24811e0ecdb6e69bb23382eae0b8a10cfb1c4f | [log](../logbooks/kevin_log.md#912-and-1012) |
| 5c | | [log](../logbooks/kevin_log.md#) |

## Self-reflection

### What I learnt

- Using multiple features of `git` for version control as the repo manager, including using branches, tags, rebasing, etc.

- Improving my SystemVerilog writing skills and deepening my understanding of a CPU.

- Improving my RISC-V assmebly code writing, which I mastered by writing and improving tests.

- Learning how to integrate CI/CD pipeline into a project's development.

- Improving my debugging skills, such as using waveforms and my assembly tests to isolate instructions, then debug the problematic SystemVerilog code.

### What I would've done differently / Mistakes I made

- Used the co-authoring function on GitHub for clearer contribution tracking.

- Spent more time understanding and helping out with various sections of the testbench, so that I could improve in the field of DevOps and which could streamline my debugging process in future projects.

- As I noted in my logbook ([here](../logbooks/kevin_log.md#912-and-1012)), none of the `asm` or `c` tests were able to catch a `data memory` error which I debugged. This shows that there are holes in my testbench writing skillset which need to be filled.

## Other notes

- I would like to express my enjoyment throughout this project despite the toughest struggles. It is provided me a great opportunity to learn to cooperate with team members I am unfamiliar with, and most importantly it gave me the experience of programming a CPU from scratch, truly a rewarding experience.

- I would like to express my largest gratitude to my lab partner William, whom with I spent lots and lots of time coding and debugging the RISC-V processor on Discord calls, and for writing up a testbench so that I can debug the RTL code more efficiently.

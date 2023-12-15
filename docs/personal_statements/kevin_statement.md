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

- I worked on **all parts and sections of the processor**, including the testbench, to improve myself and take on new challenges. My proudest contribution was the `pipeline` and `hazard unit` ([tag v0.3.0](https://github.com/booth-algo/RISC-V-T24/releases/tag/v0.3.0)), which I spent a lot of time debugging with William.

- I **highly recommend** reading my [personal logbook](../logbooks/kevin_log.md), where I not only document all my work sessions, but also note down in detail my observations and thought process during major debugging sessions. I also recommend reading the [team logbook](../logbooks/team_log.md), which I wrote to help the team keep track of progress.

- Instead of going over every single small detail in this statement, I will focus on compiling a concise list of my contributions and self-reflections, and let my `logbook` and `commits` demonstrate my hard work.


## Contributions

### (1) Lab 4

- (a) I was in charge of repo management, where I managed a lot of pull requests and GitHub repo restructuring.

- (b) I wrote the `program counter` and `top` modules.

- (c) I did a lot of debugging for my teammates while coding up `top`.

- (d) I did a lot of documentation in Google Docs / Sheets which I later moved to markdown files in the [team logbook](../logbooks/team_log.md) to facilitate team progress.

| Contribution | Commits | Logbook |
|-|-|-|
| 1a | [restructuring](https://github.com/booth-algo/RISC-V-T24/commit/dc0b08519eba0ffd1590024058c67be8a7c70f3d) | [log](../logbooks/kevin_log.md#1611) |
| 1b | [PC and top](https://github.com/booth-algo/RISC-V-T24/commit/4e3ae8dd3efd61f9ed99c7a1e9763c7dee81cbe2) | [log](../logbooks/kevin_log.md#2211) |
| 1c | [minor bug fixes](https://github.com/booth-algo/RISC-V-T24/commit/e9d3bf97a01a9404d0463f8fbb88c4c0902b9359) | [log](../logbooks/kevin_log.md#2411) |
| 1d | [team meetup notes](https://github.com/booth-algo/RISC-V-T24/commit/49acec1b030a533048bc89ab65c0dc98b1c48b4c) / [documentation of instructions](https://github.com/booth-algo/RISC-V-T24/commit/03f59e78d1145aa54736564714ad1c6e1a9b6039) | [log](../logbooks/kevin_log.md1611) |

### (2) Single Cycle

- (a) There was not much to be done with the `program counter`, so I helped out with debugging the other modules, including refactoring the `instruction memory`.

- (b) This includes making changes such as removing the `mux` out of different modules and refactoring poorly written code to prepare for the `pipeline` implementation.

- (c) I also implemented the `data memory`, and also worked on the testbench for it.

- (d) I spent some time debugging the `JALR` instruction which William was struggling to debug. It proved to be the most challenging instruction to debug, of which I [noted the evidence and process in my logbook](../logbooks/kevin_log.md#5-612-midnight.)
  - I linked William's commit here, since I debugged JALR and sent William a list of notes to help him debug. These notes and thought processes are explained in detail in the logbook link above. 
  - Some WhatsApp images screenshots if you're interested: [Debug notes 1](../../images/jalr-debug-1.png) / [Debug notes 2](../../images/jalr-debug-2.png)

| Contribution | Commits | Logbook |
|-|-|-|
| 2a | [instruction memory](https://github.com/booth-algo/RISC-V-T24/commit/abc2271721ba9955d2a1354f67cd3e055305bb09) | [log](../logbooks/kevin_log.md#2811) |
| 2b | [refactoring](https://github.com/booth-algo/RISC-V-T24/commit/f01c24208a13e18427d93248d27e1f191a9791bc) | [log](../logbooks/kevin_log.md#212) |
| 2c | [commit1](https://github.com/booth-algo/RISC-V-T24/commit/9a56f981157846d83d9a4fd25648016127d5d5a8) / [commit2](https://github.com/booth-algo/RISC-V-T24/commit/bbe218e50efa771fdc13d36a248230c69dc87ade) | [log](../logbooks/kevin_log.md#3011) |
| 2d | [JALR](https://github.com/booth-algo/RISC-V-T24/commit/466bace0340ff066dbb1aa08de4ab3a05c139f4f) | [log](../logbooks/kevin_log.md#5-612-midnight) | 

### (3) Pipeline and Hazard Unit

- I would say that the my workflow was quite *pipelined* (joke intended) - I started working early on bits of the pipeline while waiting for other members to complete the single cycle version.

- (a) I was the **main contributor** for the **entire** (a) `pipeline` and (b) `hazard unit`, which I spent a lot of time building and debugging with William's help.

- (b) The `hazard unit` took a lot of effort to debug - there is a section in my logbook dedicated to the weekend debugging session (here's the [link](../logbooks/kevin_log.md#912-and-1012)). 
  - The above section details my thought process throghout the debugging session, which I am really proud of. 
  - I think the key is to isolate instructions or components to an area as small as possible, so you can focus on them directly. 
  - For example, there was this specific load word data dependency hazard that occured only when running, which I isolated out from a `disassembly text` after running one of the `c` testbenches. This helped me create the [load word test](../../tb/asm/008-lw_test_1.s).
    ```
    lw	a5,-20(s0)
    lw	a5,0(a5)
    lw	a4,-24(s0)
    ```

| Contribution | Commits | Logbook |
|-|-|-|
| 3a | [pipeline](https://github.com/booth-algo/RISC-V-T24/commit/31158bf9e1d4cad01f30b8acfd7852cc32e1dad0) | [log](../logbooks/kevin_log.md#612-afternoon) |
| 3b | [data hazard](https://github.com/booth-algo/RISC-V-T24/commit/fb4decbb1055acebfe1cae5ef3391af1cb74d1f6) /  [forwarding and stalling](https://github.com/booth-algo/RISC-V-T24/commit/da517710a216bac6d0a2446abf257e5e7ada7aa7)  | [log1](../logbooks/kevin_log.md#712-midnight) / [log2](../logbooks/kevin_log.md#912-and-1012) |

### (4) Cache

- (a) I worked on the structure of the `cache` and the `read logic` very early on while `single cycle` was being completed. I initially designed the two-way set associative cache structure.

- (b) Participated in the **working** `direct mapped cache` implementation by integrating `direct mapped cache` into `top` by creating a new memory unit with William (squashed commits made by William, co-authored by me).

| Contribution | Commits | Logbook |
|-|-|-|
| 4a | [structure](https://github.com/booth-algo/RISC-V-T24/commit/8b6d68fbbc088d8aac0740d3d5898bee48dc1aeb) / [read logic](https://github.com/booth-algo/RISC-V-T24/commit/6a3baaeb9e066f5165efffdedf43382907493169) | [log](../logbooks/kevin_log.md#2911) |
| 4b | [working implementation](https://github.com/booth-algo/RISC-V-T24/commit/d2e5dc3ac3e5e3af0489dc1b36680a3acf4d5915) | [log](../logbooks/kevin_log.md#1112-and-1212) |

### (5) Testbench

- As I spent a lot of time debugging, I conjured up a lot of tests to help test each section.

- (a) Single cycle: I wrote the [data memory testbench](../../tb/test/data_mem_tb.cpp) and the [F1 lights testbench](../../tb/test/top-f1lights_tb.cpp)

- (b) Pipeline: I wrote the `combined.c` test, which combines the fibonacci and byte array test.
  - This test turned out to be massively useful in cache, since it was one of the three failing tests other than `pdf.c` which was failing due to a `byte overwriting` issue.

- (c) Pipeline: I also wrote the `lw_test_1.s`, which isolates a load word issue as I mentioned above in the pipelining section.

- (c) Cache: I created a list of `asm` tests for cache, including 009 to 015 under [asm](../../tb/asm), to track hit / miss behaviour.
  - These tests contributed to the **behavioural testing** for `direct mapped cache`
  - These tests later contributed to the **regression testing** for `direct mapped cache`, **verifying** the behaviour of the cache.

| Contribution | Commits | Logbook |
|-|-|-|
| 5a | [datamem tb](https://github.com/booth-algo/RISC-V-T24/commit/e5d02526df5a80f3280dff06945cc23e1783f5d2) / [f1 lights tb](https://github.com/booth-algo/RISC-V-T24/commit/49df017ada4df8e22c252ae4322266a9a3067bd6) | [log](../logbooks/kevin_log.md#3011) |
| 5b | [combined.c](https://github.com/booth-algo/RISC-V-T24/commit/1c24811e0ecdb6e69bb23382eae0b8a10cfb1c4f) | [log](../logbooks/kevin_log.md#912-and-1012) |
| 5c | [lw test](https://github.com/booth-algo/RISC-V-T24/commit/1de08631b307ce4b7a547eda16bf0c4d670a3f84) | [log](../logbooks/kevin_log.md#912-and-1012) |
| 5d | [cache tests](https://github.com/booth-algo/RISC-V-T24/commit/e2d40107c16afc0e14e2a2a651df7cce1d8423f6) | [log](../logbooks/kevin_log.md#1112-and-1212) |

## Self-reflection

### What I learnt

- Using multiple features of `git` for version control as the repo manager, including using branches, tags, rebasing, etc.

- Improving my SystemVerilog writing skills and deepening my understanding of a CPU.

- Improving my RISC-V assmebly code writing, which I mastered by writing and improving tests.

- Learning how to integrate CI/CD pipeline into a project's development.

- Improving my debugging skills, such as using waveforms and my assembly tests to isolate instructions, then debug the problematic SystemVerilog code.

### What I would've done differently / Mistakes I made

- Used the co-authoring function on GitHub for clearer contribution tracking, and squashing commits to have a cleaner commit history in the repo.

- Spent more time understanding and helping out with various sections of the testbench, so that I could improve in the field of DevOps and which could streamline my debugging process in future projects.

- As I noted in my logbook ([here](../logbooks/kevin_log.md#912-and-1012)), none of the `asm` or `c` tests were able to catch a `data memory` error which I debugged. This shows that there are holes in my testbench writing skillset which need to be filled.

- I spent too much time at the start worrying about future things such as pipeline and cache, and I could've spent more time helping other members with the single cycle implementation.

## Other notes

- I would like to express my enjoyment throughout this project despite the toughest struggles. It has provided me a great opportunity to learn to cooperate with team members I am unfamiliar with, and most importantly it gave me the experience of programming a CPU from scratch, truly a rewarding experience.

- I would like to express my greatest gratitude to my lab partner William, whom with I spent lots and lots of time coding and debugging the RISC-V processor on Discord calls, and for writing up a testbench so that I can debug the RTL code more efficiently.

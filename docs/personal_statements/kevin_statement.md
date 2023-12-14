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


## Contributions

### Lab 4

- I was in charge of repo management and also writing up the `program counter` and `top` modules.

- I was quite eager in this project, and quickly finished the `program counter`, and gave advice to other team members regarding their parts so I could code up the `top` module.

- I did a lot of documentation in Google Docs / Sheets which I later moved to markdown files in the [team logbook](../logbooks/team_log.md) and other markdown files. 

### Single Cycle

- There was not much to be done with the `program counter`, so I helped out with the other modules.

- This includes making decisions such as removing the `mux` out of different modules and refactoring poorly written code to prepare for the `pipeline` implementation (theres a commit for this you'd want to link).

- I also implemented the `data memory` (link), and also worked on the testbench for it (link).

- I spent some time debugging the `JALR` instruction which William was struggling to debug. It proved to be the most challenging instruction to debug, of which I [noted the evidence and process in my logbook].  

### Pipeline

- I would say that the my workflow was quite *pipelined* - I started working early on bits of the pipeline while waiting for other members to complete the single cycle version.

- I was the main contributor for the entire `pipeline` (commit) and `hazard unit` (commit), which I spent a lot of time building and debugging with William's help.

- The hazard unit took a lot of effort to debug - there is a huge paragraph in my logbook dedicated to the debugging session (link). Here are some commits

### Cache

- I worked on the structure of the `cache` and the `write logic` very early on while `single cycle` was being completed.

- I spent 


## Self-reflection

### What I learnt

- Using multiple features of `git` for version control as the repo manager, including using branches, tags, rebasing, etc.

- Improving my SystemVerilog writing skills and deepening my understanding of a CPU.

- Improving my RISC-V assmebly code writing, which I mastered by writing and improving tests.

- Learning how to integrate CI/CD pipeline into a project's development.

- Improving my debugging skills, such as using waveforms and my assembly tests to isolate instructions, then debug the problematic SystemVerilog code.

### What I would've done differently

- Used the co-authoring function on GitHub for clearer contribution tracking.

- Spent more time understanding and helping out with various sections of the testbench, so that I could improve in the field of DevOps and which could streamline my debugging process in future projects.

## Other notes

- I would like to express my enjoyment throughout this project despite the toughest struggles.

- I would like to express my largest gratitude to my lab partner William, whom with I spent lots and lots of time coding and debugging the RISC-V processor on Discord calls.
# RISC-V Team 24 Statement

## Team 24
| Kevin Lau (repo manager) | William Huynh | James Mitchell | Noam Weitzman |
|-|-|-|-|
## Final submission

Our team has successfully completed and verified the following for our RV32I 
  processor:

| Tag                                                            | Description  | Statement |
| -------------------------------------------------------------- |------------- |-----------|
| [v0.1.0](https://github.com/booth-algo/RISC-V-T24/tree/v0.1.0) | Lab4         | [lab4.md](./docs/team_statement_sections/lab4.md) | 
| [v0.2.0](https://github.com/booth-algo/RISC-V-T24/tree/v0.2.0) | Single-Cycle | [single_cycle.md](./docs/team_statement_sections/single_cycle.md) |
| [v0.3.0](https://github.com/booth-algo/RISC-V-T24/tree/v0.3.0) | Pipelined    | [pipeline.md](./docs/team_statement_sections/pipeline.md) |
| [v0.4.0](https://github.com/booth-algo/RISC-V-T24/tree/v0.4.0) | Direct-mapped Cache | [cache.md](./docs/team_statement_sections/cache.md) |

Implemented but unverified: two-way set associative cache

## Personal statements

| Member    | Personal statement | Logbook |
|-----------|--------------------|---------|
| Kevin     | [Personal statement](docs/personal_statements/kevin_statement.md) | [Logbook](docs/logbooks/kevin_log.md) |
| William   | [Personal statement](docs/personal_statements/william_statement.md) | [Logbook](docs/logbooks/william_log.md) |
| Jamie     | [Personal statement](docs/personal_statements/jamie_statement.md) | [Logbook](docs/logbooks/jamie_log.md) |
| Noam      | [Personal statement](docs/personal_statements/noam_statement.md) | [Logbook](docs/logbooks/noam_log.md) |

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

As a team, we all agree that the above table and commits do not accurately measure the contribution of team members due to the following reasons:

  1. When working together in Room 404 / calling on Discord (online), we would operate on only one of the laptops, so some commits made by team members are often a combined effort of two or more members, while the other laptop might be on another version / tag for testing and debugging.

  2. The effort revolving around debugging is often highly overlooked - commits with simple fixes often took hours / days of effort from two or more members to debug a small mistake.

  3. Testbench building and writing played a huge role in streamlining our process, and multiple tests were written to specifically do debugging and isolate problematic parts / instructions.

As such, it is highly recommended that readers refer to all of the `logbooks`, `personal statements`, and `commits`, to accurately evaluate the amount of work, effort and contribution of each member.

## Quick Start

Note: before running **ANY** script (including the first time script), execute this 
command.

```bash
cd tb
```

### First Time

If you are using this for the first time, you need to install dependencies.

```bash
./install.sh
```

### Using the testbench

There are two main scripts: `doit.sh` and `analyse.py`. More documentation, 
including developer/maintainer documentation is available 
[here](docs/references/instructions.md).

Here are the relevant commands. More can be found in the documentation.

| Command                               | Explanation                           |
| ------------------------------------- |-------------------------------------- |
| `./doit.sh`                           | Runs the entire testbench.            |
| `./doit.sh test/top-instr_tb.cpp`     | Runs the entire instruction testbench |
| `./doit.sh test/top-pdf_tb.cpp`       | Runs the PDF testbench (stdout)       |
| `./doit.sh test/top-pdf_TB.cpp`       | Runs the PDF testbench (vBuddy)       |
| `./doit.sh test/top-f1lights_tb.cpp`  | Runs the F1 lights testbench (stdout) |
| `./doit.sh test/top-f1lights_TB.cpp`  | Runs the F1 lights testbench (vBuddy) |
| `./analyse.py demo`                   | Creates PDF graphs of all reference data

To use vBuddy, refer to WSL documentation. You may find this command useful:

```bash
# Must be ttyUSB0- otherwise find and replace in vbuddy.cpp
sudo chmod a+rw /dev/ttyUSB0
```

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
- 
### Workflow

- After `lab4`, modules / work were dynamically allocated to team members
- Team meetings, discussion and progress are logged in `team_log.md`
- All personal contributions and progress (such as debugging notes) are noted down in personal logbooks in `docs/logbooks`


## Working Evidence

### Graphs
| Dataset | Graph | Dataset | Graph |
|-|-|-|-|
| Gaussian | ![gaussian_graph](images/data/gaussian.png) | Sine | ![sine_graph](images/data/sine.png) |
| Triangle | ![triangle_graph](images/data/triangle.png) | Noisy | /![noisy_graph](images/data/noisy.png) |

### Videos

F1 lights

https://github.com/booth-algo/RISC-V-T24/assets/107279223/7ba429f9-0615-4acf-bf2c-6efdae65fc95

Gaussian

https://github.com/booth-algo/RISC-V-T24/assets/107279223/ae81e89a-4829-4060-a14d-17d87582065d

Sine

https://github.com/booth-algo/RISC-V-T24/assets/107279223/a9c6b198-6e7f-49ab-9ae8-99291412456b

Triangle

https://github.com/booth-algo/RISC-V-T24/assets/107279223/46700d7b-6817-48e7-a547-8d06d6d3c28a

Noisy

https://github.com/booth-algo/RISC-V-T24/assets/107279223/bfe780a5-3d4b-4b68-b6db-5aa5694de6ce


## Testing: Testbench, Scripts, CI*, Data Analysis

> “If it's not tested, it's broken” - Bruce Eckel

We believe that our test-driven development elevates and distinguishes our repo from other teams.

From the beginning, we used test-driven development. Sometimes the tests
were written before the components.

The [testbench](tb) was inspired by UVM testing methodology, in which every 
component undergoes extensive, random testing. However, it was decided that
a simpler, traditional testing approach will be used due to time constraints.

Before reading this section, it is *heavily* recommended to try out the 
testbench. Navigate to the [Quick Start](#quick-start) for more information.

Implementations include:
  1. **CI pipeline** - GitHub Actions
  2. **Testbench and bash scripts** - GTests
  3. **Code Coverage** - LCOV
  4. **ASM and C tests**
  5. **Cache hit/miss test** - Data analysis

Note: to try the commands in this section, please execute the following command:

```bash
cd tb
```

\* CI = Continuous Integration

### CI pipeline - GitHub Actions

The [CI pipeline](.github/workflows/main.yml) automatically generates a pass 
or a fail on every push/merge into the remote git repository, notifying 
developers in case their changes anything. 

It is also an easy way for others to see how our code is tested.

### Testbench and bash scripts - GTests

Two types of testbenches were implemented:
  1. Unit testbenches
  2. [Integration testbenches](tb/test/top-instr_tb.cpp)

Unit testbenches were cover all the individual components.
Integration testbenches were useful for 
[regression testing](https://en.wikipedia.org/wiki/Regression_testing).

GTest was used as a framework due to it being an industry standard.

Bash scripts were preferred over makefiles as there was no real need for
caching the built versions of the CPU every time, since they are simpler
to read. More documentation is found in each file's header e.g. 
[`compile.sh`](tb/compile.sh).

### Code Coverage

Running a unit testbench generates a code coverage report using LCOV.
Give it a go:

```bash
./doit.sh test/alu_tb.cpp
```

Now check this [webpage](tb/logs/html/index.html) for code coverage.

Here are the statistics for the entire testbench. 

| Test                      | Code Coverage (%) | Tests     |
| ------------------------- | ----------------- | --------- |
| alu_tb.cpp                | 100               | 10        |
| control_unit_tb.cpp       | 91.8              | 11        |
| data_mem_tb.cpp           | N/A*              | 3         |
| instr_mem_tb.cpp          | 100               | 2         |
| mux_tb.cpp                | 100               | 2         |
| program_counter_tb.cpp    | 100               | 3         |
| regfile_tb.cpp            | 93.3              | 4         |
| sign_extend_tb.cpp        | 50                | 6         |
| top-f1lights_tb.cpp       | N/A*              | 2         |
| **top-instr_tb.cpp**      | **N/A\***         | **36**    |
| top-lab4_tb.cpp           | N/A*              | 4         |
| top-pdf_tb.cpp            | N/A*              | 1         |


\* There was a segmentation error when running certain testbenches, therefore
data could not be collected.

### ASM and C test writing

Tests were written for specific modules and instructions.

 Some tests were particularly useful for debugging some hidden bugs, including 
[`022-combined.c`](tb/c/022-combined.c), 
[`c/023-linked_list.c`](tb/c/023-linked_list.c), which provided huge help when 
debugging [`data_mem.sv`](rtl/data_mem.sv) and 
[`instr_mem.sv`](rtl/instr_mem.sv).

C code can be disassembed into assembly, allowing us to trace instructions and
memory locations easily, which helped a lot especially after pipeline
implementation. Give it a go:

```bash
./compile.sh --input c/023-linked_list.c
```

Now check the disassembly [here](tb/c/023-linked_list.dis.txt).

These tests allows us to **isolate** bugs down to certain instructions / behaviour.

### Cache hit / miss test - Data analysis

After debugging, the implementation of direct-mapped cache passed all written tests, but it wasn't clear whether it exhibited the correct behaviour. 

To check whether the cache hit / miss behaviour was accurate, data analysis was done using previous tests written in `asm` specifically for hit/miss.

**Case Study**: 
[`011-dm_cache_temp_locality.s`](tb/asm/011-dm_cache_temp_locality.s).

This is the assembly code referenced from Lecture 9. The expected hit rate (as
seen in slide 14 at the time of reference) is **80% (12/15)**. This was verified
as **81% (13/16)**, as the last reading came from our pipeline implementation. This 
can be verified on the [graph](images/hit_rates_all_tests.jpg) below, also 
referenced in the cache section.

![graph](images/hit_rates_all_tests.jpg)

The reproduction is quite difficult and tedious, 
however full instructions are listed 
[here](docs/references/instructions.md#branchcache-hit-rate).

If you want to request further guidance, you can email me: <wh1022@ic.ac.uk>.

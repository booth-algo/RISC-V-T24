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

## Single Cycle Version


## Pipeline Version


## Cached Version


### Introduction

In computer architecture, memory performance plays a pivotal role in computer performance, but has been lagging behind processor performance. To mitigate this, memory hierarchy is introduced:

![mem_hierarchy](/RISC-V-T24/images/mem_hierarchy.png)
 
Cache memory, as shown, is the fastest type of memory accessible from the processor but has limited storage and is more expensive. Cache memory will be used to store data likely to be used again, whether because it was used recently or because nearby data was used recently; properties referred to as temporal and spatial locality. Ideally, cache would supply most data to the processor, as accessing main memory is a less attractive option. Memory performance is defined using **HIT** and **MISS** attributes, where the wanted data is either in the actual level of memory hierarchy (**HIT**) or not (**MISS**). Hence, the Average Memory Access Time (**AMAT**) depends on the access time to different layers of memory, and the miss rates associated with those layers.

Cache memory is stored in sets, where each memory address maps to exactly one cache set, and each set having N blocks (with N being the degree of associativity of the cache). Direct mapped cache refers to 1-set associativity, so each set holds a unique block. Although direct mapped cache improves memory performance, it will encounter issues as many memory addresses map to the same set, resulting in conflict.

In response, a two-way set associative cache is introduced, offering a solution by allowing each set to host two distinct data blocks from two members of the set. In the course of this project, the implementation of a direct-mapped cache has proven successful and aligns with expectations. However, the two-way set associative cache, while implemented, presents challenges and does not operate seamlessly.

### Design Specifications

To improve the design of the CPU which retrieves data from the data memory, a cache was designed to increase the speed of retrieving information of which the benefits are illustrated in the introduction. In the original design of the memory, the data memory had input signals, **Address** and **WriteData** and **ReadData** as the output signal, as shown below. 

![schematic2](/RISC-V-T24/images/schematic2.jpg)

Each time data was retrieved from the memory, it took approximately 1000 clock cycles, greatly hindering the time it took to complete instructions. To improve this, a cache design was implemented using the following schematic:

![schematic1](/RISC-V-T24/images/schematic1.png)

In this design the **Address** signal is inputted to both the direct mapped cache and the data memory. If the address #insert signal# is mapped to one of the sets of data, the output signal **MISS** is set to low, and the data is read out of the cache through the multiplexer. If the **Address** signal does not map to a cache set, the output signal **MISS** = 1, and the output is read through the multiplexer but the technical aspect of this will be explored later.

However, with this implementation, an error, later discovered during implementation, occurred upon writing data from the **DATA MEMORY** to the **CACHE** due to a misalignment of clock cycles. A new high-level configuration was required for the memory block. A more concise design was implemented, removing the multiplexer, accommodating all the data to be read and written through the cache.

![schematic3](/RISC-V-T24/images/schematic3.png)

Firstly, a direct-mapped cache was designed, following the structure given in the Harris and Harris textbook, containing a cache line of 60 bits:
- 32 (least significant bits) assigned to **DATA** 
- 27 (next significant bits) assigned to **TAG**
- The most significant bit assigned to **VALID** 


This cache line maps to the memory addressing of the cache:
- 2 (least significant bits) assigned to **BYTE OFFSET** 
- 3 (next significant bits) assigned to **SET**
- 27 (most significant bits) assigned to **TAG**

**TAG** refers to the 27 most significant bits of the memory address which are used to identify the data stored within the direct-mapped memory. **VALID** is an identification bit used to equate whether the set of cache has been written to. **SET** bits are used to establish and index the cache storage in the memory. **BYTE OFFSET** bits are used to allow for byte and word addressing in the cache. Signals of this width were chosen to accommodate for word addressing and byte addressing. A memory address of 32 bits allows for both modes of addressing, controlled by a signal **ADDRMODE**. A set size of 8 allows for fast compact memory.

```SV
/* direct mapped cache 
        |  v  | tag  | data | 
        | [1] | [27] | [32] | 
    
        Memory address: (byte addressing) (32 bits)
            | tag | set | byte offset |
            | [27]| [3] |     [2]     |
            | a[31:5] | a[4:2] | a[1:0] |
            // is the number of cache registers = 32 so they are referenced like this?
*/
 
typedef struct packed {
    logic valid;
    logic [26:0] tag;
    logic [7:0] byte0;
    logic [7:0] byte1;
    logic [7:0] byte2;
    logic [7:0] byte3;
} cache_store;

cache_store cache [8];

logic [DATA_WIDTH-1:0] read_data;
logic [26:0] tag;
logic [2:0] set;
logic [1:0] byte_offset;
logic hit;
```

![set](/RISC-V-T24/images/set_image.png)

Finally, in the internal signals, a **HIT** signal was implemented, which provided enhanced debugging, testing and calculating the performance increase, specified later in the results.

### Read Logic

```SV
always_comb begin
    tag = addr[ADDR_WIDTH-1:5];
    set = addr[4:2];
    byte_offset = addr[1:0];

    // Cache read logic
    if (cache[set].valid && cache[set].tag == tag) begin
        // $display("hit");
        hit = 1;
        out = {
            cache[set].byte3, 
            cache[set].byte2, 
            cache[set].byte1, 
            cache[set].byte0
        };
    end
    
    else begin
        // $display("miss");

        // NOTE:
        // This requires a read to and from main memory
        // Normally this would be done by stalling for some clock cycles
        // However, in this model, we will not stall.
        
        hit = 0;
        out = read_data;
    end
end
```

The data is read from cache if: 
-	In the set specified in the memory address ( addr[4:2] )
  - the data is valid ( **VALID** = 1 )
  - the TAG matches the input ADDRESS signal ( addr[31:5] ).
The 4 bytes specified in the data are then forwarded to the output signal OUT and the HIT is set to high.
Otherwise, the output signal is read from the **DATA MEMORY** through the signal read_data.

### Write Logic 

```SV
always_ff @(posedge clk) begin
    if (write_en) begin
        // Pulls data in from sw/sb
        cache[set].valid <= 1;
        cache[set].tag <= addr[31:5];
        
        case (addr_mode)
            // Byte addressing
            `DATA_ADDR_MODE_B, `DATA_ADDR_MODE_BU: begin
                case (byte_offset)
                    2'b00:  cache[set].byte0 <= write_data[7:0];
                    2'b01:  cache[set].byte1 <= write_data[7:0];
                    2'b10:  cache[set].byte2 <= write_data[7:0];
                    2'b11:  cache[set].byte3 <= write_data[7:0];
                endcase
            end
            // Word addressing
            default: begin
                cache[set].byte0 <= write_data[7:0];
                cache[set].byte1 <= write_data[15:8];
                cache[set].byte2 <= write_data[23:16];
                cache[set].byte3 <= write_data[31:24];
            end
        endcase
    end
    
    else if (!cache[set].valid || !(cache[set].tag == tag)) begin
        // Pulls data in from main memory
        cache[set].valid <= 1;
        cache[set].tag <= addr[31:5];
        cache[set].byte0 <= read_data[7:0];
        cache[set].byte1 <= read_data[15:8];
        cache[set].byte2 <= read_data[23:16];
        cache[set].byte3 <= read_data[31:24];
    end
end
```

The write logic is split into two modes for the byte and word addressing. Word addressing is the more general case in the testbenches written therefore this was set to default. 

In word addressing,
-	In the set specified in the memory address ( **addr[4:2]** ), the input signal, **write_data[]**, is written to the specified byte for each of the 4 bytes in the word.

In byte addressing,
-	 In the set specified in the memory address ( **addr[4:2]** ), the input signal, **write_data[]**, is written to the specified byte.


### Simulation and Testing

Need WILLIAM to write this !!

### Performance Analysis

Memory performance is tested by calculating the **HIT** and **MISS** rates for accessing data in the memory when different instructions are implemented. The resulting **HIT** rates are represented in the following graph: 

![hit rates](/RISC-V-T24/images/hit_rates_all_tests.jpg)

Among the observed **HIT** rates for all conducted tests, a notable median value of **50.0%** emerges. This figure signifies that the main memory is accessed approximately half the time, reflecting an enhanced memory performance. This metric is indicative of an efficient cache utilization, where a significant portion of requested data is found in the cache, reducing the need to access slower main memory.

### Conclusion and Further Improvements

In computer architecture cache memory stands as a crucial way of enhancing computer performance.  Direct-mapped cache, with its 1-set associativity, showcased commendable gains, yet grappled with conflicts in cases of overlapping addresses. The pursuit of a two-way set associative cache, though met with challenges, signaled a strategic response to mitigate conflicts and optimize data retrieval efficiency.

The study of direct-mapped cache gave us useful information. Additionally, examining a two-way set associative cache showed challenges in optimizing memory hierarchy. This opens possibilities for future improvements in cache design.

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


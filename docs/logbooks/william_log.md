# William's Logbook

## Summary

- I was the **main tester** for the team.


## Explanation

As the most experienced verification engineer in the team, having done
a placement in industry, I quickly took the role of verification initially
and set out industry level practices with respect to usage of Git, C++ 
coding standards and testing. 

By establishing a thorough and robust testbenching early, this allows 
us to catch bugs as they appear, rather than having to stare at waves 
later down the line.


## Timestamps

### Week 1 (commencing 20/11/2023)

- Created an abstraction class for testbenches `BaseTestbench` and
`SyncTestbench` as well as `top-lab4_tb.cpp`, `instrmem_tb.cpp`, 
`program_counter_tb.cpp`, `signextend_tb.cpp` and `controlunit_tb.cpp`.

### Week 2 (commencing 27/11/2023)

- Created `regfile_tb.cpp`, `mux.sv`, `mux_tb.cpp`. Fixed integration bugs to 
allow for working single cycle (with addi and bne). Created a load of tests in 
`tb/c` for testing all features of the CPU.

### Week 3 (commencing 04/12/2023)

Finished single cycle and pipeline with Kevin. The reference program, `pdf.s`
now runs, as intended.

### Week 4 (commencing 11/12/2023)

Finished cache and debugged cache. Worked on report.

## Testing

| Test                                       | Code Coverage (%) | Tests     |
|--------------------------------------------|-------------------|-----------|
| alu_tb.cpp                                 | 100               | 10        |
| control_unit_tb.cpp                        | 91.8              | 11        |
| data_mem_tb.cpp                            | N/A*              | 3         |
| instr_mem_tb.cpp                           | 100               | 2         |
| mux_tb.cpp                                 | 100               | 2         |
| program_counter_tb.cpp                     | 100               | 3         |
| regfile_tb.cpp                             | 93.3              | 4         |
| sign_extend_tb.cpp                         | 50                | 6         |
| top-f1lights_tb.cpp                        | N/A*              | 2         |
| **top-instr_tb.cpp**                       | **N/A\***         | **36**    |
| top-lab4_tb.cpp                            | N/A*              | 4         |
| top-pdf_tb.cpp                             | N/A*              | 1         |

## Footnotes

All files that were written or co-written by me have been signed, via git 
commits and via a top-level comment. You can verify that these commits easily
by using GitLens. 

Furthermore, commits after 24/11/2023 have been signed with
my GPG key with the fingerprint 
`9B23 CF74 3252 486D 4190 8EA1 48AF 3454 9E6C 334C`. You can also find this on
my GitHub profile.

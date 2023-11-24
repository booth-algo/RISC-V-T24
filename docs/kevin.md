## Time Stamps

Kevin's logbook (more details in Google Docs file)

- 16/11
  - Created program counter for lab4
  - Created the repo as the repo master
  - Created a Google Docs file for logging progress
- 22/11
  - Completed top module for lab4
  - Helped Noam with control unit
  - Noted down problems with other team member's modules when writing the top module
    - Lack of width declaration
    - Confusion of declaration between ports, interconnecting wire / signals
- 23/11
  - Managed pull requests and made sure everyone in team successfully merges their branch with the main branch
  - Debugging with team during lab session
  - Restructured the entire repo for the actual coursework
- 24/11
  - Debugging syntax errors provided by William's testbench regarding the lab4 design
    - alu.sv -- non-blocking assignments used in combinational logic, corrected to blocking assignments
    - alu.sv -- syntax error, semicolon written as comma
    - top.sv -- similar to alu.sv
    - regfile.sv -- "reg" used as variable declaration -> it is a keyword in Verilog-2005 and should not be used
    - controlunit.sv -- "ALUsrc" typo -> need to make sure declaration format is consistent
    - cpu.sv -- changing the module instant names
    - cpu.sv -- added more width declarations
    - instrmem.sv AND controlunit.sv -- changed to blocking
    - alu.sv -- default assignment for EQ to avoid latch inference
  - Note: potentially need to fix signextend.sv module

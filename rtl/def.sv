`ifndef DEF_SV
`define DEF_SV

`define ALU_OPCODE_ADD              4'b0000
`define ALU_OPCODE_SUB              4'b0001
`define ALU_OPCODE_AND              4'b0010
`define ALU_OPCODE_OR               4'b0011
`define ALU_OPCODE_XOR              4'b0100
`define ALU_OPCODE_LSL              4'b0101
`define ALU_OPCODE_LSR              4'b0110
`define ALU_OPCODE_ASR              4'b0111
`define ALU_OPCODE_SLT              4'b1000
`define ALU_OPCODE_SLTU             4'b1001
`define ALU_OPCODE_B                4'b1010

`define SIGN_EXTEND_I               3'b000
`define SIGN_EXTEND_S               3'b001
`define SIGN_EXTEND_B               3'b010
`define SIGN_EXTEND_U               3'b011
`define SIGN_EXTEND_J               3'b100
`define SIGN_EXTEND_I5              3'b101

`define PC_NEXT                     3'b000
`define PC_ALWAYS_BRANCH            3'b001
`define PC_JALR                     3'b010
`define PC_INV_COND_BRANCH          3'b100
`define PC_COND_BRANCH              3'b101

// Explanation of bit allocation:
// 1. 000 = Word
// 2. 01X = Byte
// 3. 10X = Half
// then if X is the unsigned bit (unsigned = 1)
`define DATA_ADDR_MODE_W            3'b000
`define DATA_ADDR_MODE_B            3'b010
`define DATA_ADDR_MODE_BU           3'b011
`define DATA_ADDR_MODE_H            3'b100
`define DATA_ADDR_MODE_HU           3'b101

`define JUST_HIT                    2'b10
`define RECENTLY_HIT                2'b01
`define LONG_HIT                    2'b00

`endif

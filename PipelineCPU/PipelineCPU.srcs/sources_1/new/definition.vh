// INSTRUCTIONS
`define INST_ADDI   1
`define INST_ADDIU  2
`define INST_SLTI   3
`define INST_SLTIU  4
`define INST_ANDI   5
`define INST_ORI    6
`define INST_XORI   7
`define INST_LUI    8
`define INST_LW     9
`define INST_SW     10
`define INST_BEQ    11
`define INST_BNE    12
`define INST_J      13
`define INST_ADD    14
`define INST_ADDU   15
`define INST_SUB    16
`define INST_SUBU   17
`define INST_AND    18
`define INST_OR     19
`define INST_XOR    20
`define INST_SLLV   21
`define INST_VSRL   22
`define INST_JR     23
`define INST_DEF    0

// ALU OPERATORS
`define ALU_ADD 4'b0001
`define ALU_SUB 4'b0010
`define ALU_AND 4'b0011
`define ALU_OR  4'b0100
`define ALU_XOR 4'b0101
`define ALU_ML  4'b0110
`define ALU_MR  4'b0111
`define ALU_JGE 4'b1000
`define ALU_DEF 4'b0000

// NPC OPERATORS
`define NPC_J   3'b001
`define NPC_BEQ 3'b010
`define NPC_BNE 3'b011
`define NPC_JR  3'b100
`define NPC_DEF 3'b000

// IMMEDIATE EXTEND OPERATORS
`define IMM_ZERO_EXT 2'b01 
`define IMM_SIGN_EXT 2'b10
`define IMM_LUI_EXT  2'b11
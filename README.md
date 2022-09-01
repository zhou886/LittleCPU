# LittleCPU项目介绍

## 简介

​	本项目要求通过Verilog语言在xc234开发板上实现流水线CPU，同时编写一段MIPS汇编程序并测试其正确性。

## 实现的指令

### I型指令

| 标记 | opcode | rs             | rd               | imm    |
| :--: | ------ | -------------- | ---------------- | ------ |
| 位数 | 31:26  | 25:21          | 20:16            | 15:0   |
| 功能 | 操作符 | 源操作数寄存器 | 目的操作数寄存器 | 立即数 |

| inst  | opcode | rs    | rd   | imm  | function                     |
| ----- | ------ | ----- | ---- | ---- | ---------------------------- |
| ADDI  | 001000 | rs    | rd   | imm  | rd=rs+imm                    |
| ADDIU | 001001 | rs    | rd   | imm  | rd=rs+(unsigned)imm          |
| SLTI  | 001010 | rs    | rd   | imm  | rd=(rs<imm)?1:0              |
| SLTIU | 001011 | rs    | rd   | imm  | rd=(rs<imm(unsigned))?1:0    |
| ANDI  | 001100 | rs    | rd   | imm  | rd=rs&imm                    |
| ORI   | 001101 | rs    | rd   | imm  | rd=rs\|imm                   |
| XORI  | 001110 | rs    | rd   | imm  | rd=rs^imm                    |
| LUI   | 001111 | 00000 | rd   | imm  | rd=imm<<16                   |
| LW    | 100011 | rs    | rd   | imm  | rd=Mem[rs+imm]               |
| SW    | 101011 | rs    | rd   | imm  | Mem[rs+imm]=rd               |
| BEQ   | 000100 | rs    | rt   | imm  | PC=(rs==rt)?{PC+4+imm<<2}:PC |
| BNE   | 000101 | rs    | rt   | imm  | PC=(rs!=rt)?{PC+4+imm<<2}:PC |

### R型指令

| 标记 | opcode | rs              | rt              | rd               | shamt  | funct        |
| :--: | ------ | --------------- | --------------- | ---------------- | ------ | ------------ |
| 位数 | 31:26  | 25:21           | 20:16           | 15:11            | 10:6   | 5:0          |
| 功能 | 操作符 | 源操作数寄存器1 | 源操作数寄存器2 | 目的操作数寄存器 | 位移量 | 操作符附加段 |

| inst | opcode | rs   | rt    | rd    | shamt | funct  | function           |
| ---- | ------ | ---- | ----- | ----- | ----- | ------ | ------------------ |
| ADD  | 000000 | rs   | rt    | rd    | 00000 | 100000 | rd=rs+rt           |
| ADDU | 000000 | rs   | rt    | rd    | 00000 | 100001 | rd=rs+(unsigned)rt |
| SUB  | 000000 | rs   | rt    | rd    | 00000 | 100010 | rd=rs-rt           |
| SUBU | 000000 | rs   | rt    | rd    | 00000 | 100011 | rd=rs-(unsigned)rt |
| AND  | 000000 | rs   | rt    | rd    | 00000 | 100100 | rd=rs&rt           |
| OR   | 000000 | rs   | rt    | rd    | 00000 | 100101 | rd=rs\|rt          |
| XOR  | 000000 | rs   | rt    | rd    | 00000 | 100110 | rd=rs^rt           |
| SLLV | 000000 | rs   | rt    | rd    | 00000 | 000100 | rd=rt<<rs          |
| VSRL | 000000 | rs   | rt    | rd    | 00000 | 000110 | rd=rt>>rs          |
| JR   | 000000 | rs   | 00000 | 00000 | 00000 | 001000 | PC=rs              |

### J型指令

| 标记 | opcode | address |
| :--: | ------ | ------- |
| 位数 | 31:26  | 25:0    |
| 功能 | 操作符 | 地址    |

| inst | opcode | address | function                   |
| ---- | ------ | ------- | -------------------------- |
| J    | 000010 | addr    | PC={(PC+4)[31,28],addr,00} |

## CPU模块设计

### 寄存器堆 register file


## ALU Instructions

### ADD.W D0, D1
- Description: Adds a word of data from D0 to D1.
- Opcode: 0001

### ADDI.W #$08, D0
- Description: Adds the word 08 to the word in data register D0.
- Opcode: 0010

### SUB.W D0, D1
- Description: Subtracts a word of data in D0 from D1.
- Opcode: 0011

### SUBI.W #$10, D0
- Description: Subtracts the word 10 from the word in data register D0.
- Opcode: 0100

### AND.W D0, D1
- Description: Performs a bitwise AND operation between the words in D0 and D1, saving the result in D1.
- Opcode: 0101

### ANDI.W #$E2, D0
- Description: Performs a bitwise AND operation between the word E2 and the word in D0.
- Opcode: 0110

### OR.W D0, D1
- Description: Performs a bitwise OR operation between the words in D0 and D1, saving the result in D1.
- Opcode: 0111

### ORI.W #$EC, D0
- Description: Performs a bitwise OR operation between the word EC and the word in D0.
- Opcode: 1000

### NOT.W D0
- Description: Reverses all bits inside D0.
- Opcode: 1001

### CMP.W D1, D0
- Description: Compares the registers (D0 - D1).
- Opcode: 1010

### CMPI.W #$0F20, D0
- Description: Compares the operands (D0 - 0F20).
- Opcode: 1011

### BEQ.S Equal
- Description: Branches if the operands are equal.
- Opcode: 1111
- Condition: 01

### BGT.S IsHigher
- Description: Branches if D0 is higher than 0F20.
- Opcode: 1111
- Condition: 10

## Load of Constants

### MOVEI.W #$01, D0
- Description: Moves the word 01 into D0, making D0 contain 01.
- Opcode: 1100

## Transfer of Values Between Registers

### MOVE.W D1, D2
- Description: Copies a word from D1 to D2. 0123 is copied, and D2 now contains 0123.
- Opcode: 1101

## Unconditional Jump

### JMP SkipCode
- Description: Moves the destination address of the "SkipCode" label into the PC.
- Opcode: 1111
- Condition: 00

## No Operation

### NOP
- Description: Performs no computation.
- Opcode: 0000

## Instruction Format

### I (Immediate) Format
```
| opcode (4) | immediate (10) | dest_reg (3) |
```
- **Opcode (4 bits)**: Specifies the operation to be performed.
- **Immediate (10 bits)**: Contains the immediate value of the instruction.
- **Destination Register (3 bits)**: Indicates the register where the result will be stored.

Usage: Instructions that operate with immediate values.

### R (Register) Format
```
| opcode (4) | unused_bits (7) | src_reg (3) | dest_reg (3) |
```
- **Opcode (4 bits)**: Specifies the operation to be performed.
- **Unused Bits (7 bits)**: Reserved but not used.
- **Source Register (3 bits)**: Specifies the source register.
- **Destination Register (3 bits)**: Indicates the register where the result will be stored.

Usage: Instructions that operate solely with registers.

### J (Jump) Format
```
| opcode (4) | condition (2) | unused_bits (4) | jmp_addr (7) |
```
- **Opcode (4 bits)**: Identifies the jump operation.
- **Condition (2 bits)**: Indicates the condition for the jump, with 2 reserved bits.
- **Unused Bits (4 bits)**: Reserved but not used.
- **Jump Address (7 bits)**: Specifies the jump destination.

Usage: Jump instructions, with 2 bits for conditions (e.g., JMP (00), BEQ (01), and BGT (10)).

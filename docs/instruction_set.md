## Instruction Format

### I (Immediate) Format
```
| opcode (4) | immediate (10) | dest_reg (3) |
```
- **Opcode (4 bits)**: Specifies the operation to be performed.
- **Immediate (10 bits)**: Contains the immediate value of the instruction.
- **Destination Register (3 bits)**: Indicates the register where the result will be stored.

Usage: MOVEI.

### R (Register) Format
```
| opcode (4) | unused_bits (7) | src_reg (3) | dest_reg (3) |
```
- **Opcode (4 bits)**: Specifies the operation to be performed.
- **Unused Bits (7 bits)**: Reserved but not used.
- **Source Register (3 bits)**: Specifies the source register.
- **Destination Register (3 bits)**: Indicates the register where the result will be stored.

Usage: All instructions except MOVEI and branches.

### B (Branch) Format
```
| opcode (4) | unused_bits (5) | addr_ctrl (1) | jmp_addr (7) |
```
- **Opcode (4 bits)**: Identifies the branch operation.
- **Unused Bits (5 bits)**: Reserved but not used.
- **Address Control (1 bit)**: Specifies whether the address is absolute (0) or relative (1).
- **Jump Address (7 bits)**: Specifies the jump destination.

Usage: Branch instructions.

## Instructions

### NOP
- Description: Performs no computation.
- Opcode: 0000

### ADD.W D0, D1
- Description: Adds a word of data from D0 to D1 (D1 <= D1 + D0).
- Opcode: 0001

### SUB.W D0, D1
- Description: Subtracts a word of data in D0 from D1 (D1 <= D1 - D0)
- Opcode: 0010

### MOVEI.W #$01, D0
- Description: Moves the word 01 into D0 (D0 <= 1).
- Opcode: 0011

### MOVE.W D1, D2
- Description: Copies a word from D1 to D2 (D2 <= D1).
- Opcode: 0100

### CMP.W D1, D0
- Description: Compares the registers (D0 - D1) and changes the ALU flags.
- Opcode: 0101

    ### BEQ.S Equal
    - Description: Branches to Equal if the operands are equal (Z flag is set (Z = 1)).
    - Opcode: 0110

    ### BLT.S IsLower
    - Description: Branches to IsLower if D0 is lower than D1 (N flag is clear but the V flag is set (N = 0, V = 1)).
    - Opcode: 0111

### JMP Label
- Description: Jumps to Label unconditionally.
- Opcode: 1111

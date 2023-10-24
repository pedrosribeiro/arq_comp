## ALU Instructions

### ADDI.B #$08, D0
- Description: Adds the byte 08 to the byte in data register D0.
- Opcode: 

### ADD.W D0, D1
- Description: Adds a word of data from D0 to D1.
- Opcode: 

### SUBI.B #$10, D0
- Description: Subtracts the byte 10 from the byte in data register D0.
- Opcode: 

### SUB.W D0, D1
- Description: Subtracts a word of data in D0 from D1.
- Opcode: 

### ANDI.B #$E2, D0
- Description: Performs a bitwise AND operation between the byte E2 and the byte in D0.
- Opcode: 

### AND.W D0, D1
- Description: Performs a bitwise AND operation between the words in D0 and D1, saving the result in D1.
- Opcode: 

### ORI.B #$EC, D0
- Description: Performs a bitwise OR operation between the byte EC and the byte in D0.
- Opcode: 

### OR.W D0, D1
- Description: Performs a bitwise OR operation between the words in D0 and D1, saving the result in D1.
- Opcode: 

### NOT.W D0
- Description: Reverses all bits inside D0.
- Opcode: 

### NOT.B D1
- Description: Reverses all bits of the end byte of D1.
- Opcode: 

### CMPI.W #$0F20, D0
- Description: Compares the operands (D0 - 0F20).
- Opcode: 

### BEQ.S Equal
- Description: Branches if the operands are equal.
- Opcode: 

### BGT.S IsHigher
- Description: Branches if D0 is higher than 0F20.
- Opcode: 

## Load of Constants

### MOVE.B #$01, D0
- Description: Moves the byte 01 into D0, making D0 contain 01.
- Opcode: 

### MOVE.W #$0123, D1
- Description: Moves the word 0123 into D1, making D1 contain 0123.
- Opcode: 

## Transfer of Values Between Registers

### MOVE.W D1, D2
- Description: Copies a word from D1 to D2. 0123 is copied, and D2 now contains 0123.
- Opcode: 

### MOVE.B D2, D3
- Description: Copies a byte from D2 to D3. 23 is copied, and D3 now contains 0023.
- Opcode: 

## Unconditional Jump

### JMP SkipCode
- Description: Moves the destination address of the "SkipCode" label into the PC.
- Opcode: 1111

## No Operation

### NOP
- Description: Performs no computation.
- Opcode: 0000

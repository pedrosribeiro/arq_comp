; 1. Carrega R3 (o registrador 3) com o valor 5
; 2. Carrega R4 com 8
; 3. Soma R3 com R4 e guarda em R5
; 4. Subtrai 1 de R5
; 5. Salta para o endereço 20
; 6. No endereço 20, copia R5 para R3
; 7. Salta para a terceira instrução desta lista (R5 <= R3+R4)

        ; Instruction   ; Addr  (Machine code)

        NOP             ; 0     (0x00000)

        MOVEI.W #$5, D3 ; 1     (0x0602B)
        MOVEI.W #$8, D4 ; 2     (0x06044)
        MOVEI.W #$0, D5 ; 3     (0x06005)

Label:  ADD.W D3, D5    ; 4     (0x0201D)
        ADD.W D4, D5    ; 5     (0x02025)

        MOVEI.W #$1, D1 ; 6     (0x06009)
        SUB.W D1, D5    ; 7     (0x0400D)

        JMP $20         ; 8     (0x1E014)

        ; (...)

        MOVE.W D5, D3   ; 20    (0x0802B)
        JMP Label       ; 21    (0x1E004)

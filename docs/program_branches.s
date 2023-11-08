; 1. Carrega R3 (o registrador 3) com o valor 0
; 2. Carrega R4 com 0
; 3. Soma R3 com R4 e guarda em R4
; 4. Soma 1 em R3
; 5. Se R3<30 salta para a instrução do passo 3
; 6. Copia valor de R4 para R5

        ; Instruction       ; Addr  (Machine code)

        MOVEI.W #$0, D3     ; 0     (0x06003)
        MOVEI.W #$0, D4     ; 1     (0x06004)
        MOVEI.W #$0, D5     ; 2     (0x06005)
        MOVEI.W #$1, D1     ; 3     (0x06009)
        MOVEI.W #$30, D2    ; 4     (0x060F2)

        ADD.W D3, D4        ; 5     (0x0201C)
        ADD.W D1, D3        ; 6     (0x0200B)

        CMP.W D2, D3        ; 7     (0X0A013)
        BLT.S #$-3          ; 8     (0x0E183)

        MOVE.W D4, D5       ; 9     (0x08025)

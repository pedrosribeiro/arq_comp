        ; Instruction       ; Addr      (Machine code)

        MOVEI.W #$33, D1    ; 0         (0x06109)
        MOVEI.W #$2, D2     ; 1         (0x06012)
        MOVEI.W #$1, D3     ; 2         (0x0600B)

        ; loop para carregar X no endereço de memória X até X < D1
loopX:  MOVE.W D2, (D2)     ; 3         (0x12012)
        ADD.W D3, D2        ; 4         (0x0201A)
        CMP.W D1, D2        ; 5         (0x0A00A)
        BLT.S loopX         ; 6         (0x0E003)

        ; loop para remoção dos múltiplos de 2
        MOVEI.W #$4, D2     ; 7         (0x06022)
        MOVEI.W #$2, D3     ; 8         (0x06013)
loop2:  MOVE.W D0, (D2)     ; 9         (0x12002)
        ADD.W D3, D2        ; 10        (0x0201A)
        CMP.W D1, D2        ; 11        (0x0A00A)
        BLT.S loop2         ; 12        (0x0E009)

        ; loop para remoção dos múltiplos de 3
        MOVEI.W #$6, D2     ; 13        (0x06032)
        MOVEI.W #$3, D3     ; 14        (0x0601B)
loop3:  MOVE.W D0, (D2)     ; 15        (0x12002)
        ADD.W D3, D2        ; 16        (0x0201A)
        CMP.W D1, D2        ; 17        (0x0A00A)
        BLT.S loop3         ; 18        (0x0E00F)

        ; loop para remoção dos múltiplos de 5
        MOVEI.W #$10, D2    ; 19        (0x06052)
        MOVEI.W #$5, D3     ; 20        (0x0602B)
loop5:  MOVE.W D0, (D2)     ; 21        (0x12002)
        ADD.W D3, D2        ; 22        (0x0201A)
        CMP.W D1, D2        ; 23        (0x0A00A)
        BLT.S loop5         ; 24        (0x0E015)

        MOVEI.W #$33, D1    ; 25        (0x06109)
        MOVEI.W #$2, D2     ; 26        (0x06012)
        MOVEI.W #$1, D3     ; 27        (0x0600B)

        ; loop para leitura da RAM até D1
loopR:  MOVE.W (D2), D4     ; 28        (0x10014)
        ADD.W D3, D2        ; 29        (0x0201A)

        ; se a leitura for 0, não é primo
        CMP.W D0, D4        ; 30        (0x0A004)
        BEQ.S notPrime      ; 31        (0x0C022)

        ; se for primo, move para D5 e continua o loop
        MOVE.W D4, D5       ; 32        (0x08025)
        JMP loopR           ; 33        (0x1E01C)

        ; verifica se já leu todas as posições de memória para parar ou não
notPrime: CMP.W D2, D1      ; 34        (0x0A011)
        BEQ.S end           ; 35        (0x0C07F)
        JMP loopR           ; 36        (0x1E01C)

end:    NOP                 ; 127       (0x00000)
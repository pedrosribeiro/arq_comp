        ; Instruction       ; Addr  (Machine code)

        MOVEI.W #$33, D1    ; 0
        MOVEI.W #$2, D2     ; 1
        MOVEI.W #$1, D3     ; 2

        ; loop para carregar X no endereço de memória X até X < D1
loopX:  MOVE.W D2, (D2)     ; 3
        ADD.W D3, D2        ; 4
        CMP.W D1, D2        ; 5 
        BLT.S loopX         ; 6

        ; loop para remoção dos múltiplos de 2
        MOVEI.W #$4, D2     ; 7
        MOVEI.W #$2, D3     ; 8
loop2:  MOVE.W D0, (D2)     ; 9
        ADD.W D3, D2        ; 10
        CMP.W D1, D2        ; 11
        BLT.S loop2         ; 12

        ; loop para remoção dos múltiplos de 3
        MOVEI.W #$6, D2     ; 13
        MOVEI.W #$3, D3     ; 14
loop3:  MOVE.W D0, (D2)     ; 15
        ADD.W D3, D2        ; 16
        CMP.W D1, D2        ; 17
        BLT.S loop3         ; 18

        ; loop para remoção dos múltiplos de 5
        MOVEI.W #$10, D2    ; 19
        MOVEI.W #$5, D3     ; 20
loop5:  MOVE.W D0, (D2)     ; 21
        ADD.W D3, D2        ; 22
        CMP.W D1, D2        ; 23
        BLT.S loop5         ; 24

        MOVEI.W #$33, D1    ; 25
        MOVEI.W #$2, D2     ; 26
        MOVEI.W #$1, D3     ; 27

        ; loop para leitura da RAM até D1
loopR:  MOVE.W (D2), D4     ; 28
        ADD.W D3, D2        ; 39

        ; se a leitura for 0, não é primo
        CMP.W D0, D4        ; 30
        BEQ.S notPrime      ; 31

        ; se for primo, move para D5 e continua o loop
        MOVE.W D4, D5       ; 32
        JMP loopR           ; 33

        ; verifica se já leu todas as posições de memória para parar ou não
notPrime: CMP.W D2, D1      ; 34
        BLT.S end           ; 35
        JMP loopR           ; 36

end:    NOP                 ; 127
        ; Instruction       ; Addr  (Machine code)

        MOVEI.W #$10, D1    ; 0     (0x06051)
        MOVEI.W #$20, D2    ; 1     (0x060A2)
        MOVEI.W #$30, D3    ; 2     (0x060F3)
        MOVEI.W #$40, D4    ; 3     (0x06144)

        SW.W D1, (D2)       ; 4     (0x1200A)
        SW.W D2, (D3)       ; 5     (0x12013)
        SW.W D3, (D4)       ; 6     (0x1201C)

        ADD.W D3, D4        ; 7     (0x0201C)
        SW.W D4, (D1)       ; 8     (0x12021)

        MOVEI.W #$1, D5     ; 9     (0x0600D)

        LW.W (D1), D2       ; 10    (0x1000A)
        ADD.W D0, D2        ; 11    (0x02002)

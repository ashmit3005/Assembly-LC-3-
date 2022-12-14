    .ORIG x3000
    
    
; Lab 1
; Ashmit Bhatnagar
; 10/5/22

    LD R0, PTR      ; R0 = x3100

    LDR R1, R0, #0  ; R1 = mem[x3100]
    LDR R2, R0, #1  ; R2 = mem[x3101]
    AND R2, R2, #3  ; R2[1:0] contains the key
    
    ; Negate the key, and load back into R2
    NOT R2, R2
    ADD R2, R2, #1
    
    LDR R3, R1, #0  ; Load first character into R3
    ADD R3, R3, R2  ; Add negative of key to R3, and load back into R3
    STR R3, R1, #0  ; Store R3 back into same location where the character was read from
    
    LDR R3, R1, #1  ; Load second character into R3
    ADD R3, R3, R2  ; Add negative of key to R3, and load back into R3
    STR R3, R1, #1  ; Store R3 back into same location where the character was read from
    
    LDR R3, R1, #2  ; Load third character into R3
    ADD R3, R3, R2  ; Add negative of key to R3, and load back into R3
    STR R3, R1, #2  ; Store R3 back into same location where the character was read from
    
    
    HALT
    
PTR .FILL   X3100


    .END
    
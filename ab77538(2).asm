        .ORIG x3000
; Lab 2
; Ashmit Bhatnagar
; 10/12/2022

        AND R4, R4, #0
        ADD R4, R4, #8  ; R4 will serve as the counter for the rotate
        
        LD R0, PTR      ; R0 = X4000     
        LDR R1, R0, #0  ; R1 = mem[x4000]
        LDR, R2, R1, #0 ; R2 = mem[x5000]
        LD R4, PTR2     ; R4 = x8
    
LOOP    ADD R2, R2, #0  ; checks whether positive or negative (if MSB is 0 or 1)
        BRZP JUMP       ; if not negative, jumps ahead 
        
        ; negatives
        ADD R2, R2, R2  ; left-shits R2
        ADD R2, R2, #1
        BRNZP JUMP2     ; jumps ahead if positive or zeroes
        
JUMP    ; zeroes and positives
        ADD R2, R2, R2

JUMP2   ADD R4, R4, #-1 ; decrements counter
        BRZ OVER
        BRNP LOOP       


OVER    STR R2, R1, #0  ; stores result in R2

        HALT
 
PTR     .FILL   X4000
PTR2    .FILL   X8

        .END






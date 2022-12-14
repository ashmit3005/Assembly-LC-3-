        .ORIG x3000
        
; Lab 3
; Ashmit Bhatnagar
; 10/17/2022

        LD R0, PTR      ; R0 = x4004
        ADD R1, R0, #1  ; R1 = x4005
        LD R6, PTR2     ; R6 = xFF00
        
LOOP1   LDR R2, R0, #0  ; R2 = mem[x4004]
        AND R5, R2, R6  ; checks if R2's bits [15:8] are 0
        BRZ OVER        ; if bits [15:8] are 0, then branches to OVER 
        
LOOP2   LDR R3, R1, #0  ; R3 = mem[x4005]
        LDR R2, R0, #0  ; R2 = mem[x4004]
        AND R5, R3, R6  ; checks if R3's bits [15:8] are 0
        BRZ JUMP2       ; branches to JUMP2 if R3's bits [15:8] are 0
        JSR COMPARE     ; subroutine COMPARE is called
        ADD R4, R4, #0  
        BRZ JUMP1         
        STR R2, R1, #0  ; mem[x40045] = R2
        STR R3, R0, #0  ; mem[x4004] = R3
        
JUMP1   ADD R1, R1, #1  ; increment R1 
        BR LOOP2        ; branch back to LOOP2 to restart the second iteration
        
JUMP2   ADD R0, R0, #1  ; increment R0 
        ADD R1, R0, #1  
        BR LOOP1        ; branch to LOOP1 to restart the entire iteration
    
OVER    HALT    

    
PTR     .FILL   x4004
PTR2    .FILL   xFF00
PTR3    .FILL   x00FF



COMPARE ;save R2, R3, R5, R6
        ST R2, S1
        ST R3, S2       
        ST R5, S3       
        ST R6, S4 
        
        ST R1, S5       
        LD R1, PTR3     ; R1 will be used to clear bits [15:8]
        
        AND R5, R2, R1  ; R5 = R2 AND x00FF
        AND R6, R3, R1  ; R6 = R3 AND x00FF
        
        ; R5 = R5 - R6
        NOT R6, R6      
        ADD R6, R6, #1 
        ADD R5, R5, R6 
    
        BRP JUMP3       ; if R5 is positive   
        LD R4, S7       ; R4 = 0     
        BR JUMP4        
        
JUMP3   ; set R4 = 1
        LD R4, S6   

JUMP4   ; restore R2, R3, R5, R6 and return
        LD R2, S1       
        LD R3, S2       
        LD R5, S3       
        LD R6, S4       
        LD R1, S5       
        RET         ; exit subroutine and return to main program
    
S1      .FILL x0         ; fill S1 with 0
S2      .FILL x0         ; fill S2 with 0
S3      .FILL x0         ; fill S3 with 0
S4      .FILL x0         ; fill S4 with 0
S5      .FILL x0         ; fill S5 with 0
S6      .FILL x0001      ; fill S6 with 1
S7      .FILL x0         ; fill S7 with 0



        .END

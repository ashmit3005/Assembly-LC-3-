        .ORIG x3000
        
; Lab 4
; Ashmit Bhatnagar
; 10/27/22

        LD R0, PTR
        LD R1, F
        LD R2, S
        LD R3, J
        LD R4, G
        
        STR R4, R0, #-1
        STR R3, R0, #-2
        STR R2, R0, #-3
        STR R1, R0, #-4
        
        AND R2, R2, #0
        AND R3, R3, #0
        AND R4, R4, #0
        AND R5, R5, #0
        
LOOP    LDR R1, R0, #0
        LD R6, PTR2
        AND R7, R1, R6
        BRZ HIST
        
        LD R6, PTR2
        NOT R6, R6
        AND R7, R6, R1
        
        LD R1, FCREDHR
        NOT R1, R1
        ADD R1, R1, #1
        ADD R1, R1, R7
        BRN FCOUNT
        
        LD R1, SCREDHR
        NOT R1, R1
        ADD R1, R1, #1
        ADD R1, R1, R7
        BRN SCOUNT
        
        LD R1, JCREDHR
        NOT R1, R1
        ADD R1, R1, #1
        ADD R1, R1, R7
        BRN JCOUNT
        
        ADD R0, R0, #1
        ADD R5, R5, #1
        BR LOOP
        
HIST    LD, R0, PTR
        LDR R6, R0, #-4
        ADD R6, R6, R2
        STR R6, R0, #-4
        
        LDR R6, R0, #-3
        ADD R6, R6, R3
        STR R6, R0, #-3
        
        LDR R6, R0, #-2
        ADD R6, R6, R4
        STR R6, R0, #-2
        
        LDR R6, R0, #-1
        ADD R6, R6, R5
        STR R6, R0, #-1
        
HIGH1   LD R6, PTR2
        NOT R6, R6
        LDR R2, R0, #0
        LDR R1, R0, #0
        AND R1, R6, R1
        AND R2, R6, R2
        
HIGH2   LDR R3, R0, #0
        LD R6, PTR2
        AND R7, R3, R6
        BRZ STORE
        NOT R6, R6
        AND R7, R3, R6
        AND R3, R3, R6
        NOT R7, R7
        ADD R7, R7, #1
        ADD R6, R7, R1
        BRZP LESSTHANHIGH
        ADD R1, R3, #0
        
LESSTHANHIGH    ADD R6, R7, R2
                BRNZ MORETHANLOW
                ADD R2, R3, #0
                
MORETHANLOW     ADD R0, R0, #1
                BR HIGH2
                
STORE   ADD R1, R1, R1
        ADD R1, R1, R1
        ADD R1, R1, R1
        ADD R1, R1, R1
        ADD R1, R1, R1
        ADD R1, R1, R1
        ADD R1, R1, R1
        ADD R1, R1, R1
        ADD R1, R1, R2
        LD R6, STARTMEAN
        STR R1, R6, #0
        

CREDHRMEAN  LD R0, STARTARRAY
            LD R3, PTR2
            LDR R4, R0, #0
            AND R4, R4, R3
            BRZ NULL
            JSR MEAN
            LD R0, STARTMEAN
            STR R2, R0, #1
            BR FINISH

FCOUNT  ADD R2, R2, #1
        ADD R0, R0, #1
        BR LOOP

SCOUNT  ADD R3, R3, #1
        ADD R0, R0, #1
        BR LOOP
        
JCOUNT  ADD R4, R4, #1
        ADD R0, R0, #1
        BR LOOP
        
NULL    LD R0, STARTMEAN
        LD R2, CLEAR
        STR R2, R0, #0
        STR R2, R0, #1
        BR FINISH
        
FINISH  HALT


MEAN    ST R0, INITR0
        ST R1, INITR1
        ST R3, INITR3
        ST R4, INITR4
        ST R7, INITR7
        
        AND R3, R3, #0
        AND R4, R4, #0
        
REPEAT   LDR R1, R0, #0
        LD R5, PTR2
        AND R5, R1, R5
        BRZ DONE
        LD R5, PTR2
        NOT R5, R5
        AND R1, R5, R1
        ADD R3, R3, #1
        ADD R4, R1, R4
        ADD R0, R0, #1
        BR REPEAT
        
DONE    JSR DIVIDE
        
        LD R0, INITR0
        LD R1, INITR1
        LD R3, INITR3
        LD R4, INITR4
        LD R7, INITR7
        
        
        RET
        

DIVIDE  ST R4, R4COPY
        ST R3, R3COPY
        ST R5, R5COPY
        AND R2, R2, #0
        NOT R5, R3
        ADD R5, R5, #1

LOOP2   ADD R4, R4, R5
        
        BRN OVER
        ADD R2, R2, #1
        
        BR LOOP2
        
OVER    LD R4, R4COPY
        LD R3, R3COPY
        LD R5, R5COPY
        
        RET
        
INITR0      .FILL x0
INITR1      .FILL x0
INITR3      .FILL x0
INITR4      .FILL x0
INITR7      .FILL x0
R3COPY      .FILL x0
R4COPY      .FILL x0
R5COPY      .FILL x0

PTR         .FILL x4004
PTR2        .FILL xFF00
F           .FILL x4600
S           .FILL x5300
J           .FILL x4A00
G           .FILL x4700
FCREDHR     .FILL x001E
SCREDHR     .FILL x003D
JCREDHR     .FILL x005B
STARTMEAN   .FILL x6000 
STARTARRAY  .FILL x4004
CLEAR       .FILL xFFFF

        .END

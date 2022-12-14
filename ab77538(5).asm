        .ORIG x3000
; Lab 5
; Ashmit Bhatnagar
; 11/3/2022

LD R1, INPUT
LEA R2, CLASS
LEA R0, MESSAGE
PUTS

GETINPUT    GETC
            OUT
            ADD R5, R1, R0
            BRZ INPUTENTERED
            STR R0, R2, #0
            ADD R2, R2, #1
            BR GETINPUT
            
INPUTENTERED   STR R5, R2, #0

START       LDI R1, LOCATION
            BRZ NOTLOCATED
            LEA R2, CLASS
            LDR R3, R1, #1
            
MATCH       LDR R4, R3, #0
            LDR R5, R2, #0
            ADD R6, R4, R5
            BRZ LOCATED
            NOT R4, R4
            ADD R4, R4, #1
            ADD R4, R4, R5
            BRNP PASS
            BRZ LOOP
            
LOOP        ADD R3, R3, #1
            ADD R2, R2, #1
            BR MATCH

PASS        LDR R1, R1, #0
            BRZ NOTLOCATED
            LEA R2, CLASS
            LDR R3, R1, #1
            BR MATCH
            
LOCATED     LEA R0, CLASS
            PUTS
            LEA R0, OFFERED
            PUTS
            BR FINISH
            
NOTLOCATED  LEA R0, CLASS
            PUTS
            LEA R0, NOTOFFERED
            PUTS
            BR FINISH
            
FINISH         HALT

LOCATION    .FILL x4000
INPUT       .FILL xFFF6
MESSAGE     .STRINGZ    "Type Course Number and press Enter: "
NOTOFFERED  .STRINGZ    " is not offered this semester."
OFFERED     .STRINGZ    " is offered this semester!"
CLASS       .BLKW  x0008

.END


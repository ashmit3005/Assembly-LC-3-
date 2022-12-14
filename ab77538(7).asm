; Lab 7
; Ashmit Bhatnagar
; 11/17/2022

; OPERATING SYSTEM CODE

.ORIG x500
        
        LD R0, VEC
        LD R1, ISR
        ; (1) Initialize interrupt vector table with the starting address of ISR.
        STR R1, R0, #0
        
        ; (2) Set bit 14 of KBSR. [To Enable Interrupt]
        LDI R2, KBSR
        LD  R3, MASK
        
        NOT R2, R2
        AND R3, R2, R3
        NOT R3, R3
        
        STI R3, KBSR
        
        ; (3) Set up system stack to enter user space. So that PC can return to the main user program at x3000.
	; R6 is the Stack Pointer. Remember to Push PC and PSR in the right order. Hint: Refer State Graph
        LD  R3, PSR
        LD  R4, PC
        
        LD R6, PC
        
        ADD R6, R6, #-1
        STR R3, R6, #0
        ADD R6, R6, #-1
        STR R4, R6, #0


        ; (4) Enter user Program.
        RTI
        
VEC     .FILL x0180
ISR     .FILL x1700
KBSR    .FILL xFE00
MASK    .FILL xBFFF
PSR     .FILL x8002
PC      .FILL x3000

.END


; INTERRUPT SERVICE ROUTINE

.ORIG x1700
ST R0, SAVER0
ST R1, SAVER1
ST R2, SAVER2
ST R3, SAVER3
ST R7, SAVER7




; CHECK THE KIND OF CHARACTER TYPED AND PRINT THE APPROPRIATE PROMPT

; GET INPUT
LDI R0, KBDR        

; R0: user-inputted character
; R1: testing values for branch

LD R1, X_UPPERCASE
LD R2, X_LOWERCASE
ADD R1, R0, R1
BRZ EXITPROG
ADD R2, R0, R2
BRZ EXITPROG

; ===Check if the character is a letter of the alphabet====

; UPPERCASE
LD R1, ASCII_UC
LD R2, ADDY1

UPPERCASE   ADD R7, R0, R1
            BRZ LETTER
            ADD R1, R1, #-1
            ADD R3, R1, R2
            BRZ PASS
            BR UPPERCASE
    
PASS   LD R1, ASCII_LC
       LD R2, ADDY2
        
; lowercase
LOWERCASE   ADD R7, R0, R1
            BRZ LETTER
            ADD R1, R1, #-1
            ADD R3, R1, R2
            BRZ PASS2
            BR LOWERCASE
            
; ==== CHECK IF THE CHARACTER IS A NUMBER ====

; number
PASS2   LD R1, ASCII_NUM
        LD R2, ADDY3
        
NUMBER  ADD R7, R0, R1
        BRZ DECIMALDIGIT
        ADD R1, R1, #-1
        ADD R3, R1, R2
        BRZ ERROR
        BR NUMBER

;==== print with polling ====

; STRING1 
LETTER  LEA R1, STRING1
 
POLL1   LDR R0, R1, #0
        BRZ FINISH
    
POLL2   LDI R2, DSR_PTR
        BRZP POLL2
        STI R0, DDR_PTR
        ADD R1, R1, #1
        BR POLL1


; STRING2
DECIMALDIGIT  LEA R1, STRING2 
 
POLL3   LDR R0, R1, #0
        BRZ FINISH
    
POLL4   LDI R2, DSR_PTR
        BRZP POLL4
        STI R0, DDR_PTR
        ADD R1, R1, #1
        BR POLL3

; STRING3
ERROR   LEA R1, STRING3 
 
POLL5   LDR R0, R1, #0
        BRZ FINISH 
    
POLL6   LDI R2, DSR_PTR
        BRZP POLL6
        STI R0, DDR_PTR
        ADD R1, R1, #1
        BR POLL5
    
  ; print STRING4
EXITPROG LEA R1, STRING4 

POLL7   LDI R2, DSR_PTR
        BRZP POLL7
        LDR R0, R1, #0
        BRZ HALTS
        LDR R0, R1, #0
        STI R0, DDR_PTR
        ADD R1, R1, #1


HALTS HALT

FINISH

end LD R0, SAVER0
    LD R1, SAVER1
    LD R2, SAVER2
    LD R3, SAVER3 
    LD R7, SAVER7
    RTI
    



X_LOWERCASE .FILL x-78
X_UPPERCASE .FILL x-58
ADDY3 .FILL x003A
ADDY2 .FILL x007B
ADDY1 .FILL x005B
DSR_PTR .FILL xFE04
DDR_PTR .FILL xFE06
ASCII_NUM .FILL x-30
ASCII_LC  .FILL x-61
ASCII_UC  .FILL x-41
KBDR .FILL xFE02
STRING1 .STRINGZ "\nUser has entered a letter of the alphabet!\n"
STRING2 .STRINGZ "\nUser has entered a decimal digit!\n"
STRING3 .STRINGZ "\nERROR: User input is invalid!\n"
STRING4 .STRINGZ "\n---------- User has Exit the Program ----------\n"
SAVER0 .BLKW x1
SAVER1 .BLKW x1
SAVER2 .BLKW x1
SAVER3 .BLKW x1
SAVER7 .BLKW x1


.END

; USER PROGRAM

.ORIG x3000


; MAIN USER PROGRAM
; PRINT THE MESSAGE "Enter a character…" WITH A DELAY LOGIC

; ==== SPAM THE PROMPT MESSAGE ====
LOOP    LEA R0, MESSAGE
        PUTS
        
        LD R5, CNT
        
DELAY   AND R2, R2, #0
        ADD R2, R2, #-1
        ADD R5, R2, R5
        BRP DELAY
        BRNZ LOOP
        
        
        HALT


CNT .FILL x7FFF
MESSAGE .STRINGZ  "Enter a character…\n"
.END
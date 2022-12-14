.ORIG   x3000

; Lab 6
; Ashmit Bhatnagar
; 11/10/2022

    LD  R1, INPUT
    LEA R3, CLASS
    LEA R0, PROMPT
    PUTS
    
GET_INPUT   GETC
            OUT
            ADD R4, R1, R0
            BRZ INPUT_ENTERED
            STR R0, R3, #0
            ADD R3, R3, #1
            BRNZP GET_INPUT
            
INPUT_ENTERED  STR R4, R3, #0

                LDI R1, HEADPTR1
                BRZ EMPTY
                BRNZP   PASS
        
EMPTY   JSR NOMATCH1
        BRNZP OVER
        
PASS    LEA R3, CLASS
            LDR R2, R1, #1
            
        JSR COMPARE_ARRAY
        
        

OVER    HALT

HEADPTR1    .FILL   x4000
HEADPTR2    .FILL   x4001
INPUT       .FILL   xFFF6
PROMPT      .STRINGZ    "Type Course Number and press Enter: "
ADDED       .STRINGZ    " has been added to this semester’s course offerings!"
DNE         .STRINGZ    "The entered Course Number does not exist in the current course catalog."
OFFERED     .STRINGZ    " is already being offered this semester."
CLASS       .BLKW   x08


COMPARE_ARRAY 
        
        ST  R7, STORER7

        LDR R5, R2, #0
        LDR R4, R3, #0
        ADD R6, R4, R5
        BRZ MATCH1
        NOT R5, R5
        ADD R5, R5, #1
        ADD R5, R5, R4
        BRNP TRAVERSE_ARRAY
        
        
        ADD R2, R2, #1
        ADD R3, R3, #1
        BRNZP   COMPARE_ARRAY
        
TRAVERSE_ARRAY    
        LDR R1, R1, #0
        BRZ NOMATCH1
        LEA R3, CLASS
        LDR R2, R1, #1
        BRNZP   COMPARE_ARRAY
        
        
MATCH1   LEA R0, CLASS
         PUTS
         LEA R0, OFFERED
         PUTS
         
            RET

NOMATCH1    ST  R7, STORER7
            LDI R1, HEADPTR4
            
            LEA R3, CLASS
            LDR R2, R1, #1
            LD  R0, HEADPTR4
            JSR COMPARE_ARRAY2


            LD  R7, STORER7
            RET
        
        
COMPARE_ARRAY2    

            LDR R5, R2, #0
            LDR R4, R3, #0
            ADD R6, R4, R5
            BRZ MATCH2
            NOT R5, R5
            ADD R5, R5, #1
            ADD R5, R5, R4
            BRNP PASS2
        
        
        ADD R2, R2, #1
        ADD R3, R3, #1
        BRNZP   COMPARE_ARRAY2
        
PASS2   ADD R0, R1, #0     
        LDR R1, R1, #0
        BRZ NOMATCH2
        LEA R3, CLASS
        LDR R2, R1, #1
        BRNZP   COMPARE_ARRAY2
        
MATCH2  ADD R5, R1, #0
        LDR R3, R5, #0
        STR R3, R0, #0
        
        LD  R1, HEADPTR3
        LDR R6, R1, #0
        STR R5, R1, #0
        STR R6, R5, #0
        
        LEA R0, CLASS
        PUTS
        LEA R0, ADDED
        PUTS
        
            RET

NOMATCH2   LEA R0, DNE
            PUTS
            
    
        RET
        
STORER7     .FILL   x0000
HEADPTR3    .FILL   x4000
HEADPTR4    .FILL   x4001

.END
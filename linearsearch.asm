ASSUME DS: DATA, CS:CODE
DATA SEGMENT
    MSG1 DB 10,13, "ENTER THE STRING: $"
    MSG2 DB 10,13, "ENTER THE CHARACTER: $"
    MSG3 DB 10,13, "KEY FOUND $"
    MSG4 DB 10,13, "KEY NOT FOUND $"
    N DB 100 DUP(?)
DATA ENDS

CODE SEGMENT
    START: MOV AX,DATA  ;INITIALISING THE DATA SEGMENT
           MOV DS,AX

           MOV SI, OFFSET N ;INITIALISE THE OFFSET ADDRESS

           LEA DX, MSG1
           MOV AH,09H
           INT 21H

           MOV CL, 00H  ;CLEARING COUNTER

    READ: MOV AH, 01H
          INT 21H

          CMP AL,0DH    ;0DH IF ENTER KEY IS PRESSED
          JE END
          MOV [SI], AL
          INC SI
          INC CL        ;INCREMENTING COUNTER
          JMP READ

    END:  LEA DX, MSG2      
          MOV AH, 09H
          INT 21H       

          MOV AH, 01H
          INT 21H
           
          MOV BL,AL
          MOV CH,00H    ;CLEARING

    CHECK: DEC SI
           CMP BL,[SI]
           JE FOUND
           DEC CL
           CMP CL, 00H   ;TO CONTINUE CHECKING TILL THE COUNTER BECOMES ZERO
           JNE CHECK
           JMP NOTFOUND

    FOUND: LEA DX, MSG3
           MOV AH,09H
           INT 21H
           JMP TERMINATE

    NOTFOUND: LEA DX, MSG4
              MOV AH, 09H 
              INT 21H

    TERMINATE: MOV AH, 4CH
        INT 21H
CODE ENDS
END START

ASSUME DS:DATA, CS:CODE
DATA SEGMENT
    MSG1 DB 10,13, "ENTER THE STRING: $"
    MSG2 DB 10,13, "PALIDROME$"
    MSG3 DB 10,13, "NOT PALINDROME"
    STR1 DB 50 DUP(?)
DATA ENDS

CODE SEGMENT
    START:  MOV AX, DATA
            MOV DS, AX

            LEA DX, MSG1
            MOV AH, 09H
            INT 21H

            LEA SI, STR1
            LEA DI, STR1

    READ:   MOV AH, 01H
            INT 21H

            CMP AL, 0DH
            JE END
            MOV [DI],AL
            INC DI
            JMP READ

    END:    MOV AL, '$'
            MOV [DI],AL

    CHECK:  DEC DI
            MOV AL,[SI]
            CMP [DI], AL
            JNE NOTPALINDROME

            INC SI
            CMP SI, DI
            JL CHECK

 PALINDROME: LEA DX,MSG2
            MOV AH, 09H
            INT 21H

            JMP TERMINATE

NOTPALINDROME: LEA DX, MSG3
            MOV AH, 09H
            INT 21H

    TERMINATE: MOV AH,4CH
                INT 21H

CODE ENDS
END START

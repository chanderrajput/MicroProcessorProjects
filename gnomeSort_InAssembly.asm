
.MODEL
.STACK 100H
.DATA
MSG DB 'How many values do you wants to add in array for sort (LIKE 01,10..) and less then 100 $'
MSG1 DB 'Enter the values, like as 04,10,14 BUT LESS THEN 100 $'
CHOICE_MSG DB 'Which type of sorting do you wants $'
CHOICE_MSG1 DB '1. Ascending order $'
CHOICE_MSG2 DB '2. descending order $'
WRONG_CH_MSG DB 'You select the wrong choice $'
 
SIZE DW ?
ARRAY DB 20 DUP(?)
SWAP DB 00H
.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG
    MOV AH,09
    INT 21H
        
    CALL PRINT_NL
    
    MOV CL,10
    
    MOV AH,01H ;SCAN ARRAY SIZE
    INT 21H
    AND AL,0FH
    MOV BL,AL
    
    MOV AH,01H
    INT 21H
    AND AL,0FH
    MOV BH,AL
    
    
    MOV AL,BL
    MUL CL
    ADD AL,BH
    MOV AH,00
    MOV SIZE,AX ; SAVE ARRAY SIZE
    
    
    CALL PRINT_NL
    
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    
    MOV BX,00H    ; TO REUSE BX
    MOV CX,SIZE
    MOV SI,10H
    MOV BL,00H
    
   
    ARRAY_INPUT:  ; array variable input
         
         CALL PRINT_NL
         MOV AH,01H
         INT 21H
         AND AL,0FH
         MUL SI
         MOV DL,AL 
         
         MOV AH,01H
         INT 21H
         AND AL,0FH
         ADD DL,AL
         MOV [ARRAY+BX],DL
         
         INC BL
        
    LOOP ARRAY_INPUT
                    
    CALL PRINT_NL
                        
    LEA DX,CHOICE_MSG
    MOV AH,09H
    INT 21H
    
    CALL PRINT_NL
    
    LEA DX,CHOICE_MSG1
    MOV AH,09H
    INT 21H
           
    CALL PRINT_NL
    
    LEA DX,CHOICE_MSG2
    MOV AH,09H
    INT 21H
           
    CALL PRINT_NL
    
    
    MOV AH,01H
    INT 21H
    AND AL,0FH
    
    CMP AL,01H
    JE ASSENDING_SORTING
    
    CMP AL,02H
    JE DECENDING_SORTING
    
    CALL WRONG_CHOICE
    JMP EXIT
    
    ASSENDING_SORTING:  
    
    START:           ;SORTING ARRAY WITH GNOME SORT

    MOV BX,1
    MOV SWAP,0

    LOOP1:
        MOV AL,[ARRAY+BX-1]
        CMP AL,[ARRAY+BX]
        JG SWAP1

        ADD BX,1
        CMP BX,SIZE
        JNE LOOP1
        CMP SWAP,1
        JE START
        MOV AL,0
                
        JMP EXIT

        SWAP1:
        MOV DL,[ARRAY+BX]
        MOV [ARRAY+BX],AL
        MOV [ARRAY+BX-1],DL
        MOV SWAP,1
        SUB BX,1
        JNZ HERE
        MOV BX,1
        HERE:
        JMP START
           
    JMP EXIT
          ;10,05,02,04,02
    
    DECENDING_SORTING:
    START1:           ;SORTING ARRAY WITH GNOME SORT

    MOV BX,1
    MOV SWAP,0

    LOOP3:
        MOV AL,[ARRAY+BX-1]
        CMP AL,[ARRAY+BX]
        JL SWAP2

        ADD BX,1
        CMP BX,SIZE
        JNE LOOP3
        CMP SWAP,1
        JE START1
        MOV AL,0
        

        
        JMP EXIT

        SWAP2:
        MOV DL,[ARRAY+BX]
        MOV [ARRAY+BX],AL
        MOV [ARRAY+BX-1],DL
        MOV SWAP,1
        SUB BX,1
        JNZ HERE1
        MOV BX,1
        HERE1:
        JMP START1
           
    JMP EXIT
    
;    PRINT_ARRAY:  
;        
;        MOV SI,0
;        MOV CX,SIZE
;        
;        CALL PRINT_NL
;        LOOP2:
;            MOV dL,[ARRAY+SI]
;            ADD DL,30H    
;            MOV AH,02H
;            INT 21H
;            INC SI
;            
;            MOV DL,2CH
;            MOV AH,02
;            INT 21H
;        
;       
;        LOOP LOOP2  
;    RET


    WRONG_CHOICE:
        CALL PRINT_NL
        LEA DX,WRONG_CH_MSG
        MOV AH,09H
        INT 21H    
    
    
    RET
        
    PRINT_NL:
    MOV DL,0AH
    MOV AH,02H
    INT 21H
             
    MOV DL,0DH
    MOV AH,02
    INT 21H
    
    RET
    
    EXIT:
    
endp
end main
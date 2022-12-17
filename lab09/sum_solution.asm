;; don't run this directly by pressing 'RUN' in complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate Subroutine
;; Call' and choose the 'sum' label.

.orig x3000 
HALT

sum
    ADD R6, R6, -4  ; make space for RA, RV, old FP and one local
    STR R7, R6, 2   ; save return address
    STR R5, R6, 1   ; saves old frame pointer
    ADD R5, R6, 0   ; point frame pointer at the first local variable
    ADD R6, R6, -5  ; allocate space to save all five registers R0-R4
    ; save registers
    STR R0, R6, 0
    STR R1, R6, 1
    STR R2, R6, 2
    STR R3, R6, 3
    STR R4, R6, 4

    LDR R0, R5, 4   ; R0 = N
    ADD R1, R0, -1  ; R1 = N-1
    BRnz RETURN1    ; if N <= 1 return 1

    ; call sum(n-1)
    ADD R6, R6, -1  ; allocate space for orne argument
    STR R1, R6, 0   ; pass the parameter for the callee
    JSR sum
    LDR R1, R6, 0   ; return value in R1
    ADD R6, R6, 2   ; R6 back to the top of the stack

    ADD R0, R0, R1  ; n+sum(n-1)
    BR TEARDOWN
    
    RETURN1 ; return 1 (TEARDOWN will set the RV, we just need to put the value in R0)
    AND R0, R0, 0 ; R0 = 0
    ADD R0, R0, 1 ; R0 = 1
    
    TEARDOWN
    ; save the value in R0 on the stack as our return value
    STR R0, R5, 3

    ; restore registers
    LDR R0, R6, 0
    LDR R1, R6, 1
    LDR R2, R6, 2
    LDR R3, R6, 3
    LDR R4, R6, 4

    ; restore return address, frame pointer, and move R6 to RV
    ADD R6, R6, 6
    LDR R5, R6, 0
    LDR R7, R6, 1
    ADD R6, R6, 2

    RET ; return to the caller

; Needed by Simulate Subroutine Call in complx
STACK .fill xF000
.end





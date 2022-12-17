;; Timed Lab 3
;; Student Name: Austin Chemelli

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA immediately.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;; // (checkpoint 1)
;; int MAX(int a, int b) {
;;   if (a > b) {
;;       return 0;
;;   } else {
;;       return 1;
;;   }
;; }
;;
;;
;;
;;
;; DIV(x, y) {
;;	   // (checkpoint 2) - Base Case
;;     if (y > x) {
;;         return 0;
;;     // (checkpoint 3) - Recursion
;;     } else {
;;         return 1 + DIV(x - y, y);
;;     }
;; }
;;
;;
;;
;; // (checkpoint 4)
;; void MAP(array, length) {
;;   int i = 0;
;;   while (i < length) {
;;      int firstElem = arr[i];
;;      int secondElem = arr[i + 1];
;;      int div = DIV(firstElem, secondElem);
;;      int offset = MAX(firstElem, secondElem);
;;      arr[i + offset] = div;
;;      i += 2;
;;   }
;; }


.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START MAX SUBROUTINE
MAX

;buildup stack
ADD R6, R6, #-4  ; make space for RA, RV, old FP and one local variable
STR R7, R6, #2   ; save RA
STR R5, R6, #1   ; save old FP
ADD R5, R6, #0   ; point FP to local variable
ADD R6, R6, #-5  ; make space for all five registers R0-R4
; save registers
STR R0, R6, #0
STR R1, R6, #1
STR R2, R6, #2
STR R3, R6, #3
STR R4, R6, #4


LDR R0, R5, #4 ;set R0 = a, arg 1
LDR R1, R5, #5 ;set R1 = b, arg 2
;;   if (a > b) {
;;       return 0;
;;   } else {
;;       return 1;
;;   }

NOT R2, R1
ADD R2, R2, #1 ;R2 = -b
ADD R2, R0, R2 ;R2 = a-b
;if a-b is positive, then a>b
BRnz ELSE1
AND R0, R0, #0 ;R0 = 0, the return value
BR TEARDOWN1

ELSE1 NOP ;else block
AND R0, R0, #0
ADD R0, R0, #1 ;R0 = 1, the return value


TEARDOWN1 ;teardown stack
STR R0, R5, #3 ; sets R0 to return value
; restoring the value of registers
LDR R0, R6, #0
LDR R1, R6, #1
LDR R2, R6, #2
LDR R3, R6, #3
LDR R4, R6, #4
; restoring RA, FP, move R6 to RV
ADD R6, R6, #6 ;moves R6 to old FP
LDR R5, R6, #0
LDR R7, R6, #1
ADD R6, R6, #2


; !!!!! WRITE YOUR CODE HERE !!!!!



RET
; END MAX SUBROUTINE




; START DIV SUBROUTINE
DIV

;buildup stack
ADD R6, R6, #-4  ; make space for RA, RV, old FP and one local variable
STR R7, R6, #2   ; save RA
STR R5, R6, #1   ; save old FP
ADD R5, R6, #0   ; point FP to local variable
ADD R6, R6, #-5  ; make space for all five registers R0-R4
; save registers
STR R0, R6, #0
STR R1, R6, #1
STR R2, R6, #2
STR R3, R6, #3
STR R4, R6, #4


LDR R0, R5, #4 ;set R0 = x, arg 1
LDR R1, R5, #5 ;set R1 = y, arg 2
;;	   // (checkpoint 2) - Base Case
;;     if (y > x) {
;;         return 0;
;;     // (checkpoint 3) - Recursion
;;     } else {
;;         return 1 + DIV(x - y, y);
;;     }

NOT R2, R0
ADD R2, R2, #1 ;R2 = -x
ADD R2, R1, R2 ;R2 = y-x
;if y-x > 0, then y>x
BRp ENDSub1

;else block
NOT R2, R1
ADD R2, R2, #1 ;R2 = -y
ADD R2, R0, R2 ;R2 = x-y

ADD R6, R6, #-2  ; make space for two arguments
STR R2, R6, #0   ; pass the argument x-y onto stack in arg 1 spot
STR R1, R6, #1   ; pass the argument y onto stack in arg 2 spot


JSR DIV ;Jumps to the div subroutine
LDR R3, R6, #0   ; put RV into R3
ADD R6, R6, #3   ; move R6 back to the top of the stack

ADD R3, R3, #1 ;R3 = 1 + DIV(x-y,y)
ADD R0, R3, #0 ;R0 = R3, the return value
BR TEARDOWN2


ENDSub1 NOP
AND R0, R0, #0 ;R0 = 0, the return value

TEARDOWN2 ;teardown stack
STR R0, R5, #3 ; sets R0 to return value
; restoring the value of registers
LDR R0, R6, #0
LDR R1, R6, #1
LDR R2, R6, #2
LDR R3, R6, #3
LDR R4, R6, #4
; restoring RA, FP, move R6 to RV
ADD R6, R6, #6 ;moves R6 to old FP
LDR R5, R6, #0
LDR R7, R6, #1
ADD R6, R6, #2


; !!!!! WRITE YOUR CODE HERE !!!!!



RET
; END DIV SUBROUTINE



; START MAP SUBROUTINE
MAP

;buildup stack
ADD R6, R6, #-4  ; make space for RA, RV, old FP and one local variable
STR R7, R6, #2   ; save RA
STR R5, R6, #1   ; save old FP
ADD R5, R6, #0   ; point FP to local variable
ADD R6, R6, #-5  ; make space for all five registers R0-R4
; save registers
STR R0, R6, #0
STR R1, R6, #1
STR R2, R6, #2
STR R3, R6, #3
STR R4, R6, #4


LDR R0, R5, #4 ;set R0 = array, arg 1
LDR R1, R5, #5 ;set R1 = length, arg 2
;;   int i = 0;
;;   while (i < length) {
;;      int firstElem = arr[i];
;;      int secondElem = arr[i + 1];
;;      int div = DIV(firstElem, secondElem);
;;      int offset = MAX(firstElem, secondElem);
;;      arr[i + offset] = div;
;;      i += 2;
;;   }
AND R2, R2, #0 ;i = 0 <--

WHILE NOP
LDR R0, R5, #4 ;set R0 = array, arg 1
LDR R1, R5, #5 ;set R1 = length, arg 2
ADD R3, R1, #0
NOT R3, R3 ;R3 = -length
ADD R3, R3, R2 ;R3 = i-length
;if i-length < 0 then i < length
BRzp ENDWHILE
;while block
;R2 = i, R0 = addr of array[0]
    ADD R1, R0, R2 ;R1 = addr of array[i]
    LDR R3, R1, #0 ;R3 = firstElem = value of array[i]
    LDR R4, R1, #1 ;R4 = secondElem= value of array[i+1]

    ADD R6, R6, #-2  ; make space for two arguments
    STR R3, R6, #0   ; pass the argument firstElem onto stack in arg 1 spot
    STR R4, R6, #1   ; pass the argument secondElem onto stack in arg 2 spot

    JSR DIV ;Jumps to the div subroutine
    LDR R0, R6, #0   ; R0 = div = put RV into R0 <----
    ADD R6, R6, #3   ; move R6 back to the top of the stack


    ADD R6, R6, #-2  ; make space for two arguments
    STR R3, R6, #0   ; pass the argument firstElem onto stack in arg 1 spot
    STR R4, R6, #1   ; pass the argument secondElem onto stack in arg 2 spot

    JSR MAX ;Jumps to the max subroutine
    LDR R3, R6, #0   ; R3 = offset = put RV into R3
    ADD R6, R6, #3   ; move R6 back to the top of the stack


    ADD R1, R1, R3 ;R2 = addr of array[i+offset]
    STR R0, R1, #0 ;store div into array[i+offset]

    ADD R2, R2, #2 ;i += 2
    BR WHILE

ENDWHILE NOP


TEARDOWN3 ;teardown stack
STR R0, R5, #3 ; sets R0 to return value
; restoring the value of registers
LDR R0, R6, #0
LDR R1, R6, #1
LDR R2, R6, #2
LDR R3, R6, #3
LDR R4, R6, #4
; restoring RA, FP, move R6 to RV
ADD R6, R6, #6 ;moves R6 to old FP
LDR R5, R6, #0
LDR R7, R6, #1
ADD R6, R6, #2






; !!!!! WRITE YOUR CODE HERE !!!!!



RET
; END MAP SUBROUTINE


; LENGTH FOR TESTING

LENGTH .fill x12

; ARRAY FOR TESTING
ARRAY .fill x4000

.end

.orig x4000
.fill 12
.fill 3
.fill 5
.fill 7
.fill 16
.fill 2
.fill 5
.fill 5
.fill 25
.fill 7
.fill 48
.fill 60
.end

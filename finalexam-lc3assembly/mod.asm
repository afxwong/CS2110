;;=======================================
;; CS 2110 - Fall 2021
;; Final Exam - Modulo
;;=======================================
;; Name: Anthony Wong
;;=======================================

;; In this file, you must implement the 'mod' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in Complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'mod' label.


.orig x3000
HALT

mod
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of mod: integer a, positive integer b
;;
;; Pseudocode:
;; 
;; mod(a, b) {
;;     if (a < 0) {
;;         return mod(a + b, b);
;;     }
;;
;;     if (a < b) {
;;         return a;
;;     }
;;
;;     return mod(a - b, b);
;; }
;;
    
    
    ;; YOUR CODE HERE

;; Stack Prep
ADD	R6,	R6,	-4 ;; Advance ptr
STR	R7,	R6,	2 ;; Return Address
STR	R5,	R6,	1 ;; Frame ptr
ADD	R5,	R6,	0 ;; SP to FP
ADD	R6,	R6,	-5 ;; 5 registers
STR	R0,	R5,	-1 ;; R0
STR	R1,	R5,	-2 ;; R1
STR	R2,	R5,	-3 ;; R2
STR	R3,	R5,	-4 ;; R3
STR	R4,	R5,	-5 ;; R4

; get args
LDR R0, R5, 4 ;; R0 = a
LDR R1, R5, 5 ;; R1 = b

;;     if (a < 0) {
;;         return mod(a + b, b);
;;     }
ADD R0, R0, 0
BRzp IF2
ADD R2, R0, R1 ;; r2 = a+b
ADD R6, R6, -2 ;; make room in stack
STR	R2,	R6,	0 
STR R1, R6, 1
JSR mod
LDR	R3,	R6,	0 ;; r3 = ret val
ADD R6, R6, 3 ;; pop stack
BR TEARDOWN

;;     if (a < b) {
;;         return a;
;;     }
IF2 NOP
NOT	R2,	R1 ;; R2 = -b
ADD R2, R2, 1
ADD R2, R0, R2 ;; R2 = a-b
BRzp ELSE
ADD R3, R0, 0 ;; ret val = a
BR TEARDOWN

;;     return mod(a - b, b);
ELSE NOP
NOT	R2,	R1 ;; R2 = -b
ADD R2, R2, 1
ADD R2, R0, R2 ;; R2 = a-b
ADD R6, R6, -2 ;; make room in stack
STR	R2,	R6,	0 
STR R1, R6, 1
JSR mod
LDR	R3,	R6,	0 ;; r3 = ret val
ADD R6, R6, 3 ;; pop stack

;; Teardown
TEARDOWN
STR	R3,	R5,	3 ;; R3 to ret value

LDR R0, R5, -1 ;; R0
LDR R1, R5, -2 ;; R1
LDR R2, R5, -3 ;; R2
LDR R3, R5, -4 ;; R3
LDR R4, R5, -5 ;; R4
ADD	R6,	R5,	0 ;; Restore SP
LDR	R5,	R6,	1 ;; Restore FP
LDR R7, R6, 2 ;; Restore ret addr
ADD	R6,	R6,	3 ;; Pop callee items
RET

;; Needed by Simulate Subroutine Call in Complx
STACK .fill xF000
.end
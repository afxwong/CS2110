;;=======================================
;; CS 2110 - Fall 2021
;; HW6 - Collatz Conjecture
;;=======================================
;; Name: Anthony Wong
;;=======================================

;; In this file, you must implement the 'collatz' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in Complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'collatz' label.


.orig x3000
HALT

collatz
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of collatz: postive integer n
;;
;; Pseudocode:
;; collatz(int n) {
;;     if (n == 1) {
;;         return 0;
;;     }
;;     if (n % 2 == 0) {
;;         return collatz(n/2) + 1;
;;     } else {
;;         return collatz(3 * n + 1) + 1;
;;     }
;; }


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

;;     if (n == 1)
LDR R0, R5, 4 ;; R0 = n
ADD	R0,	R0,	-1
BRnp IFEVEN
;;         return 0;
AND	R0,	R0,	0
BR TEARDOWN

;;     if (n % 2 == 0)
IFEVEN
LDR	R1,	R5,	4 ;; R1 = n
AND	R1,	R1,	1
BRnp ELSE
;;         return collatz(n/2) + 1
    ;; get n/2
    LDR	R0,	R5,	4 ;; R0 = n
    ADD	R6,	R6,	-1
    STR	R0,	R6,	0
    JSR divideBy2
    LDR R1, R6, #0 ;R1 = n/2
    ADD R6, R6, #2

ADD	R6,	R6,	-1
STR	R1,	R6,	0
JSR	collatz
LDR R1, R6, 0 ;; return value in R1
ADD R6, R6, 2 ;; R6 back to the top of the stack
ADD	R0,	R1,	1 ;; add one to return
BR TEARDOWN
ELSE
;;         return collatz(3 * n + 1) + 1
LDR	R1,	R5,	4
ADD	R2,	R1,	R1
ADD	R1,	R2,	R1
ADD	R0,	R1,	1
ADD	R6,	R6,	-1
STR	R0,	R6,	0
JSR collatz
LDR R1, R6, 0 ;; return value in R1
ADD R6, R6, 2 ;; R6 back to the top of the stack
ADD	R0,	R1,	1 ;; add one to return
BR TEARDOWN


;; Teardown
TEARDOWN
STR	R0,	R5,	3 ;; R0 to ret value

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

;; The following is a subroutine that takes a single number n and returns n/2.
;; You may call this subroutine to help you with 'collatz'.

;; DO NOT CHANGE THIS SUBROUTINE IN ANY WAY
divideBy2
.fill x1DBC
.fill x7F82
.fill x7B81
.fill x1BA0
.fill x1DBB
.fill x7184
.fill x7383
.fill x7582
.fill x7781
.fill x7980
.fill x6144
.fill x5260
.fill x1020
.fill x0C03
.fill x103E
.fill x1261
.fill x0FFB
.fill x7343
.fill x6980
.fill x6781
.fill x6582
.fill x6383
.fill x6184
.fill x1D60
.fill x6B81
.fill x6F82
.fill x1DA3
.fill xC1C0


; Needed by Simulate Subroutine Call in Complx
STACK .fill xF000
.end
;; Timed Lab 3
;; Student Name: Anthony Wong

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

;;   if (a > b)
NOT R2, R1
ADD R2, R2, 1 ;; R2 = -b
ADD R2, R2, R0 ;; R2 = a - b
BRnz ELSE1
AND R0, R0, 0 ;; Ret val
BR TEARDOWN1

ELSE1
AND R0, R0, 0
ADD R0, R0, 1 ;; Ret val

;; Teardown
TEARDOWN1
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
; END MAX SUBROUTINE




; START DIV SUBROUTINE
DIV

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
LDR R0, R5, 4 ;; R0 = x
LDR R1, R5, 5 ;; R1 = y
;;     if (y > x)
NOT R2, R0
ADD R2, R2, 1 ;; R2 = -x
ADD R2, R2, R1 ;; R2 = -x + y
BRnz ELSE2
AND	R0,	R0,	0 ;; Ret val
BR TEARDOWN2

;;         return 1 + DIV(x - y, y);
ELSE2
NOT R2, R1 
ADD R2, R2, 1 ;; R2 = -y
ADD R2, R2, R0 ;; R2 = x - y

ADD R6, R6, -2 ;; make room in stack
STR R2, R6, 0 ;; R2 to stack
STR R1, R6, 1 ;; R1 to stack
JSR DIV
LDR	R3,	R6,	0 ;; R3 = return val
ADD R6, R6, 3 ;; pop stack
ADD	R0,	R3,	1 ;; R0 = return val + 1

;; Teardown
TEARDOWN2
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
; END DIV SUBROUTINE



; START MAP SUBROUTINE
MAP

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


;;   int i = 0;
;;   while (i < length) {
;;      int firstElem = arr[i];
;;      int secondElem = arr[i + 1];
;;      int div = DIV(firstElem, secondElem);
;;      int offset = MAX(firstElem, secondElem);
;;      arr[i + offset] = div;
;;      i += 2;
AND R2, R2, 0 ;; R2 = i = 0

WHILE
; get args
LDR R0, R5, 4 ;; R0 = array
LDR R1, R5, 5 ;; R1 = length

ADD R3, R1, 0 ;; R3 = length
NOT R3, R3
ADD R3, R3, 1 ;; R3 = -length
ADD R3, R3, R2 ;; R3 = i - length
BRzp ENDWHILE
ADD R1, R0, R2 ;; R1 = arr[i] address
LDR R3, R1, 0 ;; R3 = arr[i] val
LDR R4, R1, 1 ;; R4 = arr[i + 1] val

;; space for args
ADD R6, R6, -2
STR R3, R6, 0 ;; R3 to stack
STR R4, R6, 1 ;; R4 to stack
JSR DIV
LDR R0, R6, 0 ;; R0 = return val = div
ADD R6, R6, 3 ;; pop stack

ADD R6, R6, -2 ;; make room in stack
STR R3, R6, 0 ;; R3 to stack
STR R4, R6, 1 ;; R4 to stack
JSR MAX
LDR R3, R6, 0 ;; R3 = return val = offset
ADD R6, R6, 3 ;; pop stack

ADD R1, R3, R1 ;; R1 = arr[i + offset] address
STR R0, R1, 0 ;; div into arr[i + offset]

ADD	R2,	R2,	2 ;; i += 2
BR WHILE

ENDWHILE
;; Teardown
TEARDOWN3
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

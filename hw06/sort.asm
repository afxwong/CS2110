;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Selection Sort
;;=============================================================
;; Name: Anthony Wong
;;=============================================================

;; In this file, you must implement the 'SORT' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'sort' label.

.orig x3000
HALT

;;Pseudocode (see PDF for explanation)
;;  arr: memory address of the first element in the array
;;  n: integer value of the number of elements in the array
;;
;;  sort(array, len, function compare) {
;;      i = 0;
;;      while (i < len - 1) {
;;          j = i;
;;          k = i + 1;
;;          while (k < len) {
;;              // update j if ARRAY[j] > ARRAY[k]
;;              if (compare(ARRAY[j], ARRAY[k]) > 0) {
;;                  j = k;
;;              }
;;              k++
;;          }
;;          temp = ARRAY[i];
;;          ARRAY[i] = ARRAY[j];
;;          ARRAY[j] = temp;
;;          i++;
;;      }
;;  }

sort

;;YOUR CODE HERE

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

AND R0, R0, 0 ;; R0 = i = 0
;;      while (i < len - 1)
WHILE1 LDR	R1,	R5,	5 ;; R1 = len
NOT	R1,	R1
ADD	R3,	R1,	1 ;; R3 = -len
ADD R1, R3, R0 ;R1 = i - len
ADD R1, R1, #1 ;R1 = i - len + 1
BRzp TEARDOWN

ADD R1, R0, 0 ;; j = i
ADD R2, R0, 1 ;; k = i + 1
;;          while (k < len)
WHILE2 LDR	R3,	R5,	5 ;; R3 = len
NOT	R3,	R3
ADD	R3,	R3,	1 ;; R3 = -len
ADD R3, R3, R2
BRzp ENDW2
;;              if (compare(ARRAY[j], ARRAY[k]) > 0)
LDR R3, R5, #4 ;set R3 = array
ADD R4, R3, R1 ;R4 = addr of array[j]
LDR R4, R4, #0 ;R4 = value of array[j] <--
ADD R3, R3, R2 ;R3 = addr of array[k]
LDR R3, R3, #0 ;R3 = value of array[k] <--

ADD R6, R6, -2 ;; Space for args
STR R4, R6, #0 ;; pass the argument array[j] onto stack in arg 1 spot
STR R3, R6, #1 ;; pass the argument array[k] onto stack in arg 2 spot

LDR R3, R5, #6 ;; set R3 = compare, arg 3
JSRR R3 ;; Jumps to the compare subroutine
LDR R3, R6, #0 ;; put RV into R3
ADD R6, R6, #3 ;; move R6 back to the top of the stack
ADD R3, R3, 0 ;; set condition code
BRnz ENDIF
;;                  j = k;
ADD R1, R2, 0
ENDIF
;;              k++
ADD	R2,	R2,	1
BR WHILE2
ENDW2
;;          temp = ARRAY[i];
LDR	R2,	R5,	4 ;; R2 = array
ADD R3, R2, R0 ;; R3 = addr of array[i]
LDR R4, R3, 0 ;; R4 = temp
;;          ARRAY[i] = ARRAY[j];
ADD R2, R2, R1 ;; R2 = addr of array[j]
LDR R2, R2, #0 ;; R2 = value of array[j]
STR	R2,	R3,	0
;;          ARRAY[j] = temp;
LDR R2, R5, #4 ;set R2 = array, arg 1
ADD R2, R2, R1 ;R2 = addr of array[j]
STR	R4,	R2,	0
ADD	R0,	R0,	1
BR WHILE1

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

;; used by the autograder
STACK .fill xF000
.end

;; USE FOR DEBUGGING IN COMPLX
;; load array at x4000 and put the length as 7

;; ARRAY
.orig x4000
    .fill 4
    .fill -9
    .fill 0
    .fill -2
    .fill 9
    .fill 3
    .fill -10
.end

;; The following subroutine is the compare function that is passed  
;; as the function address parameter into the sorting function. It   
;; will work perfectly fine as long as you follow the   
;; convention on the caller's side. 
;; DO NOT edit the code below; it will be used by the autograder.   
.orig x5000 
    ;;greater than  
CMPGT   
    .fill x1DBD
    .fill x7180
    .fill x7381
    .fill x6183
    .fill x6384
    .fill x927F
    .fill x1261
    .fill x1201
    .fill x0C03
    .fill x5020
    .fill x1021
    .fill x0E01
    .fill x5020
    .fill x7182
    .fill x6180
    .fill x6381
    .fill x1DA2
    .fill xC1C0
    .fill x9241
.end
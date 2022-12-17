;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Array Modify
;;=============================================================
;; Name: Anthony Wong
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;;    i = 0; // first index 
;;    len = Len(ARR_X);
;;
;;    while (i < len) {
;;        if (i % 2 == 0) {
;;            //if we are at an even index, subtract 10 and save it to the array at that index 
;;    	    ARR_Y[i] = ARR_X[i] - 10];
;;        } else {
;;            //if we are at odd index, multiply by 2 and save it to the array at that index 
;;    	    ARR_Y[i] = ARR_X[i] * 2;
;;        }
;;        	i++;
;;    }

.orig x3000

;;put your code here

;;    i = 0; // first index 
AND	R0,	R0,	#0
;;    len = Len(ARR_X);
LD	R1,	LENGTH
;;    while (i < len)
STARTWHILE NOP
LD R1, LENGTH ;R1=LENGTH
ADD	R4,	R0,	#0 ;R4 = i
NOT	R1,	R1 ;2's comp
ADD	R1,	R1,	#1 ;2'scomp
ADD	R3,	R0,	R1 ;i - len
BRzp ENDWHILE
;;        if (i % 2 == 0)
STARTMODWHILE NOP
ADD	R4,	R4,	#0
BRz DIVBY2
ADD	R4,	R4,	#-2 ;subtract 2 until zero or negative
BRp STARTMODWHILE
BRz DIVBY2
BRn NOTDIVBY2
;;    	    ARR_Y[i] = ARR_X[i] - 10];
DIVBY2 NOP
LD	R5,	ARR_X ;R5 = leading address of ARR_X
ADD	R6,	R0,	#0 ;R6 = i
ADD	R5,	R5,	R6 ;R5 = address + i
LDR	R5,	R5,	#0 ;R5 = data at ARR_X[i]
ADD	R5,	R5,	#-10 ;R5 -= 10
LD R6, ARR_Y ;R6 = leading address of ARR_Y
ADD	R7,	R0,	#0 ;R7 = i
ADD R6, R6, R7 ;R6 = address + i
STR	R5,	R6,	#0 ;store val from x in y address
ADD	R0,	R0,	#1 ;i++
;;    	    ARR_Y[i] = ARR_X[i] * 2;
NOTDIVBY2 NOP
LD	R5,	ARR_X ;R5 = leading address of ARR_X
ADD	R6,	R0,	#0 ;R6 = i
ADD	R5,	R5,	R6 ;R5 = address + i
LDR	R5,	R5,	#0 ;R5 = data at ARR_X[i]
ADD	R5,	R5,	R5 ;R5 * 2
LD R6, ARR_Y ;R6 = leading address of ARR_Y
ADD	R7,	R0,	#0 ;R7 = i
ADD R6, R6, R7 ;R6 = address + i
STR	R5,	R6,	#0 ;store val from x in y address
ADD	R0,	R0,	#1 ;i++
BRnzp STARTWHILE
ENDWHILE NOP
HALT

ARR_X       .fill x4000
ARR_Y       .fill x4100
LENGTH      .fill 4
.end

.orig x4000
.fill 1
.fill 5
.fill 10
.fill 11
.end

.orig x4100
.blkw 4
.end

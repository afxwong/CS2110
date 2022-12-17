;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Toggle Case
;;=============================================================
;; Name: Anthony Wong
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;;	string = "Assembly is interesting"; // given string
;;	Array[string.len()] answer; // array to store the result string
;;	i = 0;
;;
;;	while (string[i] != '\0') {
;;	    if (string[i] == " ") {
;;	        answer[i] = " ";
;;	    } else if (string[i] >= "A" && string[i] <= "Z") {
;;	        answer[i] = string[i].lowerCase();
;;	    } else {
;;	        answer[i] = string[i].upperCase();
;;	    }
;;	    i++;
;;	}


.orig x3000


;; READ LINE 40
;; put your code here
AND	R0,	R0,	#0 ;i = 0
LD	R1,	STRING ;R1 = address of STRING[0]
LD	R2,	ANSWER ;R2 = address of ANSWER[0]

;;	while (string[i] != '\0')
WHILE ADD	R3,	R1,	R0 ;R3 = address of STRING[i]
ADD	R6,	R2,	R0 ;R6 = address of ANSWER[i]
LDR	R4,	R3,	#0 ;R4 = STRING[i]
ADD	R4,	R4,	#0
BRz ENDWHILE

IFSPACE LD	R5,	SPACE
NOT	R5,	R5
ADD	R5,	R5,	#1 ;-SPACE
ADD	R5,	R5,	R4
BRnp ELSE1
STR	R4,	R6,	#0 ;store space in R6
BR ENDIF
ELSE1 NOP
LD R5, A
NOT R5, R5
ADD	R5,	R5,	#1 ;-A
ADD	R5,	R4,	R5
BRn ELSE2
LD R5, Z
NOT R5, R5
ADD	R5,	R5,	#1 ;-Z
ADD	R5,	R4,	R5
BRp ELSE2
AND	R5,	R5,	#0
ADD	R5,	R4,	#15
ADD	R5,	R5,	#15
ADD	R5,	R5,	#2
STR	R5,	R6,	#0
BR ENDIF
ELSE2 NOP
AND	R5,	R5,	#0
ADD	R5,	R4,	#-15
ADD	R5,	R5,	#-15
ADD	R5,	R5,	#-2
STR	R5,	R6,	#0
ENDIF NOP
ADD	R0,	R0,	#1 ;i++
BR WHILE
ENDWHILE NOP
AND	R5,	R5,	#0
STR	R5,	R6,	#0
HALT


;; ASCII table: https://www.asciitable.com/


;; FILL OUT THESE ASCII CHARACTER VALUE FIRST TO USE IT IN YOUR CODE
SPACE	.fill x20
A		.fill x41
Z		.fill x5a
a       .fill x61
z       .fill x7a
BREAK	.fill x5D	;; this is the middle of uppercase and lowercase characters

STRING .fill x4000
ANSWER .fill x4100
.end

.orig x4000
.stringz "Assembly is INTERESTING"
.end

.orig x4100
.blkw 23
.end
;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Remove Vowels
;;=============================================================
;; Name: Anthony Wong
;;=============================================================

;; Pseudocode (see PDF for explanation)
;; STRING = (argument 1);
;; ANSWER = "";
;; for (int i = 0; i < a.length; i++) {
;;       if (string[i] == '\0'){
;;          break
;;        }

;;       if (string[i] == ’A’) {
;;           continue;
;;        } else if (string[i] == ’E’) {
;;            continue;
;;        } else if (string[i] == ’I’) {
;;            continue;
;;        } else if (string[i] == ’O’) {
;;            continue;
;;        } else if (string[i] == ’U’) {
;;            continue;
;;        } else if (string[i] == ’a’) {
;;            continue;
;;        } else if (string[i] == ’e’) {
;;            continue;
;;        } else if (string[i] == ’i’) {
;;            continue;
;;        } else if (string[i] == ’o’) {
;;            continue;
;;        } else if (string[i] == 'u') {
;;            continue;
;;        }
;;
;;        ANSWER += STRING[i];
;;	}
;;  ANSWER += '\0';
;;
;;  return ANSWER;
;; }

.orig x3000
;; STRING = (argument 1);
;; ANSWER = "";
LD	R1,	STRING ;R1 = input string address
LD	R2,	ANSWER ;R2 = answer address
AND	R0,	R0,	#0 ;init R0 = i = 0
ADD	R6,	R2,	R0 ;R6 = address of ANSWER[i]
;; for (int i = 0; i < a.length; i++)
WHILE ADD	R7,	R1,	R0 ;R7 = address of STRING[i]
LDR	R3,	R7,	#0 ;R3 = STRING[i]
ADD	R3,	R3,	#0
BRz ENDWHILE ;STRING[i] not null

IF1 LD	R4,	A
NOT	R4,	R4
ADD	R4,	R4,	#1 ;-A
ADD	R5,	R4,	R3 ;STRING[i] + -A
BRz CHARFOUND ;Is A

IF2 LD	R4,	E
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF3 LD	R4,	I
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF4 LD	R4,	O
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF5 LD	R4,	U
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF6 LD	R4,	LOWERA
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF7 LD	R4,	LOWERA
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF8 LD	R4,	LOWERE
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF9 LD	R4,	LOWERI
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF10 LD	R4,	LOWERO
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

IF11 LD	R4,	LOWERU
NOT	R4,	R4
ADD	R4,	R4,	#1
ADD	R5,	R4,	R3
BRz CHARFOUND

;;        ANSWER += STRING[i];
STR	R3,	R6,	#0
ADD R6, R6, #1

CHARFOUND NOP
ADD	R0,	R0,	#1 ;i++
BR WHILE
ENDWHILE NOP
;;  ANSWER += '\0';
STR	R3,	R6,	#0
HALT

STRING .fill x4000
ANSWER .fill x4100



;;NOTE: For your convenience, you can make new labels for
;;the ASCII values of other vowels here! 2 have been done
;;here as an example.

LOWERA .fill x61    ;; a in ASCII
LOWERE .fill x65
LOWERI .fill x69
LOWERO .fill x6f
LOWERU .fill x75

A .fill x41     ;; A in ASCII
E .fill x45
I .fill x49
O .fill x4f
U .fill x55


.end

.orig x4000

.stringz "spongebob and SQUIDWARD"

.end

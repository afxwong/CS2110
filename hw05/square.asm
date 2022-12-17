;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Square
;;=============================================================
;; Name: Anthony Wong
;;=============================================================

;; Pseudocode (see PDF for explanation)
;; a = (argument 1);
;; ANSWER = 0;
;; for (int i = 0; i < a; i++) {
;;		ANSWER += a;
;; }
;; return ANSWER;

.orig x3000

;;put your code here

;; a = (argument 1);
;; ANSWER = 0;
LD	R0,	A
LD	R1,	ANSWER
AND	R1,	R1,	#0
;; for (int i = 0; i < a; i++) {
;;		ANSWER += a;
;; }

;init I=0
AND	R3,	R3,	#0
ST	R3,	I
;test (i - a < 0)
STARTFOR NOP
LD	R4,	I
LD	R0,	A
NOT	R0,	R0
ADD	R0,	R0,	#1
ADD	R4,	R4,	R0
BRzp ENDFOR
;;		ANSWER += a;
LD	R0,	A
ADD	R1,	R1,	R0
;i++
LD	R3,	I
ADD	R3,	R3,	#1
ST	R3,	I
BRnzp STARTFOR
ENDFOR NOP
ST	R1,	ANSWER
HALT


A .fill 9
I .fill 0

ANSWER .blkw 1

.end

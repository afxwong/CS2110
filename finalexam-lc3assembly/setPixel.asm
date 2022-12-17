;;=============================================================
;; CS 2110 - Fall 2021
;; Final Exam - Set Pixel
;;=============================================================
;; Name: Anthony Wong
;;=============================================================

;; Pseudocode (see PDF for additional information)
;; 
;; offset = 0;
;; for (i = 0; i < ROW; i++) {
;;		offset += WIDTH;
;; }
;; offset += COL;
;; VIDEOBUFFER[offset] = COLOR

.orig x3000

;; YOUR CODE HERE
AND R0, R0, 0 ;; r0 = offset = 0
AND R1, R1, 0 ;; i = r1 = 0
LD	R3,	ROW ;; r3 = ROW

;; while ROW - i is positive
WHILE NOP
ADD R2, R1, 0 ;; r2 = i
NOT	R2,	R2 ;; r2 = -i
ADD R2, R2, 1
ADD R4, R3, R2 ;; r4 = row - i
BRnz END
LD R5, WIDTH ;; R5 = WIDTH
ADD R0, R5, R0 ;; offset += WIDTH
ADD R1, R1, 1 ;; i++
BR WHILE
END
LD R5, COL ;; R5 = COL
ADD R0, R5, R0 ;; offset += COL
LD R5, COLOR ;; R5 = color
LD R6, VIDEOBUFFER ;; R6 = addr of buffer
ADD	R6,	R6,	R0 ;; R6 = addr + offset
STR	R5,	R6,	0
HALT

COLOR .fill xFFFF
ROW .fill 1
COL .fill 1

HEIGHT .fill 2
WIDTH .fill 2

VIDEOBUFFER .fill x4000

.end

.orig x4000
    .fill 2
    .fill 1
    .fill 1
    .fill 0
.end
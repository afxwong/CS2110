;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Linked List Sum
;;=============================================================
;; Name: Anthony Wong
;;============================================================

;; In this file, you must implement the 'llsum' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseCopy' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of llsum: Node head
;;
;; llsum(Node head) {
;;     // note that a NULL address is the same thing as the value 0
;;     if (head == NULL) {
;;         return 0;
;;     }
;;     Node next = head.next;
;;     sum = head.data + llsum(next);
;;     return sum;
;; }

llsum

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

;;     if (head == NULL)
LDR	R0,	R5,	4
ADD	R0,	R0,	0 ;; set cc
BRnp ENDIF
BR END
ENDIF
LDR R1, R0, #0 ;; R1 = node.next
ADD	R6,	R6,	-1 ;; make space for arg
STR	R1,	R6,	0 ;; push node.next
JSR llsum
LDR	R2,	R6,	0 ;; R2 = llsum(next)
ADD	R6,	R6,	2 ;; pop arg and rv
ADD R3, R0, 1 ;; R3 = addr of node's data
LDR	R3,	R3,	0 ;; R3 = node's data
ADD	R0,	R3,	R2 ;; sum
BR TEARDOWN

END AND R0, R0, 0
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

;; The following is an example of a small linked list that starts at x4000.
;;
;; The first number (offset 0) contains the address of the next node in the
;; linked list, or zero if this is the final node.
;;
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill x4010
.fill 12
.end

.orig x4010
.fill 0
.fill -7
.end

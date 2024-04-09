;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: 
;;=============================================================


;; Pseudocode (see PDF for explanation)
;;
;;	int A[] = {1,2,3};
;;	int B[] = {-1, 7, 8};
;;	int C[3];
;;
;;	int i = 0;
;;
;;	while (i < A.length) {
;;		if (A[i] < B[i])
;;			C[i] = B[i];
;;		else
;;			C[i] = A[i];
;;
;;		i += 1;
;;	}


.orig x3000
	;; YOUR CODE HERE
	LD R0, A
	LD R1, B
	LD R2, C
	LD R3, LEN

WHILE_LOOP
    ADD R3, R3, #0
    BRnz END_WHILE_LOOP

    LDR R4, R0, #0
    LDR R5, R1, #0
    NOT R6, R5
    ADD R6, R6, #1

    ADD R6, R4, R6
    BRnz IF_STATEMENT

    STR R4, R2, #0
    BR END_IF

IF_STATEMENT
    STR R5, R2, #0
    BR END_IF

END_IF
    ADD R3, R3, #-1
    ADD R0, R0, #1
    ADD R1, R1, #1
    ADD R2, R2, #1
    BR WHILE_LOOP

END_WHILE_LOOP

HALT


A 	.fill x3200
B 	.fill x3300
C 	.fill x3400
LEN .fill 4

.end

.orig x3200
	.fill -1
	.fill 2
	.fill 7
	.fill -3
.end

.orig x3300
	.fill 3
	.fill 6
	.fill 0
	.fill 5
.end

.orig x3400
	.blkw 4
.end
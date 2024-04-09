;;=============================================================
;; CS 2110 - Fall 2022
;; Homework 5 - summation
;;=============================================================
;; Name: 
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;;    int result; (to save the summation of x)
;;    int x= -9; (given integer)
;;    int answer = 0;
;;    while (x > 0) {
;;        answer += x;
;;        x--;
;;    }
;;    result = answer;
.orig x3000

    AND R0, R0, 0   ; Clear R0
    LD R0, x        ; Load value of x into R0
    AND R1, R1, 0   ; Clear R1 (Will be answer)

    LOOP            ; Beginning of While Loop

    ADD R0, R0, #0  ; Use R0(x) as the loop condition
    BRnz END_LOOP   ; Loop will end when R0(x) is less than or equal to 0
    ADD R1, R1, R0  ; Sets R1 to R1(answer) + R0(x)
    ADD R0, R0, #-1 ; Decreases R0(x) for the next for loop

    BR LOOP

    END_LOOP

    ST R1, result   ; Stores the value in R1(answer) to the memory address represented by result

    HALT

    x .fill -9
    result .blkw 1

.end

;; YOUR CODE HERE


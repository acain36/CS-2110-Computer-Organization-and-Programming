;;=======================================
;; CS 2110 - Fall 2021
;; Final Exam - Modulo
;;=======================================
;; Name:
;;=======================================

;; In this file, you must implement the 'mod' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in Complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'mod' label.


.orig x3000
HALT

mod

;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of mod: integer a, positive integer b
;;
;; Pseudocode:
;; 
;; mod(a, b) {
;;     if (a < 0) {
;;         return mod(a + b, b);
;;     }
;;
;;     if (a < b) {
;;         return a;
;;     }
;;
;;     return mod(a - b, b);
;; }
;;
    
    
    ;; YOUR CODE HERE

;;STACK BUILDUP

ADD R6, R6, #-4
STR R7, R6, #2
STR R5, R6, #1

ADD R5, R6, #0
ADD R6, R6, #-6
STR R4, R6, #0
STR R3, R6, #1
STR R2, R6, #2
STR R3, R6, #3
STR R4, R6, #4

;; R0 = A 
;; R1 = B 

LDR R0, R5, #4
LDR R1, R5, #5

;; Check value of A 
;; If positive or zero, go to IF_2

ADD R0, R0, #0

BRpz IF_2

    ;; return mod(a + b, b);

    ADD R0, R0, R1      ;; R0 = A+B 

    ;; Push arg2 = B

    ADD R6, R6, #-1
    STR R1, R6, #0

    ;; Push arg1 = A + B

    ADD R6, R6, #-1
    STR R0, R6, #0

    JSR mod

    LDR R2, R6, #0      ;; R2 = mod(A + B, B)
    ADD R6, R6, #3      ;; Pop off 2 args and one return value

    STR R2, R5, #3      ;; Place R2 in the return value location

    BR END 

IF_2 

    ;;check a-b value aka b - a > 0 then go to ELSE 

    NOT R2, R0
    ADD R2, R2, #1

    ;; R2 = -A 

    ADD R2, R2, R1 

    ;; R2 = B-A 
    BRpz ELSE 

    STR R0, R5, #3      ;; Return a
    BR END

ELSE 
     ;; return mod(a + b, b);

    NOT R2, R1
    ADD R2, R2, #1
    ADD R0, R0, R2      ;; R0 = A-B 

    ;; Push arg2 = B

    ADD R6, R6, #-1
    STR R1, R6, #0

    ;; Push arg1 = A + B

    ADD R6, R6, #-1
    STR R0, R6, #0

    JSR mod

    LDR R2, R6, #0      ;; R2 = mod(A - B, B)
    ADD R6, R6, #3      ;; Pop off 2 args and one return value

    STR R2, R5, #3      ;; Place R2 in the return value location

    BR END 




END
RET

;; Needed by Simulate Subroutine Call in Complx
STACK .fill xF000
.end